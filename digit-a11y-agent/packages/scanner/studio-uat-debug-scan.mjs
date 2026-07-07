import { launchBrowser, createContext, closeContext, closeBrowser } from './src/index.js';
import { captureAuth } from './src/auth/index.js';
import { waitForReady } from './src/wait.js';
import { runAxe } from './src/axe.js';

const STUDIO_USERNAME = 'STUDIOUAT';
const STUDIO_PASSWORD = 'eGov@123';

const browser = await launchBrowser({ headless: false, slowMo: 250 });

try {
  console.log('Step 1: Capturing auth state...');
  const state = await captureAuth(browser, {
    type: 'form',
    loginUrl: 'https://unified-uat.digit.org/digit-studio/employee/user/login',
    dismissSelectors: ['input[type="checkbox"]'],
    fields: {
      'input[type="text"]':     STUDIO_USERNAME,
      'input[type="password"]': STUDIO_PASSWORD,
    },
    submitSelector:  'button:has-text("Login")',
    successSelector: 'h1:has-text("Design and Launch Public Services")',
    timeouts: { navigation: 60_000, successWait: 60_000 },
  });

  console.log('  ✓ Auth state captured');
  console.log('    Cookies:           ', state.cookies.length);
  console.log('    localStorage keys: ', state.origins.flatMap(o => o.localStorage ?? []).length);

  console.log('\nStep 2: Opening NEW context with captured state...');
  const context = await createContext(browser, { storageState: state });
  const page = await context.newPage();

  console.log('\nStep 3: Navigating to dashboard URL (WATCH THE BROWSER)...');
  await page.goto('https://unified-uat.digit.org/digit-studio/employee/servicedesigner/LandingPage', {
    waitUntil: 'domcontentloaded',
    timeout: 60_000,
  });

  console.log('  Page loaded. Final URL:', page.url());
  console.log('  Waiting for page to settle...');
  await waitForReady(page);

  // Check what page we actually landed on
  const heading = await page.locator('h1, h2').first().textContent().catch(() => '(no heading)');
  console.log('  First heading visible:', heading);

  const isDashboard = await page.locator('h1:has-text("Design and Launch Public Services")').isVisible().catch(() => false);
  console.log('  Dashboard heading visible:', isDashboard);

  const isLogin = await page.locator('#privacy-component-check, .digit-form-card-subheader').first().isVisible().catch(() => false);
  console.log('  Login page elements visible:', isLogin);

  console.log('\n>>> Browser staying open 30 seconds — look at what is rendered <<<\n');
  await new Promise(r => setTimeout(r, 30_000));

  await closeContext(context);

} catch (err) {
  console.log('\n✗ Failed:', err.code, '-', err.message.split('\n')[0]);
  await new Promise(r => setTimeout(r, 20_000));
} finally {
  await closeBrowser(browser);
}