import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';

export interface CityscapeData {
  nodes: Array<{
    id: string;
    x: number;
    y: number;
    z: number;
    width: number;
    height: number;
    depth: number;
    color: string;
    loc: number;
    complexity: number;
  }>;
  connections: Array<{
    start: [number, number, number];
    end: [number, number, number];
  }>;
  districts: Record<string, { x: number, z: number }>;
}

export class CityscapeRenderer {
  private scene: THREE.Scene;
  private camera: THREE.PerspectiveCamera;
  private renderer: THREE.WebGLRenderer;
  private controls: OrbitControls;
  private instancedMesh: THREE.InstancedMesh | null = null;
  private raycaster: THREE.Raycaster;
  private mouse: THREE.Vector2;
  private animationFrameId: number | null = null;
  private onHover: (info: { x: number, y: number, content: string } | null) => void;
  private onClick: (id: string) => void;
  private isPaused: boolean = false;

  constructor(
    canvas: HTMLCanvasElement,
    onHover: (info: { x: number, y: number, content: string } | null) => void,
    onClick: (id: string) => void
  ) {
    this.onHover = onHover;
    this.onClick = onClick;

    this.scene = new THREE.Scene();
    this.scene.background = new THREE.Color(0x050505);
    this.scene.fog = new THREE.Fog(0x050505, 100, 1000);

    this.camera = new THREE.PerspectiveCamera(75, canvas.clientWidth / canvas.clientHeight, 0.1, 2000);
    this.camera.position.set(200, 200, 200);

    // Defensive Context Check
    const gl = canvas.getContext('webgl2') || canvas.getContext('webgl');
    if (!gl) {
      throw new Error("Browser does not support WebGL");
    }

    try {
      this.renderer = new THREE.WebGLRenderer({ 
        canvas, 
        antialias: false,
        powerPreference: "high-performance",
        precision: "lowp", // Use lower precision to save GPU memory
        alpha: true,
        stencil: false,
        depth: true
      });
    } catch (e) {
      console.error("Three.js WebGLRenderer constructor failed:", e);
      throw e;
    }

    // Handle M4 Context Loss
    canvas.addEventListener('webglcontextlost', (event) => {
      event.preventDefault();
      console.warn("Cityscape: WebGL Context Lost. Throttling engine.");
      this.destroy();
    }, false);
    this.renderer.setSize(canvas.clientWidth, canvas.clientHeight);
    this.renderer.setPixelRatio(window.devicePixelRatio);

    this.controls = new OrbitControls(this.camera, canvas);
    this.controls.enableDamping = true;

    this.raycaster = new THREE.Raycaster();
    this.mouse = new THREE.Vector2();

    const ambientLight = new THREE.AmbientLight(0xffffff, 0.4);
    this.scene.add(ambientLight);

    const directionalLight = new THREE.DirectionalLight(0xffffff, 0.8);
    directionalLight.position.set(1, 1, 1);
    this.scene.add(directionalLight);

    window.addEventListener('mousemove', this.onMouseMove);
    window.addEventListener('click', this.onMouseClick);
    window.addEventListener('resize', this.onWindowResize);

    this.animate();
  }

  private onMouseMove = (event: MouseEvent) => {
    const rect = this.renderer.domElement.getBoundingClientRect();
    this.mouse.x = ((event.clientX - rect.left) / rect.width) * 2 - 1;
    this.mouse.y = -((event.clientY - rect.top) / rect.height) * 2 + 1;
  };

  private onMouseClick = () => {
    if (!this.instancedMesh) return;
    this.raycaster.setFromCamera(this.mouse, this.camera);
    const intersects = this.raycaster.intersectObject(this.instancedMesh);
    if (intersects.length > 0) {
      const instanceId = intersects[0].instanceId;
      if (instanceId !== undefined) {
        const nodeId = this.instancedMesh.userData.ids[instanceId];
        this.onClick(nodeId);
      }
    }
  };

  private onWindowResize = () => {
    const canvas = this.renderer.domElement;
    this.camera.aspect = canvas.clientWidth / canvas.clientHeight;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(canvas.clientWidth, canvas.clientHeight);
  };

