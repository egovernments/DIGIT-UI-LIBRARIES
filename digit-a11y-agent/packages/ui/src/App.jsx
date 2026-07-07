/**
 * Top-level routing.
 *
 * Day 5: bare shell with just the home page.
 * Day 6: adds progress + report routes.
 * Day 7: will extend report with full issue list + bbox overlay + export.
 */

import { Routes, Route, Navigate } from 'react-router-dom';
import { Layout } from './components/Layout.jsx';
import { Home } from './pages/Home.jsx';
import { ScanProgress } from './pages/ScanProgress.jsx';
import { ScanReport } from './pages/ScanReport.jsx';
import { SiteProgress } from './pages/SiteProgress.jsx';
import { SiteReport } from './pages/SiteReport.jsx';

export function App() {
  return (
    <Layout>
      <Routes>
        <Route path="/"                       element={<Home />} />
        <Route path="/scan/:scanId"           element={<ScanProgress />} />
        <Route path="/scan/:scanId/report"    element={<ScanReport />} />
        <Route path="/site/:siteId"           element={<SiteProgress />} />
        <Route path="/site/:siteId/report"    element={<SiteReport />} />
        <Route path="*"                       element={<Navigate to="/" replace />} />
      </Routes>
    </Layout>
  );
}
