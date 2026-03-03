import React, { useEffect, useRef } from 'react';
import { CityscapeRenderer } from '../../three/CityscapeRenderer';
import type { CityscapeData } from '../../three/CityscapeRenderer';

interface CityscapeCanvasProps {
  data: CityscapeData;
  pauseRender: boolean;
  onHover: (info: { x: number, y: number, content: string } | null) => void;
  onClick: (id: string) => void;
  onLabels: (labels: any[]) => void;
}

const CityscapeCanvas: React.FC<CityscapeCanvasProps> = ({ data, pauseRender, onHover, onClick, onLabels }) => {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const rendererRef = useRef<CityscapeRenderer | null>(null);

  useEffect(() => {
    if (!canvasRef.current || rendererRef.current) return;
    if (canvasRef.current.clientWidth === 0 || canvasRef.current.clientHeight === 0) return;

    const initTimeout = setTimeout(() => {
      try {
        if (canvasRef.current) {
          rendererRef.current = new CityscapeRenderer(canvasRef.current, onHover, onClick, onLabels);
          rendererRef.current.setData(data);
        }
      } catch (err) {
        console.error("Failed to initialize CityscapeRenderer:", err);
      }
    }, 100);

    return () => {
      clearTimeout(initTimeout);
      rendererRef.current?.destroy();
      rendererRef.current = null;
    };
  }, []);

  useEffect(() => {
    if (rendererRef.current) {
      rendererRef.current.setData(data);
    }
  }, [data]);

  useEffect(() => {
    if (rendererRef.current) {
      rendererRef.current.setPause(pauseRender);
    }
  }, [pauseRender]);

  return <canvas ref={canvasRef} className="w-full h-full outline-none" />;
};

export default CityscapeCanvas;
