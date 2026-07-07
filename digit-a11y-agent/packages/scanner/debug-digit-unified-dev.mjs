/**
 * Visual debug — DIGIT unified-DEV Studio login + protected target.
 *
 * Diagnoses AUTH_SUCCESS_TIMEOUT for unified-dev specifically. The flow:
 *
 *   1. Navigate to unified-dev's Studio login
 *   2. Dismiss consent checkbox
 *   3. Fill credentials, submit
 *   4. ⚡ Wait a generous 20 seconds, then DUMP what's actually on the page
 *      — all visible headings, the current URL, any redirect history. This
 *      tells us what success selector to use.
 *   5. Navigate to the deep target URL
 *   6. Wait for the user-supplied h3:has-text(...) selector
 *   7. Pause so we can verify visually
 *
 * Run via:
 *   cd packages/scanner
 *   node ../../debug-digit-unified-dev.mjs
 *
 * Edit the CREDS object below if your unified-dev credentials differ from
 * the UAT defaults (STUDIOUAT / eGov@123).
 */

import { chromium } from 'playwright';

const LOGIN_URL  = 'https://unified-dev.digit.org/digit-studio/employee/user/login';
const TARGET_URL = 'https://unified-dev.digit.org/digit-studio/employee/servicedesigner/Service-Builder-Home?module=Service_yo9lady&service=Module_bvrm0mw&edit=true';

// EDIT THESE if unified-dev needs different credentials than UAT.
const CREDS = {
  username: 'DevAdmin1',
  password: 'eGov@123',
};

// The element you found on the target page.
const TARGET_SELECTOR = 'h3:has-text("Create Service Application Forms")';

