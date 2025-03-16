#!/bin/bash

# Define constants
DOWNLOAD_DIR="/tmp/go-install"

# Create temporary directory
mkdir -p "$DOWNLOAD_DIR" || { echo "Failed to create temp directory"; exit 1; }

# Change to temporary directory
cd "$DOWNLOAD_DIR" || { echo "Failed to change directory"; exit 1; }

# Download latest Go version
wget "https://go.dev/dl/go1.24.1.linux-amd64.tar.gz" || { echo "Failed to download Go"; exit 1; }

# Remove previous Go installation if exists
sudo rm -rf "/usr/local/go"

# Extract downloaded archive
sudo tar -C "/usr/local" -xzf "go1.24.1.linux-amd64.tar.gz" || { echo "Failed to extract archive"; exit 1; }

# Set up environment variables
echo 'export GOROOT=/usr/local/go' >> ~/.profile
echo 'export GOPATH=$HOME/go' >> ~/.profile
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.profile

# Apply changes
source ~/.profile

# Clean up temporary directory
rm -rf "$DOWNLOAD_DIR"

# Verify installation
go version