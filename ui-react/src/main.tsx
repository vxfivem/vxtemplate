import App from './App';
import { Provider } from 'react-redux';
import ReactDOM from 'react-dom/client';
import { appStore } from './store';

/// <reference types="vite-plugin-svgr/client" />

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <>
    <Provider store={appStore}>
      <App />
    </Provider>
  </>
);
