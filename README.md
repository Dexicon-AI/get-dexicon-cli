# Dexicon CLI

Index and search your AI coding assistant sessions (Cursor, Claude Code, VS Code Copilot, and more).

## Installation

### Quick Install (Recommended)

```bash
curl -sSL https://raw.githubusercontent.com/Dexicon-AI/get-dexicon-cli/main/install.sh | sh
```

### Homebrew (macOS/Linux)

```bash
brew install Dexicon-AI/tap/dexicon
```

### Manual Download

Download the appropriate binary for your platform from the [Releases](https://github.com/Dexicon-AI/get-dexicon-cli/releases) page:

| Platform | Binary |
|----------|--------|
| macOS Apple Silicon | `dexicon-cli-darwin-arm64` |
| macOS Intel | `dexicon-cli-darwin-amd64` |
| Linux x86_64 | `dexicon-cli-linux-amd64` |

Then make it executable and move to your PATH:

```bash
chmod +x dexicon-cli-*
sudo mv dexicon-cli-* /usr/local/bin/dexicon
```

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
