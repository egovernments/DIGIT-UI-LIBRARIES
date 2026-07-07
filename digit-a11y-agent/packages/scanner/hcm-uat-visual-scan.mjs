/**
 * HCM / workbench-ui (unified-UAT) — VISUAL authenticated scan.
 *
 * Runs headed (you watch the browser) and, in a SINGLE context (the same
 * strategy the working studio scan uses on unified-uat), logs in once and
 * then runs axe-core against each target page in turn.
 *
 * Success detection is URL-based (we wait until we're no longer on
 * /user/login) so we don't depend on a brittle post-login heading selector.
 * After login we dump the visible headings so you can confirm what rendered.
 *
 * Run:
 *   cd packages/scanner
 *   node hcm-uat-visual-scan.mjs
 */

import { launchBrowser, createContext, closeContext, closeBrowser } from './src/index.js';
import { waitForReady } from './src/wait.js';
import { runAxe } from './src/axe.js';
import { captureScreenshot } from './src/screenshot.js';
import { computeBoundingBoxes } from './src/bbox.js';
import { buildFriendlyReport } from '../reporter/src/index.js';
import { mkdirSync, writeFileSync } from 'node:fs';

// ─── EDIT THESE ───────────────────────────────────────────────────────────
const CREDS = {
  username: 'SATYA',
  password: 'eGov@123',
};
// ────────────────────────────────────────────────────────────────────────

const LOGIN_URL = 'https://unified-uat.digit.org/workbench-ui/employee/user/login';
const TARGETS = [
  { name: 'employee-home',  url: 'https://unified-uat.digit.org/workbench-ui/employee' },
  { name: 'campaign-home',  url: 'https://unified-uat.digit.org/workbench-ui/employee/campaign/campaign-home' },
];

const OUT_DIR = './hcm-uat-scan';
mkdirSync(OUT_DIR, { recursive: true });

const browser = await launchBrowser({ headless: false, slowMo: 250 });
const context = await createContext(browser);
const page = await context.newPage();

page.on('pageerror', (e) => console.log('  [page ERROR]', e.message.split('\n')[0]));

try {
  // ── 1. Log in (single context — auth + scan share one session) ──────────
  console.log('\nStep 1: Logging in to workbench-ui …');
  console.log('  ', LOGIN_URL);
  await page.goto(LOGIN_URL, { waitUntil: 'domcontentloaded', timeout: 60_000 });
  await waitForReady(page);

  await page.fill('input[name="username"]', CREDS.username);
  await page.fill('input[name="password"]', CREDS.password);
  console.log(`  ✓ Filled ${CREDS.username} / ${'*'.repeat(CREDS.password.length)}`);

  // The "Continue" submit button stays disabled until the privacy-policy
  // checkbox is ticked. Check it, then submit.
  await page.check('#privacy-component-check', { timeout: 10_000 });
  console.log('  ✓ Privacy checkbox ticked');

  const submit = page.locator('button.digit-submit-bar:has-text("Continue")');
  await submit.waitFor({ state: 'visible', timeout: 10_000 });
  await submit.click({ timeout: 10_000 });
  console.log('  ✓ Clicked Continue');

  // Success = we left the login page.
  await page.waitForURL((u) => !u.toString().includes('/user/login'), { timeout: 60_000 });
  await waitForReady(page);
  console.log('  ✓ Logged in. Landed on:', page.url());

  const headings = await page.evaluate(() =>
    [...document.querySelectorAll('h1,h2,h3')]
      .map((el) => el.textContent.trim()).filter(Boolean).slice(0, 8));
  console.log('  Visible headings:', headings.length ? headings.join(' | ') : '(none)');

  // ── 2. Scan each target in the authenticated context ────────────────────
  const summaries = [];
  for (const target of TARGETS) {
    console.log(`\nStep 2: Scanning ${target.name}`);
    console.log('  ', target.url);
    await page.goto(target.url, { waitUntil: 'domcontentloaded', timeout: 60_000 });
    await waitForReady(page);

    const finalUrl = page.url();
    if (finalUrl.includes('/user/login')) {
      console.log('  ✗ Bounced back to login — session not honored for this route. Skipping.');
      summaries.push({ name: target.name, url: target.url, error: 'redirected-to-login' });
      continue;
    }

    const axeResult = await runAxe(page);
    if (axeResult.violations.length > 0) {
      await computeBoundingBoxes(page, axeResult.violations).catch(() => {});
    }
    const screenshot = await captureScreenshot(page, {
      scanId: target.name,
      artifactsDir: OUT_DIR,
    }).catch((e) => { console.log('  ⚠ screenshot failed:', e.message); return undefined; });

    const raw = {
      violations: axeResult.violations,
      incomplete: axeResult.incomplete,
      ...(screenshot ? { screenshot } : {}),
      meta: {
        scanId: target.name,
        url: target.url,
        finalUrl,
        scannedAt: new Date().toISOString(),
        axeCoreVersion: axeResult.axeCoreVersion,
        authenticated: true,
      },
    };
    const report = buildFriendlyReport(raw);
    writeFileSync(`${OUT_DIR}/${target.name}-report.json`, JSON.stringify(report, null, 2));

    console.log(`  Score: ${report.score}/100 — ${report.status}`);
    console.log(`  Issues: ${report.summary.totalIssues} ` +
      `(crit ${report.summary.critical}, serious ${report.summary.serious}, ` +
      `mod ${report.summary.moderate}, minor ${report.summary.minor})`);
    console.log(`  Screenshot: ${screenshot?.path ?? '(none)'}`);
    console.log('  Top 5 violations:');
    raw.violations.slice(0, 5).forEach((v) =>
      console.log('   -', v.impact?.toUpperCase(), v.id, '→', v.nodes[0]?.target?.[0] ?? '(no target)'));

    summaries.push({
      name: target.name,
      url: target.url,
      score: report.score,
      status: report.status,
      totalIssues: report.summary.totalIssues,
    });
  }

  console.log('\n═══════════════════════════════════════════════');
  console.log('  HCM / workbench-ui (UAT) — SCAN SUMMARY');
  console.log('═══════════════════════════════════════════════');
  summaries.forEach((s) => {
    if (s.error) console.log(`  ${s.name}: ✗ ${s.error}`);
    else console.log(`  ${s.name}: ${s.score}/100 (${s.status}) — ${s.totalIssues} issues`);
  });
  writeFileSync(`${OUT_DIR}/summary.json`, JSON.stringify(summaries, null, 2));
  console.log(`\n  Reports saved to: ${OUT_DIR}/`);

  console.log('\n>>> Browser staying open 20s — inspect the final page <<<');
  await new Promise((r) => setTimeout(r, 20_000));
} catch (err) {
  console.log('\n✗ Failed:', err.code ?? '', '-', (err.message ?? String(err)).split('\n')[0]);
  console.log('  Current URL:', page.url());
  await page.screenshot({ path: `${OUT_DIR}/error.png`, fullPage: true }).catch(() => {});
  console.log('  >>> Browser staying open 25s so you can see what happened <<<');
  await new Promise((r) => setTimeout(r, 25_000));
} finally {
  await closeContext(context);
  await closeBrowser(browser);
}