  public setData(data: CityscapeData) {
    this.clearScene();

    if (data.nodes.length === 0) return;

    // 1. Instanced Mesh for Buildings
    const geometry = new THREE.BoxGeometry(1, 1, 1);
    const material = new THREE.MeshPhongMaterial({ shininess: 100 });
    
    this.instancedMesh = new THREE.InstancedMesh(geometry, material, data.nodes.length);
    this.instancedMesh.userData.ids = data.nodes.map(n => n.id);
    
    const matrix = new THREE.Matrix4();
    const color = new THREE.Color();
    const box = new THREE.Box3();

    data.nodes.forEach((node, i) => {
      matrix.makeScale(node.width, node.height, node.depth);
      matrix.setPosition(node.x, node.y, node.z);
      this.instancedMesh!.setMatrixAt(i, matrix);
      
      color.set(node.color);
      this.instancedMesh!.setColorAt(i, color);

      // Expand bounding box for camera fitting
      box.expandByPoint(new THREE.Vector3(node.x, 0, node.z));
      box.expandByPoint(new THREE.Vector3(node.x, node.height, node.z));
    });

    this.scene.add(this.instancedMesh);

    // 2. Districts Ground
    Object.entries(data.districts).forEach(([name, pos]) => {
      const groundGeo = new THREE.PlaneGeometry(120, 120);
      const groundMat = new THREE.MeshPhongMaterial({ color: 0x111111, side: THREE.DoubleSide });
      const ground = new THREE.Mesh(groundGeo, groundMat);
      ground.rotation.x = Math.PI / 2;
      ground.position.set(pos.x, 0, pos.z);
      this.scene.add(ground);
    });

    // 3. Connections
    const linePoints: THREE.Vector3[] = [];
    data.connections.forEach(conn => {
      linePoints.push(new THREE.Vector3(...conn.start));
      linePoints.push(new THREE.Vector3(...conn.end));
    });

    if (linePoints.length > 0) {
      const lineGeo = new THREE.BufferGeometry().setFromPoints(linePoints);
      const lineMat = new THREE.LineBasicMaterial({ color: 0x4444ff, transparent: true, opacity: 0.2 });
      const lines = new THREE.LineSegments(lineGeo, lineMat);
      this.scene.add(lines);
    }

    // 4. Fit Camera to Screen
    const center = new THREE.Vector3();
    box.getCenter(center);
    const size = new THREE.Vector3();
    box.getSize(size);

    const maxDim = Math.max(size.x, size.z);
    const fov = this.camera.fov * (Math.PI / 180);
    let cameraDistance = Math.abs(maxDim / 2 / Math.tan(fov / 2));
    
    // Position camera at an angle
    cameraDistance *= 1.5; 
    this.camera.position.set(center.x + cameraDistance, center.y + cameraDistance, center.z + cameraDistance);
    this.camera.lookAt(center);
    this.controls.target.copy(center);
    this.controls.update();
  }

  public setPause(paused: boolean) {
    this.isPaused = paused;
  }

  private animate = () => {
    if (this.isPaused) {
      this.animationFrameId = requestAnimationFrame(this.animate);
      return;
    }

    this.animationFrameId = requestAnimationFrame(this.animate);
    this.controls.update();

    if (this.instancedMesh) {
      this.raycaster.setFromCamera(this.mouse, this.camera);
      const intersects = this.raycaster.intersectObject(this.instancedMesh);
      if (intersects.length > 0) {
        const instanceId = intersects[0].instanceId;
        if (instanceId !== undefined) {
          const nodeId = this.instancedMesh.userData.ids[instanceId];
          const rect = this.renderer.domElement.getBoundingClientRect();
          const x = ((this.mouse.x + 1) / 2) * rect.width;
          const y = (-(this.mouse.y - 1) / 2) * rect.height;
          this.onHover({ x, y, content: nodeId });
        }
      } else {
        this.onHover(null);
      }
    }

    this.renderer.render(this.scene, this.camera);
  };

  private clearScene() {
    this.scene.children.forEach(child => {
      if (child instanceof THREE.Mesh || child instanceof THREE.InstancedMesh || child instanceof THREE.LineSegments) {
        child.geometry.dispose();
        if (Array.isArray(child.material)) {
          child.material.forEach(m => m.dispose());
        } else {
          child.material.dispose();
        }
      }
    });
    this.scene.clear();
    // Re-add lights
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.4);
    this.scene.add(ambientLight);
    const directionalLight = new THREE.DirectionalLight(0xffffff, 0.8);
    directionalLight.position.set(1, 1, 1);
    this.scene.add(directionalLight);
  }

  public destroy() {
    if (this.animationFrameId) cancelAnimationFrame(this.animationFrameId);
    window.removeEventListener('mousemove', this.onMouseMove);
    window.removeEventListener('click', this.onMouseClick);
    window.removeEventListener('resize', this.onWindowResize);

    this.clearScene();
    this.renderer.dispose();
    this.renderer.forceContextLoss();
  }
}
