import React, { Suspense } from 'react';
import type { IntentPayload } from '../hooks/useIntentSocket';

// Lazy load the heavy modules
const MermaidViewer = React.lazy(() => import('./MermaidViewer'));
const DiffEditor = React.lazy(() => import('./DiffEditor'));
const MonacoEditor = React.lazy(() => import('./MonacoEditor'));

const Registry: Record<string, React.FC<any>> = {
  MermaidViewer,
  DiffEditor,
  MonacoEditor,
};

export const DynamicComponent: React.FC<{ intent: IntentPayload, sendIntent: Function }> = ({ intent, sendIntent }) => {
  if (!intent.component_name || !Registry[intent.component_name]) {
    return <div className="text-gray-500">Awaiting intelligent routing...</div>;
  }

  const ComponentToMount = Registry[intent.component_name];

  return (
    <Suspense fallback={<div className="animate-pulse">Loading View...</div>}>
      <ComponentToMount data={intent.payload} session={intent.session_id} sendIntent={sendIntent} />
    </Suspense>
  );
};
