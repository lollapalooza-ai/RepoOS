import { useEffect, useState, useRef } from 'react';

export interface IntentPayload {
  type: 'MOUNT_COMPONENT' | 'SYSTEM_NOTIFICATION';
  component_name?: string;
  status?: 'AWAITING_USER_ACTION' | 'RESOLVED';
  payload: any;
  session_id?: string;
}

export function useIntentSocket(url: string) {
  const [currentIntent, setCurrentIntent] = useState<IntentPayload | null>(null);
  const [isReady, setIsReady] = useState(false);
  const socketRef = useRef<WebSocket | null>(null);

  useEffect(() => {
    let timeoutId: number;

    const connect = () => {
      if (socketRef.current) return; // Prevent multiple connections

      console.log(`Connecting to WebSocket: ${url}`);
      const socket = new WebSocket(url);
      socketRef.current = socket;

      socket.onopen = () => {
        console.log('WebSocket Connected');
        setIsReady(true);
      };

      socket.onmessage = (event) => {
        try {
          const data = JSON.parse(event.data) as IntentPayload;
          console.log('Received intent:', data);
          if (data.type === 'MOUNT_COMPONENT' || data.type === 'SYSTEM_NOTIFICATION') {
            setCurrentIntent(data);
          }
        } catch (err) {
          console.error('Error parsing WebSocket message:', err);
        }
      };

      socket.onerror = (error) => {
        console.error('WebSocket Error:', error);
      };

      socket.onclose = (event) => {
        console.log('WebSocket Closed:', event.code, event.reason);
        setIsReady(false);
        socketRef.current = null;
      };
    };

    timeoutId = window.setTimeout(connect, 100);

    return () => {
      window.clearTimeout(timeoutId);
      // Only close if we are actually unmounting the whole component, 
      // not just re-rendering
    };
  }, [url]);

  const sendIntent = (message: any) => {
    if (socketRef.current?.readyState === WebSocket.OPEN) {
      socketRef.current.send(JSON.stringify(message));
    } else {
      console.warn('Socket not open, message not sent:', message);
    }
  };

  return { currentIntent, sendIntent, isReady };
}
