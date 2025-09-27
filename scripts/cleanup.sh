#!/bin/bash
# AgentStudio.AI Core Cleanup Script (Bash version)
# Removes build output and temporary validation files

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${GREEN}🧹 Cleaning up AgentStudio.AI Core build artifacts${NC}"
echo "=================================================="

# Clean up dist/ folder
if [ -d "dist" ]; then
    echo -e "${YELLOW}📦 Removing dist/ folder...${NC}"
    rm -rf dist
    echo -e "${GREEN}  ✅ dist/ folder removed${NC}"
else
    echo -e "${CYAN}  ℹ️  dist/ folder not found${NC}"
fi

# Clean up temp-validation/ folder
if [ -d "temp-validation" ]; then
    echo -e "${YELLOW}🔍 Removing temp-validation/ folder...${NC}"
    rm -rf temp-validation
    echo -e "${GREEN}  ✅ temp-validation/ folder removed${NC}"
else
    echo -e "${CYAN}  ℹ️  temp-validation/ folder not found${NC}"
fi

echo ""
echo -e "${GREEN}🎉 Cleanup completed successfully!${NC}"
echo -e "${CYAN}All build artifacts and temporary files have been removed.${NC}"

exit 0
