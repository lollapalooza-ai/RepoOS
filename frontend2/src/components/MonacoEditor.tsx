import React from 'react';
import Editor from '@monaco-editor/react';

interface EditorProps {
  data: { file_path: string, content: string, language?: string };
  session: string;
  sendIntent: Function;
}

const MonacoEditor: React.FC<EditorProps> = ({ data }) => {
  return (
    <div className="h-full flex flex-col">
      <div className="flex justify-between items-center mb-2">
        <h3 className="text-lg font-bold font-mono text-blue-400">{data.file_path}</h3>
      </div>
      
      <div className="flex-1 border border-gray-700 rounded overflow-hidden">
        <Editor
          height="100%"
          defaultLanguage={data.language || "python"}
          defaultValue={data.content}
          theme="vs-dark"
          options={{
            minimap: { enabled: true },
            fontSize: 14,
            automaticLayout: true,
          }}
        />
      </div>
    </div>
  );
};

export default MonacoEditor;
