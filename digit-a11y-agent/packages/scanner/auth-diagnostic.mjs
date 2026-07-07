import { runScan } from './src/index.js';

const tests = [
  {
    name: 'SauceDemo',
    config: {
      type: 'form',
      loginUrl: 'https://www.saucedemo.com/',
      fields: {
        '#user-name': 'standard_user',
        '#password': 'secret_sauce',
      },
      submitSelector: '#login-button',
      successSelector: '.inventory_list',
    },
    targetUrl: 'https://www.saucedemo.com/inventory.html',
  },
  {
    name: 'The Internet (herokuapp)',
    config: {
      type: 'form',
      loginUrl: 'https://the-internet.herokuapp.com/login',
      fields: {
        '#username': 'tomsmith',
        '#password': 'SuperSecretPassword!',
      },
      submitSelector: 'button[type="submit"]',
      successSelector: 'a[href="/logout"]',
    },
    targetUrl: 'https://the-internet.herokuapp.com/secure',
  },
  {
    name: 'Practice Test Automation',
    config: {
      type: 'form',
      loginUrl: 'https://practicetestautomation.com/practice-test-login/',
      fields: {
        '#username': 'student',
        '#password': 'Password123',
      },
      submitSelector: '#submit',
      successSelector: '.post-title',
    },
    targetUrl: 'https://practicetestautomation.com/logged-in-successfully/',
  },
];

for (const test of tests) {
  console.log('═══════════════════════════════════════════════');
  console.log(' Testing:', test.name);
  console.log('═══════════════════════════════════════════════');
  const started = Date.now();
  try {
    const result = await runScan({
      url: test.targetUrl,
      auth: test.config,
      options: { artifactsDir: './diagnostic-' + test.name.toLowerCase().replace(/[^a-z]/g, '-') },
    });
    console.log(' ✓ AUTH SUCCEEDED in', (Date.now() - started) + 'ms');
    console.log('   Authenticated scan completed');
    console.log('   Violations found:', result.violations.length);
    console.log('   Top selector:    ', result.violations[0]?.nodes[0]?.target[0] || '(no violations)');
    console.log('   Screenshot:      ', result.screenshot?.path);
  } catch (err) {
    console.log(' ✗ FAILED in', (Date.now() - started) + 'ms');
    console.log('   Error code:', err.code);
    console.log('   Message:   ', err.message.split('\n')[0]);
  }
  console.log();
}