import { launchBrowser, createContext, closeContext, closeBrowser } from './src/index.js';
import { captureAuth } from './src/auth/index.js';
import { waitForReady } from './src/wait.js';

const browser = await launchBrowser({ headless: false, slowMo: 250 });

try {
  console.log('Step 1: Capturing auth state on health-demo...');
  const state = await captureAuth(browser, {
    type: 'form',
    loginUrl: 'https://health-demo.digit.org/console/employee/user/login',
    dismissSelectors: ['input[type="checkbox"]'],
    fields: {
      'input[type="text"]':     'Shreya',
      'input[type="password"]': 'eGov@123',
    },
    submitSelector:  'button:has-text("Continue")',
    successSelector: 'text=HCM Console',
    timeouts: { navigation: 60_000, successWait: 60_000 },
  });

  console.log('  ✓ Auth state captured');
  console.log('    Cookies:           ', state.cookies.length);
  console.log('    localStorage keys: ', state.origins.flatMap(o => o.localStorage ?? []).length);

  console.log('\nStep 2: Opening NEW context with captured state (WATCH FOR NEW WINDOW)...');
  const context = await createContext(browser, { storageState: state });
  const page = await context.newPage();

  console.log('\nStep 3: Navigating to dashboard URL in new context...');
  await page.goto('https://health-demo.digit.org/console/employee', {
    waitUntil: 'domcontentloaded',
    timeout: 60_000,
  });
  await waitForReady(page);

  console.log('  Final URL:', page.url());

  const isDashboard = await page.locator('text=HCM Console').isVisible().catch(() => false);
  console.log('  Dashboard "HCM Console" visible:', isDashboard);

  const isLogin = await page.locator('#user-login-core_login_password, .EmployeeLoginFooter').first().isVisible().catch(() => false);
  console.log('  Login page elements visible:    ', isLogin);

  console.log('\n>>> Browser staying open 30 seconds — observe both windows <<<\n');
  await new Promise(r => setTimeout(r, 30_000));

  await closeContext(context);

} catch (err) {
  console.log('\n✗ Failed:', err.code, '-', err.message.split('\n')[0]);
  await new Promise(r => setTimeout(r, 20_000));
} finally {
  await closeBrowser(browser);
}