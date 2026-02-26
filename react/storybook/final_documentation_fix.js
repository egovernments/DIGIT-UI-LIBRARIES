#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const glob = require('glob');

function fixDocumentationStory(filePath) {
  console.log(`Processing ${filePath}...`);
  
  let content = fs.readFileSync(filePath, 'utf8');
  const originalContent = content;
  
  const componentName = path.basename(filePath, '.stories.js').replace(/Docs$/, '');
  const componentType = filePath.includes('/atoms/') ? 'atoms' : 'molecules';
  
  // Fix cases where atoms are incorrectly marked as molecules or have wrong argTypes
  content = content.replace(
    /export const Documentation = createDocumentationStory\("([^"]+)", "molecules", \{\s*disable:\s*true\s*\}\);/g,
    (match, name) => {
      if (filePath.includes('/atoms/')) {
        return `export const Documentation = createDocumentationStory("${name}", "atoms");`;
      }
      return `export const Documentation = createDocumentationStory("${name}", "molecules");`;
    }
  );
  
  // Fix broken argTypes patterns
  content = content.replace(
    /export const Documentation = createDocumentationStory\("[^"]+", "[^"]+", \{\s*disable:\s*true\s*\}\);/g,
    `export const Documentation = createDocumentationStory("${componentName}", "${componentType}");`
  );
  
  // Fix incomplete argTypes
  content = content.replace(
    /export const Documentation = createDocumentationStory\("[^"]+", "[^"]+", \{\s*([^}]*table:\s*\{\s*disable:\s*true)\s*\}\);/g,
    `export const Documentation = createDocumentationStory("${componentName}", "${componentType}");`
  );
  
  if (content !== originalContent) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`  Fixed ${filePath}`);
  } else {
    console.log(`  No changes needed for ${filePath}`);
  }
}

// Process all story files
const storyFiles = [
  ...glob.sync('atoms/*.stories.js'),
  ...glob.sync('molecules/*.stories.js')
];

console.log(`Processing ${storyFiles.length} story files...\n`);

storyFiles.forEach(fixDocumentationStory);

console.log('\n✅ Final documentation fix completed!');