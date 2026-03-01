import React from 'react';
import { DiffEditor as MonacoDiff } from '@monaco-editor/react';

interface DiffProps {
  data: { file_path: string, original: string, proposed: string };
  session: string;
  sendIntent: Function;
}

const DiffEditor: React.FC<DiffProps> = ({ data, session, sendIntent }) => {
  
  const handleResolution = (decision: 'y' | 'n') => {
    sendIntent({
      type: 'RESOLVE_INTENT',
      session_id: session,
      decision: decision
    });
  };

  return (
    <div className="h-full flex flex-col">
      <div className="flex justify-between items-center mb-2">
        <h3 className="text-lg font-bold font-mono text-blue-400">{data.file_path}</h3>
        <div className="flex gap-2">
          <button onClick={() => handleResolution('n')} className="bg-red-600 px-4 py-1 rounded hover:bg-red-700 transition-colors">Reject</button>
          <button onClick={() => handleResolution('y')} className="bg-green-600 px-4 py-1 rounded hover:bg-green-700 transition-colors">Approve</button>
        </div>
      </div>
      
      <div className="flex-1 border border-gray-700 rounded overflow-hidden">
        <MonacoDiff
          original={data.original}
          modified={data.proposed}
          language="python"
          theme="vs-dark"
          options={{ readOnly: true, renderSideBySide: true }}
        />
      </div>
    </div>
  );
};

export default DiffEditor;
