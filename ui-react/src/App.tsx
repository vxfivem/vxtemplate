import { useGameState } from './game';

function App() {
  const isPaused = useGameState<boolean>('game:isPaused', false);

  return <div style={isPaused ? { display: 'none' } : {}} className="app" />;
}

export default App;
