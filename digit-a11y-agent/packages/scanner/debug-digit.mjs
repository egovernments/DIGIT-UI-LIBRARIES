import { launchBrowser, createContext, closeBrowser } from './src/index.js';
import { captureAuth } from './src/auth/index.js';

console.log('Launching visible browser — watch what happens...\n');

// Override the default headless behavior
const browser = await launchBrowser({ headless: false, slowMo: 250 });

try {
  console.log('Step 1: Running form auth flow...');
  const state = await captureAuth(browser, {
    type: 'form',
    loginUrl: 'https://health-demo.digit.org/console/employee/user/login',
    dismissSelectors: ['input[type="checkbox"]'],
    fields: {
      'input[type="text"]':     'Shreya',
      'input[type="password"]': 'eGov@123',
    },
    submitSelector: 'button:has-text("Continue")',
    successSelector: 'text=HCM Console',
    timeouts: { successWait: 60_000 },  // extended for observation
  });

  console.log('✓ Auth completed');
  console.log('  Cookies:', state.cookies.length);
  console.log('  localStorage keys:', state.origins.flatMap(o => o.localStorage ?? []).map(kv => kv.name));

} catch (err) {
  console.log('✗ Auth failed:', err.code);
  console.log('  Message:', err.message.split('\n')[0]);
  console.log('\n>>> The browser is staying open for 30 seconds so you can inspect <<<');
  console.log('>>> Look at the page, open DevTools, check what is rendered <<<\n');
  await new Promise(r => setTimeout(r, 30_000));
} finally {
  await closeBrowser(browser);
}