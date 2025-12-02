#!/usr/bin/env bash
#
# Dexicon CLI Installer
#
# Usage:
#   curl -sSL https://raw.githubusercontent.com/Dexicon-AI/get-dexicon-cli/main/install.sh | sh
#
# Environment variables:
#   DEXICON_VERSION - Install a specific version (e.g., "v0.2.1"). Default: latest
#   DEXICON_INSTALL_DIR - Installation directory. Default: /usr/local/bin
#

set -euo pipefail

REPO="Dexicon-AI/get-dexicon-cli"
INSTALL_DIR="${DEXICON_INSTALL_DIR:-/usr/local/bin}"
BINARY_NAME="dexicon"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() {
    echo -e "${BLUE}==>${NC} $1"
}

success() {
    echo -e "${GREEN}==>${NC} $1"
}

warn() {
    echo -e "${YELLOW}WARNING:${NC} $1"
}

error() {
    echo -e "${RED}ERROR:${NC} $1" >&2
    exit 1
}

# Detect OS
detect_os() {
    local os
    os="$(uname -s)"
    case "$os" in
        Darwin) echo "darwin" ;;
        Linux) echo "linux" ;;
        *) error "Unsupported operating system: $os" ;;
    esac
}

# Detect architecture
detect_arch() {
    local arch
    arch="$(uname -m)"
    case "$arch" in
        x86_64|amd64) echo "amd64" ;;
        arm64|aarch64) echo "arm64" ;;
        *) error "Unsupported architecture: $arch" ;;
    esac
}

# Get the latest version from GitHub releases
get_latest_version() {
    local latest
    latest=$(curl -sSL "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
    if [ -z "$latest" ]; then
        error "Failed to fetch latest version. Please check your internet connection or specify DEXICON_VERSION."
    fi
    echo "$latest"
}

# Download and install
install() {
    local os arch version binary_name download_url tmp_dir

    os=$(detect_os)
    arch=$(detect_arch)

    # Check for arm64 on Linux (not supported yet)
    if [ "$os" = "linux" ] && [ "$arch" = "arm64" ]; then
        error "Linux ARM64 is not currently supported. Please use Linux AMD64 or macOS."
    fi

    # Get version
    if [ -n "${DEXICON_VERSION:-}" ]; then
        version="$DEXICON_VERSION"
        info "Installing Dexicon CLI $version..."
    else
        info "Fetching latest version..."
        version=$(get_latest_version)
        info "Installing Dexicon CLI $version..."
    fi

    binary_name="dexicon-cli-${os}-${arch}"
    download_url="https://github.com/${REPO}/releases/download/${version}/${binary_name}"

    info "Detected: $os/$arch"
    info "Downloading from: $download_url"

    # Create temp directory
    tmp_dir=$(mktemp -d)
    trap 'rm -rf "$tmp_dir"' EXIT

    # Download binary
    if ! curl -sSL --fail -o "${tmp_dir}/${BINARY_NAME}" "$download_url"; then
        error "Failed to download binary. Please check if version '$version' exists."
    fi

    # Make executable
    chmod +x "${tmp_dir}/${BINARY_NAME}"

    # Install to target directory
    info "Installing to ${INSTALL_DIR}/${BINARY_NAME}..."

    if [ -w "$INSTALL_DIR" ]; then
        mv "${tmp_dir}/${BINARY_NAME}" "${INSTALL_DIR}/${BINARY_NAME}"
        # Remove macOS quarantine attribute
        if [ "$(uname -s)" = "Darwin" ]; then
            xattr -d com.apple.quarantine "${INSTALL_DIR}/${BINARY_NAME}" 2>/dev/null || true
        fi
    else
        info "Requesting sudo access to install to $INSTALL_DIR..."
        sudo mv "${tmp_dir}/${BINARY_NAME}" "${INSTALL_DIR}/${BINARY_NAME}"
        # Remove macOS quarantine attribute (needs sudo)
        if [ "$(uname -s)" = "Darwin" ]; then
            sudo xattr -d com.apple.quarantine "${INSTALL_DIR}/${BINARY_NAME}" 2>/dev/null || true
        fi
    fi

    # Verify installation
    if command -v "$BINARY_NAME" &> /dev/null; then
        success "Dexicon CLI installed successfully!"
        echo ""
        "$BINARY_NAME" --version 2>/dev/null || "$BINARY_NAME" version
        echo ""
        success "Get started with: dexicon init"
    else
        warn "Installation complete, but '${BINARY_NAME}' is not in your PATH."
        echo "Add ${INSTALL_DIR} to your PATH, or run:"
        echo "  ${INSTALL_DIR}/${BINARY_NAME} --version"
    fi
}

# Run installer
install
