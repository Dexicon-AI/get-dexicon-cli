# Dexicon CLI

Index and search your AI coding assistant sessions (Cursor, Claude Code, VS Code Copilot, and more).

## Installation

### Quick Install (Recommended)

**macOS/Linux:**
```bash
curl -sSL https://raw.githubusercontent.com/Dexicon-AI/get-dexicon-cli/main/install.sh | sh
```

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/Dexicon-AI/get-dexicon-cli/main/install.ps1 | iex
```

### Homebrew (macOS/Linux)

```bash
brew install Dexicon-AI/tap/dexicon
```

### Manual Download

Download the appropriate binary for your platform from the [Releases](https://github.com/Dexicon-AI/get-dexicon-cli/releases) page:

| Platform | Binary |
|----------|--------|
| macOS Apple Silicon | `dexicon-cli-darwin-arm64.tar.gz` |
| macOS Intel | `dexicon-cli-darwin-amd64.tar.gz` |
| Linux x86_64 | `dexicon-cli-linux-amd64.tar.gz` |
| Windows x64 | `dexicon-cli-windows-amd64.zip` |

**macOS/Linux:**
```bash
tar -xzf dexicon-cli-*.tar.gz
chmod +x dexicon-cli/dexicon
sudo mv dexicon-cli/dexicon /usr/local/bin/dexicon
```

**Windows:**
1. Extract the zip file
2. Move the `dexicon-cli` folder to a permanent location (e.g., `C:\tools\dexicon-cli`)
3. Add the folder to your PATH, or run `dexicon.exe` directly from that location

## Getting Started

```bash
# Initialize and discover IDE session logs
dexicon init

# Log in to your Dexicon account
dexicon login

# Sync your sessions
dexicon sync
```

## About This Repo

This repository hosts pre-built binaries for the Dexicon CLI. For documentation and support, visit [dexicon.ai](https://dexicon.ai).
