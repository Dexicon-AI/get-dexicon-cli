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

> **Note:** After installation, restart PowerShell for PATH changes to take effect.

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

1. Download `dexicon-cli-windows-amd64.zip` from the [Releases](https://github.com/Dexicon-AI/get-dexicon-cli/releases) page
2. Right-click the zip → **Extract All** → choose a location (e.g., `C:\tools`)
3. This creates a `dexicon-cli` folder containing `dexicon.exe`

**Option A: Run directly (no PATH setup):**
```powershell
& "C:\tools\dexicon-cli\dexicon.exe" --version
& "C:\tools\dexicon-cli\dexicon.exe" init
```

**Option B: Add to PATH (run from anywhere):**
1. Press **Windows key**, type **Environment Variables**, click "Edit the system environment variables"
2. Click **Environment Variables**
3. Under "User variables", select **Path**, click **Edit**
4. Click **New**, add the path to your dexicon-cli folder (e.g., `C:\tools\dexicon-cli`)
5. Click **OK** on all windows
6. Restart PowerShell, then run `dexicon --version`

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
