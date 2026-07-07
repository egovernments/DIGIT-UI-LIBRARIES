import { launchBrowser, closeBrowser } from './src/index.js';
import { captureAuth } from './src/auth/index.js';

// Replace these with your actual Studio UAT credentials before running
const STUDIO_USERNAME = 'STUDIOUAT';
const STUDIO_PASSWORD = 'eGov@123';

console.log('Launching visible browser — watch what happens...\n');

const browser = await launchBrowser({ headless: false, slowMo: 300 });

try {
  console.log('Step 1: Running form auth flow against Studio UAT...');
  const state = await captureAuth(browser, {
    type: 'form',
    loginUrl: 'https://unified-uat.digit.org/digit-studio/employee/user/login',

    // Same privacy-policy checkbox pattern; Login button instead of Continue
    dismissSelectors: ['input[type="checkbox"]'],

    fields: {
      'input[type="text"]':     STUDIO_USERNAME,
      'input[type="password"]': STUDIO_PASSWORD,
    },
    submitSelector: 'button:has-text("Login")',

    // Tight heading-level selector — won't accidentally match login-page text
    successSelector: 'h2:has-text("Design and Launch Public Services")',

    timeouts: { navigation: 60_000, successWait: 60_000 },
  });

  console.log('\n✓ Auth completed');
  console.log('  Cookies captured:    ', state.cookies.length);
  console.log('  localStorage keys:   ', state.origins.flatMap(o => o.localStorage ?? []).length);
  console.log('\n  All localStorage keys:');
  state.origins.flatMap(o => o.localStorage ?? []).forEach(kv => {
    console.log('   -', kv.name);
  });

} catch (err) {
  console.log('\n✗ Auth failed');
  console.log('  Error code:', err.code);
  console.log('  Message:   ', err.message.split('\n')[0]);
  console.log('\n>>> Browser staying open for 30 seconds — inspect what is shown <<<');
  console.log('>>> Look at: URL bar, page content, any error messages <<<\n');
  await new Promise(r => setTimeout(r, 30_000));
} finally {
  await closeBrowser(browser);
}