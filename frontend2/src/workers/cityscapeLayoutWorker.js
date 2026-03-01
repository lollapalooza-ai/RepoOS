// cityscapeLayoutWorker.js
// Offloads spatial layout calculations from the main thread.

self.onmessage = function(e) {
  const payload = e.data;
  if (!payload) return;

  // Extract data from either payload.payload (if the whole intent was sent) or directly
  const data = payload.payload || payload.data || payload;
  const { districts, nodes } = data;
  
  if (!districts || !nodes) return;
  
  // 1. Group nodes by district
  const districtMap = {};
  districts.forEach(d => {
    districtMap[d] = {
      nodes: [],
      x: 0,
      z: 0
    };
  });
  
  nodes.forEach(node => {
    if (districtMap[node.district]) {
      districtMap[node.district].nodes.push(node);
    }
  });
  
  // 2. Calculate district grid
  const districtCount = districts.length;
  const districtGridSize = Math.ceil(Math.sqrt(districtCount));
  const DISTRICT_SPACING = 150; // Large spacing between folders
  
  districts.forEach((d, i) => {
    const row = Math.floor(i / districtGridSize);
    const col = i % districtGridSize;
    districtMap[d].x = (col - districtGridSize / 2) * DISTRICT_SPACING;
    districtMap[d].z = (row - districtGridSize / 2) * DISTRICT_SPACING;
  });
  
  // 3. Arrange nodes within districts
  const finalNodes = [];
  const nodeIndexMap = {};

  nodes.forEach((node, i) => {
    const district = districtMap[node.district];
    const nodesInDistrict = district.nodes;
    const nodeIdx = nodesInDistrict.indexOf(node);
    
    const nodeGridSize = Math.ceil(Math.sqrt(nodesInDistrict.length));
    const NODE_SPACING = 20; // Spacing between buildings
    
    const row = Math.floor(nodeIdx / nodeGridSize);
    const col = nodeIdx % nodeGridSize;
    
    // Position building relative to district center
    const x = district.x + (col - nodeGridSize / 2) * NODE_SPACING;
    const z = district.z + (row - nodeGridSize / 2) * NODE_SPACING;
    
    // Scale height by LOC (Lines of Code)
    const height = Math.max(5, node.loc / 10);
    
    // Scale complexity (0-20+) to Color
    // Low complexity = Green (#2ecc71), High = Red (#e74c3c)
    const complexityFactor = Math.min(1, node.complexity / 30);
    const color = interpolateColor("#2ecc71", "#e74c3c", complexityFactor);
    
    const nodeData = {
      id: node.id,
      x,
      y: height / 2, // Center Y for box geometry
      z,
      width: 8,
      height,
      depth: 8,
      color,
      loc: node.loc,
      complexity: node.complexity,
      dependencies: node.dependencies || []
    };
    
    finalNodes.push(nodeData);
    nodeIndexMap[node.id] = nodeData;
  });

  // 4. Resolve dependencies for lines
  const connections = [];
  nodes.forEach(sourceNode => {
    if (sourceNode.dependencies) {
      sourceNode.dependencies.forEach(targetId => {
        if (nodeIndexMap[sourceNode.id] && nodeIndexMap[targetId]) {
          connections.push({
            start: [nodeIndexMap[sourceNode.id].x, nodeIndexMap[sourceNode.id].height, nodeIndexMap[sourceNode.id].z],
            end: [nodeIndexMap[targetId].x, nodeIndexMap[targetId].height, nodeIndexMap[targetId].z]
          });
        }
      });
    }
  });

  self.postMessage({ nodes: finalNodes, connections, districts: districtMap });
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