async function main() {
  console.log('🚀 Launching Chromium (visible, slow-mo)...');
  const browser = await chromium.launch({ headless: false, slowMo: 300 });
  const context = await browser.newContext({ viewport: { width: 1280, height: 800 } });
  const page = await context.newPage();

  page.on('console',   m => console.log(`  [page]`,  m.text()));
  page.on('pageerror', e => console.log(`  [page ERROR]`, e.message));

  // Track every navigation so we can see redirect chains
  const navigations = [];
  page.on('framenavigated', (frame) => {
    if (frame === page.mainFrame()) {
      navigations.push({ at: new Date().toISOString().slice(11, 19), url: frame.url() });
    }
  });

  try {
    console.log(`\n📍 1. Open login page`);
    console.log(`     ${LOGIN_URL}`);
    await page.goto(LOGIN_URL, { waitUntil: 'domcontentloaded', timeout: 30000 });
    console.log(`     ✓ Loaded. URL: ${page.url()}`);

    console.log(`\n📍 2. Dismiss consent checkbox (if present)`);
    try {
      await page.click('input[type="checkbox"]', { timeout: 5000 });
      console.log(`     ✓ Checkbox clicked`);
    } catch {
      console.log(`     ⚠ No checkbox visible — skipping`);
    }

    console.log(`\n📍 3. Fill credentials`);
    await page.fill('input[type="text"]',     CREDS.username);
    await page.fill('input[type="password"]', CREDS.password);
    console.log(`     ✓ Filled ${CREDS.username} / ${'*'.repeat(CREDS.password.length)}`);

    console.log(`\n📍 4. Submit (trying "Login", then "Continue", then generic)`);
    try {
      await page.click('button:has-text("Login")', { timeout: 3000 });
      console.log(`     ✓ Clicked "Login" button`);
    } catch {
      try {
        await page.click('button:has-text("Continue")', { timeout: 3000 });
        console.log(`     ✓ Clicked "Continue" button`);
      } catch {
        await page.click('button[type="submit"]', { timeout: 3000 });
        console.log(`     ✓ Clicked generic submit button`);
      }
    }

    console.log(`\n📍 5. Wait 20s and observe what happens`);
    await page.waitForTimeout(20000);

    console.log(`\n   --- Navigation history during/after login ---`);
    for (const nav of navigations) {
      console.log(`     ${nav.at}  ${nav.url}`);
    }

    console.log(`\n   --- Final URL after login ---`);
    console.log(`     ${page.url()}`);

    console.log(`\n   --- All visible headings on the post-login page ---`);
    const headings = await page.evaluate(() => {
      const result = [];
      for (const tag of ['h1', 'h2', 'h3', 'h4']) {
        document.querySelectorAll(tag).forEach((el) => {
          const text = (el.textContent || '').trim();
          if (text) result.push({ tag, text });
        });
      }
      return result;
    });
    if (headings.length === 0) {
      console.log(`     ⚠ NO headings found. The page may still be loading, or it`);
      console.log(`       redirected to something that doesn't use semantic headings.`);
    } else {
      for (const h of headings) {
        console.log(`     <${h.tag}> "${h.text}"`);
      }
    }

    console.log(`\n   --- Page <title> ---`);
    console.log(`     "${await page.title()}"`);

    await dumpLocalStorage(page, 'after login');

    console.log(`\n   📸 Saving 1-after-login.png`);
    await page.screenshot({ path: '1-unified-dev-after-login.png', fullPage: true });

    console.log(`\n   ⏸  Pausing 5s — inspect the browser window before we move on`);
    await page.waitForTimeout(5000);

    console.log(`\n📍 6. Navigate to TARGET (Service Builder Home)`);
    console.log(`     ${TARGET_URL}`);
    await page.goto(TARGET_URL, { waitUntil: 'domcontentloaded', timeout: 30000 });
    console.log(`     ✓ Initial load. URL: ${page.url()}`);

    if (page.url().includes('/user/login')) {
      console.log(`\n     ❌ REDIRECTED BACK TO LOGIN.`);
      console.log(`        unified-dev didn't honor the session. May need contextStrategy='single'.`);
      await page.screenshot({ path: '2-unified-dev-redirected.png', fullPage: true });
    } else {
      console.log(`\n📍 7. Wait for target selector: ${TARGET_SELECTOR}`);
      try {
        await page.waitForSelector(TARGET_SELECTOR, { timeout: 30000, state: 'visible' });
        console.log(`     ✓ Found! "Create Service Application Forms" h3 is visible.`);
      } catch (err) {
        console.log(`     ❌ Selector did not appear: ${err.message}`);
        console.log(`        Dumping current page headings:`);
        const targetHeadings = await page.evaluate(() => {
          const result = [];
          for (const tag of ['h1', 'h2', 'h3', 'h4']) {
            document.querySelectorAll(tag).forEach((el) => {
              const text = (el.textContent || '').trim();
              if (text) result.push({ tag, text });
            });
          }
          return result;
        });
        for (const h of targetHeadings) console.log(`        <${h.tag}> "${h.text}"`);
      }

      console.log(`\n   📸 Saving 2-target.png`);
      await page.screenshot({ path: '2-unified-dev-target.png', fullPage: true });
    }

    console.log(`\n⏸  Pausing 30 seconds — inspect, open devtools, interact with the page`);
    await page.waitForTimeout(30000);

  } catch (err) {
    console.log(`\n❌ FAILED: ${err.message}`);
    console.log(`   URL was: ${page.url()}`);
    console.log(`   📸 Saving error screenshot`);
    await page.screenshot({ path: 'unified-dev-error.png', fullPage: true });
    throw err;
  } finally {
    console.log(`\n🛑 Closing browser`);
    await browser.close();
  }
}

async function dumpLocalStorage(page, when) {
  const storage = await page.evaluate(() => {
    const out = {};
    for (let i = 0; i < localStorage.length; i++) {
      const k = localStorage.key(i);
      out[k] = localStorage.getItem(k);
    }
    return out;
  });
  console.log(`\n   localStorage ${when} (${Object.keys(storage).length} keys):`);
  for (const [k, v] of Object.entries(storage)) {
    const preview = v && v.length > 80 ? v.slice(0, 80) + '…' : v;
    console.log(`     ${k} = ${preview}`);
  }
}

main().catch((e) => { console.error(e); process.exit(1); });