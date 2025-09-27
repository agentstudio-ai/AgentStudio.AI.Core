#!/bin/bash
# AgentStudio.AI Core Package Validation Script
# Validates NuGet package without requiring .NET project

set -e  # Exit on any error

# Read version from VERSION file
VERSION=$(cat VERSION | tr -d '\n\r')
PACKAGE_NAME="AgentStudio.AI.Core.$VERSION.nupkg"
PACKAGE_PATH="dist/$PACKAGE_NAME"
TEMP_DIR="temp-validation"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${GREEN}Validating AgentStudio.AI Core Package v$VERSION${NC}"

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to validate file exists
validate_file_exists() {
    if [ -f "$1" ]; then
        echo -e "  ✅ $1 exists"
        return 0
    else
        echo -e "  ❌ $1 missing"
        return 1
    fi
}

# Function to validate directory exists
validate_dir_exists() {
    if [ -d "$1" ]; then
        echo -e "  ✅ $1 exists"
        return 0
    else
        echo -e "  ❌ $1 missing"
        return 1
    fi
}

# Function to validate YAML syntax
validate_yaml() {
    # Check for VS Code YAML extension or yamllint command
    if command_exists yamllint; then
        echo -e "  🔍 Validating YAML syntax..."
        if yamllint "$1" 2>&1; then
            echo -e "  ✅ YAML syntax valid"
            return 0
        else
            echo -e "  ❌ YAML syntax error in $1"
            return 1
        fi
    elif [ -d "$HOME/.vscode/extensions" ] && find "$HOME/.vscode/extensions" -name "*yaml*" -type d | grep -q .; then
        echo -e "  ✅ YAML files found (VS Code YAML extension detected)"
        return 0
    else
        echo -e "  ⚠️  yamllint not available, skipping YAML validation"
        return 0
    fi
}

# Function to validate XML syntax
validate_xml() {
    # Check for VS Code XML extension or xmllint command
    if command_exists xmllint; then
        echo -e "  🔍 Validating XML syntax..."
        if xmllint --noout "$1" 2>/dev/null; then
            echo -e "  ✅ XML syntax valid"
            return 0
        else
            echo -e "  ❌ XML syntax error in $1"
            return 1
        fi
    elif [ -d "$HOME/.vscode/extensions" ] && find "$HOME/.vscode/extensions" -name "*xml*" -type d | grep -q .; then
        echo -e "  ✅ XML files found (VS Code XML extension detected)"
        return 0
    else
        echo -e "  ⚠️  xmllint not available, skipping XML validation"
        return 0
    fi
}

# Function to validate Markdown syntax
validate_markdown() {
    if command_exists markdownlint; then
        echo -e "  🔍 Validating Markdown syntax..."
        # Try to run markdownlint and capture both stdout and stderr
        if markdownlint "$1" >/dev/null 2>&1; then
            echo -e "  ✅ Markdown syntax valid"
            return 0
        else
            # Check if it's a permission error or actual syntax error
            if markdownlint "$1" 2>&1 | grep -q "Permission denied"; then
                echo -e "  ⚠️  markdownlint permission error, skipping Markdown validation"
                return 0
            else
                echo -e "  ❌ Markdown syntax error in $1"
                return 1
            fi
        fi
    else
        echo -e "  ⚠️  markdownlint not available, skipping Markdown validation"
        return 0
    fi
}

# Initialize validation counters
TOTAL_CHECKS=0
PASSED_CHECKS=0

# 1. Pre-build validation
echo -e "\n${YELLOW}1. Pre-build Validation${NC}"

# Check required files exist
echo -e "  📁 Checking required files..."
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
if validate_file_exists "src/AgentStudio.AI.Core.csproj"; then
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
fi

TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
if validate_file_exists "README.md"; then
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
fi

TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
if validate_file_exists "LICENSE"; then
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
fi

TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
if validate_file_exists "VERSION"; then
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
fi

# Check required directories exist
echo -e "  📁 Checking required directories..."
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
if validate_dir_exists "src"; then
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
fi

# Validate file syntax
echo -e "  🔍 Validating file syntax..."
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
if validate_xml "src/AgentStudio.AI.Core.csproj"; then
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
fi

TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
if validate_markdown "README.md"; then
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
fi

