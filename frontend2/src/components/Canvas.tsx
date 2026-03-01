import React, { useState } from 'react';
import { useIntentSocket } from '../hooks/useIntentSocket';
import { DynamicComponent } from './ComponentRegistry';

export const Canvas: React.FC = () => {
  const { currentIntent, sendIntent } = useIntentSocket('ws://127.0.0.1:8765/ws');
  const [prompt, setPrompt] = useState("");
  const [notification, setNotification] = useState<string | null>(null);

  // Handle system notifications separately from component mounting
  React.useEffect(() => {
    if (currentIntent?.type === 'SYSTEM_NOTIFICATION') {
      setNotification(currentIntent.payload.message);
      const timer = setTimeout(() => setNotification(null), 5000);
      return () => clearTimeout(timer);
    }
  }, [currentIntent]);

  const handleUserPrompt = (e: React.FormEvent) => {
    e.preventDefault();
    if (!prompt.trim()) return;
    
    // Clear previous view if a new prompt is sent (optional, based on preference)
    // sendIntent({ type: 'CLEAR_VIEW' }); 
    
    // Emit user intent to the Python backend
    sendIntent({
      type: 'USER_PROMPT',
      payload: { text: prompt }
    });
    setPrompt("");
  };

  return (
    <div className="flex flex-col h-screen bg-gray-900 text-white">
      {/* Notification Banner */}
      {notification && (
        <div className="absolute top-4 right-4 z-50 bg-blue-600 text-white px-6 py-3 rounded-lg shadow-xl animate-bounce">
          {notification}
        </div>
      )}

      {/* Dynamic Viewport */}
      <div className="flex-1 overflow-hidden p-4 relative">
        {currentIntent?.type === 'MOUNT_COMPONENT' ? (
           <DynamicComponent intent={currentIntent} sendIntent={sendIntent} />
        ) : (
           <div className="flex h-full flex-col items-center justify-center text-gray-500">
             <div className="text-4xl mb-4 font-bold tracking-tighter">Repo OS</div>
             <div>Ready. What would you like to build?</div>
           </div>
        )}
      </div>

      {/* Command Input */}
      <div className="h-24 bg-gray-800 p-4 border-t border-gray-700">
        <form onSubmit={handleUserPrompt} className="flex gap-2 max-w-4xl mx-auto">
          <input 
            type="text" 
            value={prompt}
            onChange={(e) => setPrompt(e.target.value)}
            className="flex-1 bg-gray-700 rounded-lg p-3 outline-none focus:ring-2 focus:ring-blue-500 transition-all"
            placeholder="e.g. Edit search API to sort by cost..."
          />
          <button type="submit" className="bg-blue-600 hover:bg-blue-700 px-6 rounded-lg font-bold transition-colors">
            Execute
          </button>
        </form>
      </div>
    </div>
  );
};
