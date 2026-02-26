#!/bin/bash

# Script to check if npm packages are available
# Usage: ./check-package-availability.sh <package-name> <version> [timeout-minutes]

set -e

PACKAGE_NAME="$1"
VERSION="$2"
TIMEOUT_MINUTES="${3:-15}"  # Default to 15 minutes

if [ -z "$PACKAGE_NAME" ] || [ -z "$VERSION" ]; then
    echo "❌ Usage: $0 <package-name> <version> [timeout-minutes]"
    echo "   Example: $0 '@egovernments/digit-ui-libraries' '1.9.0' 10"
    exit 1
fi

MAX_ATTEMPTS=$((TIMEOUT_MINUTES * 2))  # Check every 30 seconds
ATTEMPT=1

echo "🔍 Checking availability of $PACKAGE_NAME@$VERSION..."
echo "⏰ Timeout: $TIMEOUT_MINUTES minutes ($MAX_ATTEMPTS attempts)"

while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
    if npm view "$PACKAGE_NAME@$VERSION" version &>/dev/null; then
        echo "✅ $PACKAGE_NAME@$VERSION is available on npm!"
        
        # Get additional package info
        PUBLISHED_VERSION=$(npm view "$PACKAGE_NAME@$VERSION" version 2>/dev/null)
        PUBLISH_TIME=$(npm view "$PACKAGE_NAME@$VERSION" time 2>/dev/null | grep "\"$VERSION\"" | cut -d'"' -f4)
        
        echo "📦 Confirmed version: $PUBLISHED_VERSION"
        if [ -n "$PUBLISH_TIME" ]; then
            echo "📅 Published at: $PUBLISH_TIME"
        fi
        
        exit 0
    else
        MINUTES_ELAPSED=$((($ATTEMPT - 1) / 2))
        echo "⏳ Attempt $ATTEMPT/$MAX_ATTEMPTS ($MINUTES_ELAPSED min elapsed): $PACKAGE_NAME@$VERSION not yet available..."
        
        if [ $ATTEMPT -lt $MAX_ATTEMPTS ]; then
            sleep 30
        fi
        
        ((ATTEMPT++))
    fi
done

echo "❌ $PACKAGE_NAME@$VERSION is still not available after $TIMEOUT_MINUTES minutes"
echo "💡 This might indicate:"
echo "   - Publishing failed"
echo "   - npm registry propagation delay"
echo "   - Version mismatch"
exit 1