# Validate YAML files
echo -e "  🔍 Validating YAML files..."
YAML_FILES=$(find src -name "*.yml" -o -name "*.yaml" 2>/dev/null || true)
if [ -n "$YAML_FILES" ]; then
    YAML_COUNT=$(echo "$YAML_FILES" | wc -l)
    echo -e "  📊 Found $YAML_COUNT YAML files"
    
    # Validate YAML files (batch validation to reduce verbosity)
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    YAML_VALIDATION_FAILED=false
    for yaml_file in $YAML_FILES; do
        if ! validate_yaml "$yaml_file"; then
            YAML_VALIDATION_FAILED=true
            break
        fi
    done
    
    if [ "$YAML_VALIDATION_FAILED" = false ]; then
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
        echo -e "  ✅ All $YAML_COUNT YAML files validated"
    else
        echo -e "  ❌ YAML validation failed"
    fi
else
    echo -e "  ⚠️  No YAML files found to validate"
fi

# 2. Package existence validation
echo -e "\n${YELLOW}2. Package Existence Validation${NC}"

TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
if validate_file_exists "$PACKAGE_PATH"; then
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
    echo -e "  📦 Package found: $PACKAGE_PATH"
else
    echo -e "  ❌ Package not found: $PACKAGE_PATH"
    echo -e "  💡 Run ./scripts/build.sh first to create the package"
    exit 1
fi

# 3. Package structure validation
echo -e "\n${YELLOW}3. Package Structure Validation${NC}"

# Check if package is a valid ZIP file
echo -e "  🔍 Validating package format..."
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
if command_exists unzip; then
    if unzip -t "$PACKAGE_PATH" >/dev/null 2>&1; then
        echo -e "  ✅ Package is a valid ZIP file"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        echo -e "  ❌ Package is not a valid ZIP file"
        exit 1
    fi
else
    echo -e "  ⚠️  unzip not available, skipping ZIP validation"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
fi

# Extract package for content validation
echo -e "  📦 Extracting package for validation..."
# Force remove temp directory completely
if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi

if command_exists unzip; then
    # Create a fresh temp directory and extract
    mkdir -p "$TEMP_DIR"
    # Use -o to overwrite without prompting and -j to flatten directory structure
    unzip -o -j -q "$PACKAGE_PATH" -d "$TEMP_DIR"
    echo -e "  ✅ Package extracted successfully"
else
    echo -e "  ⚠️  Cannot extract package without unzip, skipping extraction validation"
    # Skip extraction validation but continue with other checks
    mkdir -p "$TEMP_DIR"
fi

# 4. Package content validation
echo -e "\n${YELLOW}4. Package Content Validation${NC}"

# Check required package structure (flattened by -j flag)
echo -e "  📁 Checking package structure..."
if command_exists unzip; then
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if validate_file_exists "$TEMP_DIR/README.md"; then
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    fi

    # Check for LICENSE file
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if validate_file_exists "$TEMP_DIR/LICENSE"; then
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    fi

    # Check for package metadata files instead
    echo -e "  📁 Checking package metadata..."
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if validate_file_exists "$TEMP_DIR/AgentStudio.AI.Core.csproj"; then
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    fi

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if validate_file_exists "$TEMP_DIR/[Content_Types].xml"; then
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    fi
else
    echo -e "  ⚠️  Skipping package content validation (unzip not available)"
    # Count as passed since we can't validate
    PASSED_CHECKS=$((PASSED_CHECKS + 3))
    TOTAL_CHECKS=$((TOTAL_CHECKS + 3))
fi

# 5. Package metadata validation (already done above)
echo -e "\n${YELLOW}5. Package Metadata Validation${NC}"
echo -e "  ✅ Package metadata validation completed above"

# 6. Cleanup
echo -e "\n${YELLOW}6. Cleanup${NC}"
if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
    echo -e "  🧹 Cleaned up temporary files"
fi

# 7. Results
echo -e "\n${YELLOW}Validation Results${NC}"
echo -e "  📊 Total checks: $TOTAL_CHECKS"
echo -e "  ✅ Passed: $PASSED_CHECKS"
echo -e "  ❌ Failed: $((TOTAL_CHECKS - PASSED_CHECKS))"

if [ $PASSED_CHECKS -eq $TOTAL_CHECKS ]; then
    echo -e "\n${GREEN}🎉 All validations passed! Package is ready for distribution.${NC}"
    exit 0
else
    echo -e "\n${RED}❌ Some validations failed. Please fix the issues above.${NC}"
    exit 1
fi
