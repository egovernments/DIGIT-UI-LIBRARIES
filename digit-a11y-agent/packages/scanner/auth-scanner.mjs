import { runScan } from './src/index.js';
import { buildFriendlyReport } from '../reporter/src/index.js';
import { writeFileSync } from 'node:fs';

const raw = await runScan({
  url: 'https://health-demo.digit.org/console/employee',
  auth: {
    type: 'form',
    loginUrl: 'https://health-demo.digit.org/console/employee/user/login',
    dismissSelectors: ['input[type="checkbox"]'],
    fields: {
      'input[type="text"]': 'Shreya',
      'input[type="password"]': 'eGov@123',
    },
    submitSelector: 'button:has-text("Continue")',
    successSelector: 'text=HCM Console',   // the one that just worked
    timeouts: {
      navigation: 60_000,    // ← add this line
      successWait: 60_000,
    },    // give it 60s like the diagnostic
  },
  options: { artifactsDir: './final-auth-scan' },
});

const report = buildFriendlyReport(raw);

console.log('\n═══════════════════════════════════════════════');
console.log('  AUTHENTICATED DASHBOARD SCAN COMPLETE');
console.log('═══════════════════════════════════════════════');
console.log('  URL scanned (requested):', raw.meta.url);
console.log('  Authenticated:           ', raw.meta.authenticated);
console.log('  Screenshot saved to:     ', raw.screenshot?.path);
console.log();
console.log('  Score:                   ', report.score, '/ 100 —', report.status);
console.log('  Summary:                 ', report.summaryText);
console.log('  Total issues:            ', report.summary.totalIssues);
console.log('    Critical:              ', report.summary.critical);
console.log('    Serious:               ', report.summary.serious);
console.log('    Moderate:              ', report.summary.moderate);
console.log('    Minor:                 ', report.summary.minor);
console.log();
console.log('  Standards compliance:');
console.log('    WCAG:                  ', report.standardsBreakdown.wcag.compliancePercent + '%');
console.log('    GIGW:                  ', report.standardsBreakdown.gigw.compliancePercent + '%');
console.log('    SesMag:                ', report.standardsBreakdown.sesmag.compliancePercent + '%');
console.log('    ADA:                   ', report.standardsBreakdown.ada.compliancePercent + '%');
console.log();
console.log('  Top 3 violations on the dashboard:');
raw.violations.slice(0, 3).forEach((v) => {
  const sel = v.nodes[0]?.target[0] || '(no target)';
  console.log('    -', v.impact.toUpperCase(), v.id, '→', sel);
});

writeFileSync('./final-auth-scan/full-report.json', JSON.stringify(report, null, 2));
console.log('\n  Full report saved to: ./final-auth-scan/full-report.json');