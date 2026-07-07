import { runScan } from './src/index.js';
import { buildFriendlyReport } from '../reporter/src/index.js';
import { writeFileSync } from 'node:fs';

const STUDIO_USERNAME = 'STUDIOUAT';
const STUDIO_PASSWORD = 'eGov@123';

const raw = await runScan({
  url: 'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/LandingPage',
  auth: {
    type: 'form',
    contextStrategy: 'single',
    loginUrl: 'https://unified-uat.digit.org/digit-studio/employee/user/login',
    dismissSelectors: ['input[type="checkbox"]'],
    fields: {
      'input[type="text"]':     STUDIO_USERNAME,
      'input[type="password"]': STUDIO_PASSWORD,
    },
    submitSelector:  'button:has-text("Login")',
    successSelector: 'h1:has-text("Design and Launch Public Services")',
    timeouts: { navigation: 60_000, successWait: 60_000 },
  },
  options: { artifactsDir: './studio-uat-scan' },
});

const report = buildFriendlyReport(raw);

console.log('\n═══════════════════════════════════════════════');
console.log('  DIGIT STUDIO (UAT) — AUTHENTICATED DASHBOARD SCAN');
console.log('═══════════════════════════════════════════════');
console.log('  URL scanned:    ', raw.meta.url);
console.log('  Authenticated:  ', raw.meta.authenticated);
console.log('  Screenshot:     ', raw.screenshot?.path);
console.log();
console.log('  Score:          ', report.score, '/ 100 —', report.status);
console.log('  Total issues:   ', report.summary.totalIssues);
console.log('    Critical: ', report.summary.critical);
console.log('    Serious:  ', report.summary.serious);
console.log('    Moderate: ', report.summary.moderate);
console.log('    Minor:    ', report.summary.minor);
console.log();
console.log('  Standards:');
console.log('    WCAG:   ', report.standardsBreakdown.wcag.compliancePercent + '%');
console.log('    GIGW:   ', report.standardsBreakdown.gigw.compliancePercent + '%');
console.log('    SesMag: ', report.standardsBreakdown.sesmag.compliancePercent + '%');
console.log('    ADA:    ', report.standardsBreakdown.ada.compliancePercent + '%');
console.log();
console.log('  Top 5 violations:');
raw.violations.slice(0, 5).forEach((v) => {
  console.log('   -', v.impact.toUpperCase(), v.id, '→', v.nodes[0]?.target[0] || '(no target)');
});

writeFileSync('./studio-uat-scan/full-report.json', JSON.stringify(report, null, 2));
console.log('\n  Full report saved to: ./studio-uat-scan/full-report.json');