import React, { useEffect, useRef } from 'react';
import mermaid from 'mermaid';

interface MermaidProps {
  data: { raw_syntax: string };
}

const MermaidViewer: React.FC<MermaidProps> = ({ data }) => {
  const containerRef = useRef<HTMLDivElement>(null);
  const renderId = useRef(`mermaid-${Math.random().toString(36).substr(2, 9)}`);

  useEffect(() => {
    mermaid.initialize({ 
      startOnLoad: false, 
      theme: 'dark',
      securityLevel: 'loose',
    });
    
    const renderGraph = async () => {
      if (containerRef.current && data.raw_syntax) {
        try {
          // Clear previous content
          containerRef.current.innerHTML = '';
          
          // Generate unique ID for this specific render call
          const id = `${renderId.current}-${Date.now()}`;
          const { svg } = await mermaid.render(id, data.raw_syntax);
          
          if (containerRef.current) {
            containerRef.current.innerHTML = svg;
          }
        } catch (error) {
          console.error("Mermaid render error:", error);
          if (containerRef.current) {
            containerRef.current.innerHTML = `
              <div class="text-red-500 p-4 border border-red-500 rounded">
                <p class="font-bold">Failed to render diagram</p>
                <pre class="text-xs mt-2">${error instanceof Error ? error.message : String(error)}</pre>
              </div>
            `;
          }
        }
      }
    };
    renderGraph();
  }, [data.raw_syntax]);

  return <div ref={containerRef} className="w-full h-full flex justify-center items-center overflow-auto" />;
};

export default MermaidViewer;
