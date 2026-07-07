import { describe, it, expect } from 'vitest';
import { ruleMessages, getMessage } from '../src/messages.js';

describe('messages.js — rule mapping table', () => {
  const rules = Object.entries(ruleMessages);

  it('contains exactly 90 rule entries (89 axe + 1 legacy focus-trap)', () => {
    expect(rules).toHaveLength(90);
  });

  it('every rule has all required fields', () => {
    for (const [id, rule] of rules) {
      expect(rule.title, `${id} missing title`).toBeTypeOf('string');
      expect(rule.title.length, `${id} has empty title`).toBeGreaterThan(0);
      expect(rule.whyItMatters, `${id} missing whyItMatters`).toBeTypeOf('string');
      expect(rule.whatYouCanDo, `${id} missing whatYouCanDo`).toBeTypeOf('string');
      expect(rule.affectedUsers, `${id} affectedUsers not array`).toBeInstanceOf(Array);
      expect(rule.affectedUsers.length, `${id} has empty affectedUsers`).toBeGreaterThan(0);
      expect(rule.standards, `${id} missing standards`).toBeDefined();
      expect(rule.standards.wcag,   `${id}.standards.wcag not array`).toBeInstanceOf(Array);
      expect(rule.standards.gigw,   `${id}.standards.gigw not array`).toBeInstanceOf(Array);
      expect(rule.standards.ada,    `${id}.standards.ada not array`).toBeInstanceOf(Array);
      expect(rule.standards.sesmag, `${id}.standards.sesmag not array`).toBeInstanceOf(Array);
    }
  });

  it('every affectedUser has icon and label', () => {
    for (const [id, rule] of rules) {
      for (const user of rule.affectedUsers) {
        expect(user.icon,  `${id} user.icon missing`).toBeTypeOf('string');
        expect(user.label, `${id} user.label missing`).toBeTypeOf('string');
      }
    }
  });

  it('all 90 rule titles are unique', () => {
    const titles = rules.map(([, r]) => r.title);
    expect(new Set(titles).size).toBe(90);
  });

  it('all 13 originally-mapped rules are still present (no regressions)', () => {
    const ORIGINAL = [
      'image-alt', 'input-image-alt', 'color-contrast', 'label', 'button-name',
      'link-name', 'landmark-one-main', 'region', 'page-has-heading-one',
      'aria-required-attr', 'document-title', 'focus-trap', 'html-has-lang',
    ];
    for (const id of ORIGINAL) {
      expect(ruleMessages[id], `${id} regression`).toBeDefined();
    }
  });
});

describe('messages.js — getMessage()', () => {
  it('returns the exact entry for a known rule', () => {
    const msg = getMessage('image-alt');
    expect(msg.title).toBe('Images are missing descriptions');
    expect(msg.standards.wcag).toContain('1.1.1 Non-text Content (Level A)');
  });

  it('returns a fallback message for an unknown rule', () => {
    const msg = getMessage('this-rule-does-not-exist-xyz');
    expect(msg.title).toBe('This rule does not exist xyz');
    expect(msg.whyItMatters).toMatch(/may prevent some users/i);
    expect(msg.affectedUsers).toHaveLength(1);
    expect(msg.standards.wcag.length).toBeGreaterThan(0);
  });
});
