#!/bin/bash

# --- Sovereign-Shield Setup Script (eyeC) ---
# This script prepares the environment for the C++ Engine and Ansible.

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}===============================================${NC}"
echo -e "${BLUE}   eyeC Sovereign-Shield: Environment Setup    ${NC}"
echo -e "${BLUE}===============================================${NC}"

# 1. Check for basic dependencies
check_dep() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}[!] $1 is not installed.${NC}"
        return 1
    else
        echo -e "${GREEN}[✔] $1 is found.${NC}"
        return 0
    fi
}

echo -e "\n[*] Checking system dependencies..."
DEPS=("cmake" "g++" "ansible" "git")
MISSING=0

for dep in "${DEPS[@]}"; do
    check_dep $dep || ((MISSING++))
done

if [ $MISSING -gt 0 ]; then
    echo -e "\n${RED}[✘] Please install missing dependencies before continuing.${NC}"
    echo "Hint: sudo apt update && sudo apt install cmake build-essential ansible git"
    exit 1
fi

# 2. Create local directories for the engine
echo -e "\n[*] Creating project structure..."
mkdir -p build
mkdir -p logs
echo -e "${GREEN}[✔] Directories created.${NC}"

# 3. Prepare the configuration file (Bootstrap-style)
if [ ! -f "config.json" ]; then
    echo -e "\n[*] Initializing configuration..."
    if [ -f "config.json.example" ]; then
        cp config.json.example config.json
        echo -e "${GREEN}[✔] config.json created from template.${NC}"
    else
        # Create a default one if example doesn't exist
        echo '{"project_name": "Sovereign-Shield", "organization": "eyeC"}' > config.json
        echo -e "${BLUE}[!] Template not found. Created a default config.json.${NC}"
    fi
else
    echo -e "\n[!] config.json already exists. Skipping..."
fi

# 4. Final instructions
echo -e "\n${BLUE}===============================================${NC}"
echo -e "${GREEN}      Setup completed successfully!            ${NC}"
echo -e "  To build the engine, run: ${BLUE}./build.sh${NC}"
echo -e "  To start the project, run: ${BLUE}./build/bin/SovereignShield${NC}"
echo -e "${BLUE}===============================================${NC}"

chmod +x build.sh