import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';

export interface CityscapeNode {
  id: string;
  asset_type: string;
  x: number;
  y: number;
  z: number;
  width: number;
  height: number;
  depth: number;
  color: string;
}

export interface CityscapeConnection {
  start: [number, number, number];
  end: [number, number, number];
  label: string;
}

export interface CityscapeData {
  nodes: CityscapeNode[];
  connections: CityscapeConnection[];
  districts: Record<string, { x: number, z: number }>;
}

export class CityscapeRenderer {
  private scene: THREE.Scene;
  private camera: THREE.PerspectiveCamera;
  private renderer: THREE.WebGLRenderer;
  private controls: OrbitControls;
  private raycaster: THREE.Raycaster;
  private mouse: THREE.Vector2;
  private animationFrameId: number | null = null;
  private onHover: (info: { x: number, y: number, content: string } | null) => void;
  private onClick: (id: string) => void;
  private isPaused: boolean = false;
  private labelCallback: (labels: any[]) => void;
  private connections: { curve: THREE.CatmullRomCurve3, label: string }[] = [];

  constructor(
    canvas: HTMLCanvasElement,
    onHover: (info: { x: number, y: number, content: string } | null) => void,
    onClick: (id: string) => void,
    labelCallback: (labels: any[]) => void
  ) {
    this.onHover = onHover;
    this.onClick = onClick;
    this.labelCallback = labelCallback;

    this.scene = new THREE.Scene();
    this.scene.background = new THREE.Color(0x050505);
    this.scene.fog = new THREE.Fog(0x050505, 100, 2000);

    this.camera = new THREE.PerspectiveCamera(75, canvas.clientWidth / canvas.clientHeight, 0.1, 5000);
    this.camera.position.set(400, 400, 400);

    const gl = canvas.getContext('webgl2') || canvas.getContext('webgl');
    if (!gl) throw new Error("WebGL not supported");

    try {
      this.renderer = new THREE.WebGLRenderer({ 
        canvas, 
        antialias: false,
        powerPreference: "high-performance",
        precision: "lowp",
        alpha: true 
      });
    } catch (e) {
      throw e;
    }
    
    this.renderer.setSize(canvas.clientWidth, canvas.clientHeight);
    this.renderer.setPixelRatio(window.devicePixelRatio);

    this.controls = new OrbitControls(this.camera, canvas);
    this.controls.enableDamping = true;

    this.raycaster = new THREE.Raycaster();
    this.mouse = new THREE.Vector2();

    this.scene.add(new THREE.AmbientLight(0xffffff, 0.5));
    const sun = new THREE.DirectionalLight(0xffffff, 1);
    sun.position.set(500, 500, 500);
    this.scene.add(sun);

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
    this.raycaster.setFromCamera(this.mouse, this.camera);
    const intersects = this.raycaster.intersectObjects(this.scene.children, true);
    if (intersects.length > 0) {
      const obj = intersects[0].object;
      if (obj.userData.id) this.onClick(obj.userData.id);
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
    this.connections = [];
    if (data.nodes.length === 0) return;

    const box = new THREE.Box3();

    data.nodes.forEach((node) => {
      let geometry: THREE.BufferGeometry;
      
      // Asset Type Mapping
      switch (node.asset_type) {
        case 'storefront':
          geometry = new THREE.ConeGeometry(node.width/2, node.height, 4);
          break;
        case 'database':
          geometry = new THREE.CylinderGeometry(node.width/2, node.width/2, node.height, 16);
          break;
        case 'external_api':
          geometry = new THREE.SphereGeometry(node.width/2, 16, 16);
          break;
        default: // back_office or other
          geometry = new THREE.BoxGeometry(node.width, node.height, node.depth);
      }

      const material = new THREE.MeshPhongMaterial({ 
        color: node.color,
        emissive: node.color,
        emissiveIntensity: 0.2,
        shininess: 50
      });
      
      const mesh = new THREE.Mesh(geometry, material);
      mesh.position.set(node.x, node.y, node.z);
      mesh.userData.id = node.id;
      this.scene.add(mesh);

      box.expandByPoint(new THREE.Vector3(node.x, 0, node.z));
      box.expandByPoint(new THREE.Vector3(node.x, node.height, node.z));
    });

    // Curved Lines (CatmullRom)
    data.connections.forEach(conn => {
      const start = new THREE.Vector3(...conn.start);
      const end = new THREE.Vector3(...conn.end);
      
      // Midpoint with arc height
      const mid = new THREE.Vector3().addVectors(start, end).multiplyScalar(0.5);
      mid.y += start.distanceTo(end) * 0.3; // Arch factor

      const curve = new THREE.CatmullRomCurve3([start, mid, end]);
      const points = curve.getPoints(50);
      const lineGeo = new THREE.BufferGeometry().setFromPoints(points);
      const lineMat = new THREE.LineBasicMaterial({ color: 0x00ffff, transparent: true, opacity: 0.4 });
      const line = new THREE.Line(lineGeo, lineMat);
      
      this.scene.add(line);
      this.connections.push({ curve, label: conn.label });
    });

    // Ground Planes for Districts
    Object.entries(data.districts).forEach(([name, pos]) => {
      const ground = new THREE.Mesh(
        new THREE.PlaneGeometry(150, 150),
        new THREE.MeshPhongMaterial({ color: 0x111111, side: THREE.DoubleSide })
      );
      ground.rotation.x = Math.PI / 2;
      ground.position.set(pos.x, 0, pos.z);
      this.scene.add(ground);
    });

    // Fit Camera
    const center = new THREE.Vector3();
    box.getCenter(center);
    const size = new THREE.Vector3();
    box.getSize(size);
    const maxDim = Math.max(size.x, size.z, 200);
    const camDist = maxDim * 2;
    this.camera.position.set(center.x + camDist, center.y + camDist, center.z + camDist);
    this.camera.lookAt(center);
    this.controls.target.copy(center);
    this.controls.update();
  }

  public setPause(paused: boolean) { this.isPaused = paused; }

  private animate = () => {
    this.animationFrameId = requestAnimationFrame(this.animate);
    if (this.isPaused) return;

    this.controls.update();

    // Project labels to screen space
    const screenLabels = this.connections.map(conn => {
      const midPoint = conn.curve.getPoint(0.5);
      const vector = midPoint.project(this.camera);
      
      const x = (vector.x + 1) / 2 * this.renderer.domElement.clientWidth;
      const y = -(vector.y - 1) / 2 * this.renderer.domElement.clientHeight;
      
      return { x, y, text: conn.label, visible: vector.z < 1 };
    });
    this.labelCallback(screenLabels);

    this.renderer.render(this.scene, this.camera);
  };

  private clearScene() {
    this.scene.children.forEach(child => {
      if (child instanceof THREE.Mesh || child instanceof THREE.Line) {
        child.geometry.dispose();
        if (Array.isArray(child.material)) child.material.forEach(m => m.dispose());
        else child.material.dispose();
      }
    });
    this.scene.clear();
    this.scene.add(new THREE.AmbientLight(0xffffff, 0.5));
    const sun = new THREE.DirectionalLight(0xffffff, 1);
    sun.position.set(500, 500, 500);
    this.scene.add(sun);
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
