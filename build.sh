#!/bin/bash

# Terminal colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}[*] eyeC Sovereign-Shield: Starting build process...${NC}"

# Create build directory
mkdir -p build
cd build

# Run CMake and Compile
cmake ..
make

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[✔] Compilation successful!${NC}"
    echo -e "${BLUE}[*] You can now run: ./bin/SovereignShield${NC}"
else
    echo -e "\033[0;31m[✘] Compilation failed. Please check dependencies.${NC}"
fi