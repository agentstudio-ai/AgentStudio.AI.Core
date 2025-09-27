#!/bin/bash
# AgentStudio.AI Core Full Build and Test Script (Bash version)
# Cleans up, builds NuGet package, and validates it

set -e  # Exit on any error

echo "🚀 Starting AgentStudio.AI Core Full Build and Test Process"
echo "=================================================="

# Run cleanup script
echo "🧹 Cleaning up previous build artifacts..."
./scripts/cleanup.sh

# Check if cleanup was successful
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Cleanup completed successfully!"
    echo ""
    
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
            echo "🎉 Full build and test completed successfully!"
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
else
    echo ""
    echo "❌ Cleanup failed. Please check the cleanup script."
    exit 1
fi
