#!/bin/bash

# Script to validate the dependency chain for DIGIT UI packages
# This helps ensure the publish order is correct

set -e

echo "🔍 Validating DIGIT UI Package Dependency Chain..."
echo "=================================================="

# Define package paths
WEBPACK_DIR="webpack"

# Function to get package info
get_package_info() {
    local package_dir=$1
    local package_json="$WEBPACK_DIR/$package_dir/package.json"
    
    if [ ! -f "$package_json" ]; then
        echo "❌ Package.json not found: $package_json"
        return 1
    fi
    
    local name=$(node -p "require('./$package_json').name" 2>/dev/null)
    local version=$(node -p "require('./$package_json').version" 2>/dev/null)
    
    echo "$name@$version"
}

# Function to get dependencies
get_internal_deps() {
    local package_dir=$1
    local package_json="$WEBPACK_DIR/$package_dir/package.json"
    
    if [ ! -f "$package_json" ]; then
        return 0
    fi
    
    # Get dependencies and peerDependencies that are internal DIGIT packages
    node -e "
        const pkg = require('./$package_json');
        const deps = {...(pkg.dependencies || {}), ...(pkg.peerDependencies || {})};
        const internalDeps = Object.keys(deps).filter(dep => dep.startsWith('@egovernments/digit-ui-'));
        if (internalDeps.length > 0) {
            console.log(internalDeps.join(' '));
        }
    " 2>/dev/null || true
}

echo "📦 Package Analysis:"
echo "==================="

# Analyze each package
echo "📋 libraries: $(get_package_info 'libraries')"
LIBS_DEPS=$(get_internal_deps 'libraries')
if [ -n "$LIBS_DEPS" ]; then
    echo "   📎 Internal dependencies: $LIBS_DEPS"
else
    echo "   📎 No internal dependencies ✅"
fi

echo ""
echo "📋 svg-components: $(get_package_info 'svg-components')"
SVG_DEPS=$(get_internal_deps 'svg-components')
if [ -n "$SVG_DEPS" ]; then
    echo "   📎 Internal dependencies: $SVG_DEPS"
else
    echo "   📎 No internal dependencies ✅"
fi

echo ""
echo "📋 ui-components: $(get_package_info 'ui-components')"
UI_DEPS=$(get_internal_deps 'ui-components')
if [ -n "$UI_DEPS" ]; then
    echo "   📎 Internal dependencies: $UI_DEPS"
else
    echo "   📎 No internal dependencies"
fi

echo ""
echo "📋 react-components: $(get_package_info 'react-components')"
REACT_DEPS=$(get_internal_deps 'react-components')
if [ -n "$REACT_DEPS" ]; then
    echo "   📎 Internal dependencies: $REACT_DEPS"
else
    echo "   📎 No internal dependencies"
fi

echo ""
echo "🏗️ Recommended Publish Order:"
echo "============================="

echo "1. 🟢 Stage 1 - Base packages (can publish in parallel):"
if [ -z "$LIBS_DEPS" ]; then
    echo "   ✅ libraries - $(get_package_info 'libraries')"
fi
if [ -z "$SVG_DEPS" ]; then
    echo "   ✅ svg-components - $(get_package_info 'svg-components')"
fi

echo ""
echo "2. 🟡 Stage 2 - Packages with base dependencies:"
if [ -n "$UI_DEPS" ]; then
    echo "   ✅ ui-components - $(get_package_info 'ui-components')"
    echo "      📎 Wait for: $UI_DEPS"
fi

echo ""
echo "3. 🔴 Stage 3 - Packages with complex dependencies:"
if [ -n "$REACT_DEPS" ]; then
    echo "   ✅ react-components - $(get_package_info 'react-components')"
    echo "      📎 Wait for: $REACT_DEPS"
fi

echo ""
echo "⚠️ GitHub Actions Workflow Validation:"
echo "======================================"

# Check if workflow file exists and analyze it
WORKFLOW_FILE=".github/workflows/publishComponents.yml"
if [ -f "$WORKFLOW_FILE" ]; then
    echo "✅ Workflow file exists: $WORKFLOW_FILE"
    
    # Check for dependency management
    if grep -q "needs:" "$WORKFLOW_FILE"; then
        echo "✅ Workflow uses job dependencies (needs:)"
    else
        echo "❌ Workflow missing job dependencies - all jobs will run in parallel!"
    fi
    
    if grep -q "npm view.*version" "$WORKFLOW_FILE"; then
        echo "✅ Workflow includes package availability checks"
    else
        echo "⚠️ Workflow missing package availability checks"
    fi
    
    if grep -q "sleep" "$WORKFLOW_FILE"; then
        echo "✅ Workflow includes wait/retry logic"
    else
        echo "⚠️ Workflow missing wait/retry logic"
    fi
    
    # Count stages in workflow
    STAGE_COUNT=$(grep -c "publish-.*:" "$WORKFLOW_FILE" | head -1)
    echo "📊 Workflow stages found: $STAGE_COUNT"
    
else
    echo "❌ Workflow file not found: $WORKFLOW_FILE"
fi

echo ""
echo "💡 Summary & Recommendations:"
echo "============================"
echo "✅ Publish Order: libraries & svg-components → ui-components → react-components"
echo "⏰ Wait Strategy: Check npm availability with 30s intervals, 15min timeout"
echo "🔄 Retry Logic: Essential for npm registry propagation delays"
echo "📦 Tag Strategy: Use consistent tags across all packages"
echo ""

# Generate quick publish commands
echo "🚀 Manual Publish Commands (for testing):"
echo "=========================================="
echo "# Stage 1 (parallel)"
echo "cd webpack/libraries && npm publish --tag beta"
echo "cd webpack/svg-components && npm publish --tag beta"
echo ""
echo "# Stage 2 (wait for Stage 1)"
echo "cd webpack/ui-components && npm publish --tag beta"
echo ""
echo "# Stage 3 (wait for Stage 2)"
echo "cd webpack/react-components && npm publish --tag beta"