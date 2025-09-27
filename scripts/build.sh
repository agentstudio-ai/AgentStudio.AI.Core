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

# Copy framework files (when they're ready)
if [ -d ".agentstudio-ai" ]; then
    echo -e "${YELLOW}Framework files found, copying...${NC}"
    # Copy templates
    if [ -d ".agentstudio-ai/templates" ]; then
        cp -r ".agentstudio-ai/templates" "$CONTENT_DIR/templates"
    fi
    # Copy workflows
    if [ -d ".agentstudio-ai/workflows" ]; then
        cp -r ".agentstudio-ai/workflows" "$CONTENT_DIR/workflows"
    fi
    # Copy shared knowledge
    if [ -d ".agentstudio-ai/shared_knowledge" ]; then
        cp -r ".agentstudio-ai/shared_knowledge" "$CONTENT_DIR/shared_knowledge"
    fi
    # Copy agents
    if [ -d ".agentstudio-ai/agents" ]; then
        cp -r ".agentstudio-ai/agents" "$CONTENT_DIR/agents"
    fi
else
    echo -e "${YELLOW}Framework files not found, creating placeholder structure...${NC}"
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

# Update version in nuspec
sed -i "s/<version>0\.1\.0<\/version>/<version>$VERSION<\/version>/g" "src/AgentStudio.AI.Core.nuspec"

# Build NuGet package
echo -e "${YELLOW}Building NuGet package...${NC}"
nuget pack "src/AgentStudio.AI.Core.nuspec" -OutputDirectory "$OUTPUT_DIR" -Version "$VERSION"

echo -e "${GREEN}Build complete! Package created in $OUTPUT_DIR${NC}"
echo -e "${CYAN}Package: AgentStudio.AI.Core.$VERSION.nupkg${NC}"
