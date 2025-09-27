#!/bin/bash
# AgentStudio.AI Core Build and Validate Script (Bash version)
# Builds NuGet package and then validates it

set -e  # Exit on any error

echo "🚀 Starting AgentStudio.AI Core Build and Validate Process"
echo "=================================================="

# Run build script
echo "📦 Building package..."
./scripts/build.sh

# Check if build was successful
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Build completed successfully!"
    echo ""
    
    # Run validation script
    echo "🔍 Validating package..."
    ./scripts/validate.sh
    
    # Check if validation was successful
    if [ $? -eq 0 ]; then
        echo ""
        echo "🎉 Build and validation completed successfully!"
        echo "📦 Package is ready for distribution."
        exit 0
    else
        echo ""
        echo "❌ Validation failed. Please fix the issues above."
        exit 1
    fi
else
    echo ""
    echo "❌ Build failed. Please fix the build issues first."
    exit 1
fi
