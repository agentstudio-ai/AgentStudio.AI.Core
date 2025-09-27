#!/bin/bash
# AgentStudio.AI Core Build Script (Bash version)
# Builds NuGet package from source files

VERSION="0.1.0"
OUTPUT_DIR="dist"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${GREEN}Building AgentStudio.AI Core v$VERSION${NC}"

# Create output directory
if [ -d "$OUTPUT_DIR" ]; then
    rm -rf "$OUTPUT_DIR"
fi
mkdir -p "$OUTPUT_DIR"

# Copy source files to package structure
PACKAGE_DIR="$OUTPUT_DIR/AgentStudio.AI.Core.$VERSION"
mkdir -p "$PACKAGE_DIR"

# Copy templates, workflows, etc. from .agentstudio-ai to src
echo -e "${YELLOW}Copying framework files...${NC}"

# Create content directories
CONTENT_DIR="$PACKAGE_DIR/content"
mkdir -p "$CONTENT_DIR"

# Copy framework files from src/ (when they're ready)
if [ -d "src/templates" ]; then
    echo -e "${YELLOW}Framework files found in src/, copying...${NC}"
    # Copy templates
    cp -r "src/templates" "$CONTENT_DIR/templates"
fi
if [ -d "src/workflows" ]; then
    # Copy workflows
    cp -r "src/workflows" "$CONTENT_DIR/workflows"
fi
if [ -d "src/shared_knowledge" ]; then
    # Copy shared knowledge
    cp -r "src/shared_knowledge" "$CONTENT_DIR/shared_knowledge"
fi
if [ -d "src/agents" ]; then
    # Copy agents
    cp -r "src/agents" "$CONTENT_DIR/agents"
fi

# Create placeholder structure if src/ doesn't have framework files yet
if [ ! -d "src/templates" ] && [ ! -d "src/workflows" ] && [ ! -d "src/shared_knowledge" ] && [ ! -d "src/agents" ]; then
    echo -e "${YELLOW}Framework files not found in src/, creating placeholder structure...${NC}"
    # Create placeholder directories
    mkdir -p "$CONTENT_DIR/templates"
    mkdir -p "$CONTENT_DIR/workflows"
    mkdir -p "$CONTENT_DIR/shared_knowledge"
    mkdir -p "$CONTENT_DIR/agents"
    
    # Create placeholder files
    echo "# Templates" > "$CONTENT_DIR/templates/README.md"
    echo "" >> "$CONTENT_DIR/templates/README.md"
    echo "Templates will be added here." >> "$CONTENT_DIR/templates/README.md"
    
    echo "# Workflows" > "$CONTENT_DIR/workflows/README.md"
    echo "" >> "$CONTENT_DIR/workflows/README.md"
    echo "Workflows will be added here." >> "$CONTENT_DIR/workflows/README.md"
    
    echo "# Shared Knowledge" > "$CONTENT_DIR/shared_knowledge/README.md"
    echo "" >> "$CONTENT_DIR/shared_knowledge/README.md"
    echo "Shared knowledge will be added here." >> "$CONTENT_DIR/shared_knowledge/README.md"
    
    echo "# Agents" > "$CONTENT_DIR/agents/README.md"
    echo "" >> "$CONTENT_DIR/agents/README.md"
    echo "Agent definitions will be added here." >> "$CONTENT_DIR/agents/README.md"
fi

# Copy package files
cp "README.md" "$CONTENT_DIR/README.md"
cp "LICENSE" "$CONTENT_DIR/LICENSE"

# Update version in csproj
sed -i "s/<Version>0\.1\.0<\/Version>/<Version>$VERSION<\/Version>/g" "src/AgentStudio.AI.Core.csproj"

# Build NuGet package
echo -e "${YELLOW}Building NuGet package...${NC}"
echo -e "${CYAN}Attempting to build package from 'AgentStudio.AI.Core.csproj'.${NC}"

# Check for .NET SDK (required for dotnet pack)
if ! command -v dotnet >/dev/null 2>&1; then
    echo -e "${RED}❌ .NET SDK not found. Please install .NET 8.0 SDK or later.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ .NET SDK found: $(dotnet --version)${NC}"

# Build NuGet package using dotnet pack
echo -e "${CYAN}Using dotnet pack to build package from 'AgentStudio.AI.Core.csproj'.${NC}"
if ! dotnet pack "src/AgentStudio.AI.Core.csproj" -c Release -o "$OUTPUT_DIR" --no-build; then
    echo -e "${RED}❌ dotnet pack failed${NC}"
    exit 1
fi

# Verify package was created
if [ ! -f "$OUTPUT_DIR/AgentStudio.AI.Core.$VERSION.nupkg" ]; then
    echo -e "${RED}❌ Package file not found: $OUTPUT_DIR/AgentStudio.AI.Core.$VERSION.nupkg${NC}"
    exit 1
fi

echo -e "${GREEN}Build complete! Package created in $OUTPUT_DIR${NC}"
echo -e "${CYAN}Package: AgentStudio.AI.Core.$VERSION.nupkg${NC}"
