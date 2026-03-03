import React, { useEffect, useState, useRef, Suspense } from 'react';

const CityscapeCanvas = React.lazy(() => import('./CityscapeCanvas'));

interface CityscapeViewProps {
  data: any;
  sendIntent: (intent: any) => void;
}

export const CityscapeView: React.FC<CityscapeViewProps> = ({ data, sendIntent }) => {
  const [layoutData, setLayoutData] = useState<any>(null);
  const [isLLMGenerating, setIsLLMGenerating] = useState(false);
  const [tooltip, setTooltip] = useState<{ x: number, y: number, content: string } | null>(null);
  const [edgeLabels, setEdgeLabels] = useState<any[]>([]);
  const workerRef = useRef<Worker | null>(null);

  useEffect(() => {
    // Initialize Worker
    workerRef.current = new Worker(new URL('../../workers/cityscapeLayoutWorker.js', import.meta.url));
    
    workerRef.current.onmessage = (e) => {
      setLayoutData(e.data);
    };

    if (data) {
      workerRef.current.postMessage(data);
    }

    return () => {
      workerRef.current?.terminate();
    };
  }, [data]);

  // Handle LLM generating state via custom event or global state
  useEffect(() => {
    const handleLLMState = (e: any) => {
      if (e.detail?.type === 'LLM_GENERATING') {
        setIsLLMGenerating(e.detail.value);
      }
    };
    window.addEventListener('repo-os-llm-state', handleLLMState);
    return () => window.removeEventListener('repo-os-llm-state', handleLLMState);
  }, []);

  if (!layoutData) {
    return (
      <div className="flex flex-col items-center justify-center h-full text-gray-400 bg-black">
        <div className="text-xl mb-2 animate-pulse">Constructing Semantic Cityscape...</div>
        <div className="text-xs uppercase tracking-widest">Applying Architectural Metaphors</div>
      </div>
    );
  }

  return (
    <div className="relative w-full h-full bg-black overflow-hidden">
      <Suspense fallback={
        <div className="flex items-center justify-center h-full text-white">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-white"></div>
        </div>
      }>
        <CityscapeCanvas 
          data={layoutData} 
          pauseRender={isLLMGenerating} 
          onHover={(info) => setTooltip(info)}
          onLabels={(labels) => setEdgeLabels(labels)}
          onClick={(fileId) => {
            // Dispatch intent to open file
            sendIntent({ 
              type: 'USER_PROMPT', 
              payload: { text: `Open ${fileId}` } 
            });
          }}
        />
      </Suspense>

      {/* Floating Edge Labels */}
      {edgeLabels.map((label, i) => label.visible && (
        <div 
          key={i}
          className="absolute z-40 bg-black/60 text-cyan-400 px-2 py-1 rounded text-[10px] font-bold border border-cyan-500/30 whitespace-nowrap pointer-events-none"
          style={{ left: label.x, top: label.y, transform: 'translate(-50%, -50%)' }}
        >
          {label.text}
        </div>
      ))}

      {/* 2D Overlay for Tooltips */}
      {tooltip && (
        <div 
          className="absolute z-50 bg-gray-900 text-white p-3 rounded shadow-2xl pointer-events-none border border-blue-500/30 backdrop-blur-md"
          style={{ left: tooltip.x + 15, top: tooltip.y + 15 }}
        >
          <div className="text-[10px] text-blue-400 font-mono uppercase mb-1">Asset Identity</div>
          <div className="font-bold text-sm truncate max-w-xs">{tooltip.content}</div>
          <div className="mt-2 flex flex-col gap-1 text-[10px] text-gray-400">
             <span>TYPE: {layoutData.nodes.find((n:any) => n.id === tooltip.content)?.asset_type}</span>
             <span>VOLUME: {layoutData.nodes.find((n:any) => n.id === tooltip.content)?.volume}</span>
             <span>HEAT: {layoutData.nodes.find((n:any) => n.id === tooltip.content)?.heat}</span>
          </div>
        </div>
      )}

      {/* Memory Governor Indicator */}
      {isLLMGenerating && (
        <div className="absolute top-6 left-1/2 transform -translate-x-1/2 bg-red-900/80 text-red-200 px-6 py-2 rounded-full border border-red-500/50 backdrop-blur-sm flex items-center gap-3">
          <div className="w-2 h-2 bg-red-500 rounded-full animate-ping"></div>
          <span className="text-xs font-bold uppercase tracking-tighter">LLM Generating - Engine Throttled</span>
        </div>
      )}

      {/* Stats Overlay */}
      <div className="absolute bottom-6 left-6 text-white/50 text-[10px] font-mono pointer-events-none">
        <div>TOTAL_ASSETS: {layoutData.nodes.length}</div>
        <div>DOMAINS: {Object.keys(layoutData.districts).length}</div>
        <div>RENDER_MODE: SEMANTIC_METAPHOR_3D</div>
      </div>
    </div>
  );
};

export default CityscapeView;
