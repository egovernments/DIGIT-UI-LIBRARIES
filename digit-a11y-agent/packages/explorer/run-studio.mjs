/**
 * Runnable: explore DIGIT Studio UAT (the 7 sitemap URLs) and write a scored
 * site report.
 *
 *   node run-studio.mjs
 *
 * Default is MANUAL login (a browser opens at the Studio login page; log in by
 * hand, then press ENTER). This is the most reliable path and needs no field
 * selectors. To try automated login instead (reuses the scanner's form auth):
 *
 *   AUTO_LOGIN=1 STUDIO_USER=STUDIOUAT STUDIO_PASS=eGov@123 node run-studio.mjs
 *
 * Options:
 *   HEADED=1          show the browser even in AUTO_LOGIN mode (manual is always headed)
 *   SITE_CONCURRENCY=N  scan N pages in parallel (AUTO_LOGIN only; manual stays sequential)
 *
 * Writes: site-report.json (the scored report). Add --debug (or DEBUG=1) to also
 * write exploration-raw.json (the raw per-state engine log, for debugging).
 */

import fs from 'node:fs';
import { exploreAndReport } from './src/index.js';

// A sitemap entry can be a plain URL string, or { url, ready } where `ready` is
// a selector confirming THAT page finished loading — the same rigor the
// single-page scanner uses. Plain strings fall back to the generic readiness
// heuristic. LandingPage uses the known post-login marker below as a live demo;
// add your own per-page selectors to make the others airtight too.
const SITEMAP = [
  'https://unified-uat.digit.org/digit-studio/employee/user/login',
  {
    url: 'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/LandingPage',
    ready: 'h1:has-text("Design and Launch Public Services")',
  },
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/create-service',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/create-module',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/create-form-Home?module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/form-builder?variant=app&masterName=FormBuilder&fieldType=FieldTypeMappingConfig&prefix=CMP-2025-07-24-006759&localeModule=APPONE&tenantId=st&campaignNumber=CMP-2025-07-24-006759&formId=default&projectType=Bednet&module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/Roles?module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE&edit=true',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/Workflow?module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE&edit=true',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/Checklist?module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE&edit=true',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/notifications?module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE&edit=true',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/Service-Builder-Home?module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE&edit=true',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/preview?module=Action&service=Preview&published=false',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/manage-users?module=test_perfor1&service=module_perfor_1',
  'https://unified-uat.digit.org/digit-studio/employee/publicservices/modules?selectedPath=Apply',
  'https://unified-uat.digit.org/digit-studio/employee/publicservices/test_perfor1/search?selectedModule=true&module=test_perfor1&service=module_perfor_1',
  'https://unified-uat.digit.org/digit-studio/employee/publicservices/test_perfor1/inbox',
  'https://unified-uat.digit.org/digit-studio/employee/publicservices/test_perfor1/module_perfor_1/Apply?serviceCode=...&selectedModule=true&module=test_perfor1&service=module_perfor_1',
  'https://unified-uat.digit.org/digit-studio/employee/publicservices/test_perfor1/module_perfor_1/ViewScreen?applicationNumber=test_perfor1-module_perfor_1-app-2026-05-04-023437&serviceCode=test_perfor1-module_perfor_1-svc-2026-04-30-023430&businessService=test_perfor1.module_perfor_1&selectedModule=true&from=inbox',
];

const AUTO = process.env.AUTO_LOGIN === '1';
const HEADED = process.env.HEADED === '1';
const DEBUG = process.env.DEBUG === '1' || process.argv.includes('--debug');

// Studio UAT auth (from the DigitPresetButton preset). 'single' context strategy:
// Studio binds sessions to the browser, so auth + scanning share one context.
const auth = {
  type: 'form',
  loginUrl: 'https://unified-uat.digit.org/digit-studio/employee/user/login',
  submitSelector: 'button:has-text("Login")',
  successSelector: 'h1:has-text("Design and Launch Public Services")',
  dismissSelectors: ['input[type="checkbox"]'],
  contextStrategy: 'single',
  fields: {
    'input[type="text"]': process.env.STUDIO_USER || 'STUDIOUAT',
    'input[type="password"]': process.env.STUDIO_PASS || 'eGov@123',
  },
};

function waitForEnter(msg) {
  return new Promise((resolve) => {
    process.stdout.write(msg);
    process.stdin.resume();
    process.stdin.once('data', () => { process.stdin.pause(); resolve(); });
  });
}

const manualLogin = !AUTO;
const concurrency = manualLogin ? 1 : Math.max(1, Number(process.env.SITE_CONCURRENCY ?? 1));

console.log('=== DIGIT Explorer — Studio UAT ===');
console.log('URLs        :', SITEMAP.length);
console.log('Login        :', manualLogin ? 'MANUAL (log in by hand)' : 'AUTO (form auth)');
console.log('Concurrency  :', concurrency, concurrency > 1 ? '(parallel)' : '(sequential)');
console.log('');

const { exploration, report } = await exploreAndReport({
  urls: SITEMAP,
  auth,
  manualLogin,
  waitForEnter,
  // manual login must be headed; auto is headless unless HEADED=1
  options: { headless: manualLogin ? false : !HEADED, concurrency },
});

fs.writeFileSync('site-report.json', JSON.stringify(report, null, 2));
if (DEBUG) fs.writeFileSync('exploration-raw.json', JSON.stringify(exploration, null, 2));

console.log('\n════════════════ SITE REPORT ════════════════');
console.log('Overall score :', report.overallScore, '(' + report.overallStatus + ')');
console.log('Pages scanned :', report.meta.scannedPageCount, '/', report.meta.urlCount,
  report.meta.failedPageCount ? '(' + report.meta.failedPageCount + ' not cold-loadable)' : '');
console.log('States scanned:', report.meta.statesScanned);
console.log('Site issues   :', report.summary.totalIssues,
  `(critical ${report.summary.critical}, serious ${report.summary.serious}, moderate ${report.summary.moderate}, minor ${report.summary.minor})  [one per rule]`);

console.log('\nPer page:');
for (const p of report.pages) {
  const name = p.url.split('/').pop().split('?')[0];
  if (p.summary) console.log(`  ${String(p.score).padStart(3)}  ${name}  — ${p.summary.totalIssues} issues`);
  else console.log(`  [${p.loadStatus}]  ${name}`);
}

console.log('\nTop site issues:');
for (const i of report.issues.slice(0, 10)) {
  console.log(`  ${i.severity.padEnd(20)} ${i.ruleId}  (${i.targets.length} element${i.targets.length === 1 ? '' : 's'})`);
}

console.log('\nWrote site-report.json' + (DEBUG ? ' + exploration-raw.json (--debug)' : '') + '\n');

if (manualLogin) {
  await waitForEnter('Press ENTER to exit...');
}
process.exit(0);
