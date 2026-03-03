// cityscapeLayoutWorker.js
// Offloads spatial layout calculations from the main thread.

self.onmessage = function(e) {
  const payload = e.data;
  if (!payload) return;

  const data = payload.payload || payload.data || payload;
  const { nodes, edges } = data;
  
  if (!nodes) return;

  // 1. Group nodes by asset_type
  const groups = {};
  nodes.forEach(node => {
    if (!groups[node.asset_type]) {
      groups[node.asset_type] = {
        nodes: [],
        x: 0,
        z: 0
      };
    }
    groups[node.asset_type].nodes.push(node);
  });
  
  // 2. Arrange groups in a circle
  const assetTypes = Object.keys(groups);
  const RADIUS = 150;
  assetTypes.forEach((type, i) => {
    const angle = (i / assetTypes.length) * Math.PI * 2;
    groups[type].x = Math.cos(angle) * RADIUS;
    groups[type].z = Math.sin(angle) * RADIUS;
  });
  
  // 3. Arrange nodes within groups
  const finalNodes = [];
  const nodeIndexMap = {};

  nodes.forEach((node) => {
    const group = groups[node.asset_type];
    const nodesInGroup = group.nodes;
    const nodeIdx = nodesInGroup.indexOf(node);
    
    // Grid within group
    const nodeGridSize = Math.ceil(Math.sqrt(nodesInGroup.length));
    const NODE_SPACING = 30;
    
    const row = Math.floor(nodeIdx / nodeGridSize);
    const col = nodeIdx % nodeGridSize;
    
    const x = group.x + (col - nodeGridSize / 2) * NODE_SPACING;
    const z = group.z + (row - nodeGridSize / 2) * NODE_SPACING;
    
    // Scale height by volume
    const height = Math.max(10, (node.volume || 50) / 2);
    
    // Scale heat to Color
    const heatFactor = Math.min(1, (node.heat || 0) / 50);
    const color = interpolateColor("#3498db", "#e74c3c", heatFactor);
    
    const nodeData = {
      id: node.id,
      asset_type: node.asset_type,
      x,
      y: height / 2,
      z,
      width: 15,
      height,
      depth: 15,
      color,
      volume: node.volume,
      heat: node.heat
    };
    
    finalNodes.push(nodeData);
    nodeIndexMap[node.id] = nodeData;
  });

  // 4. Resolve explicit edges
  const connections = [];
  if (edges) {
    edges.forEach(edge => {
      const source = nodeIndexMap[edge.source];
      const target = nodeIndexMap[edge.target];
      if (source && target) {
        connections.push({
          start: [source.x, source.height, source.z],
          end: [target.x, target.height, target.z],
          label: edge.label
        });
      }
    });
  }

  self.postMessage({ nodes: finalNodes, connections, districts: groups });
};

function interpolateColor(color1, color2, factor) {
  const hex = (c) => {
    const s = Math.round(c).toString(16);
    return s.length === 1 ? '0' + s : s;
  };
  const r1 = parseInt(color1.substring(1, 3), 16);
  const g1 = parseInt(color1.substring(3, 5), 16);
  const b1 = parseInt(color1.substring(5, 7), 16);
  const r2 = parseInt(color2.substring(1, 3), 16);
  const g2 = parseInt(color2.substring(3, 5), 16);
  const b2 = parseInt(color2.substring(5, 7), 16);
  const r = r1 + factor * (r2 - r1);
  const g = g1 + factor * (g2 - g1);
  const b = b1 + factor * (b2 - b1);
  return "#" + hex(r) + hex(g) + hex(b);
}
