# setup.ps1 — single-command Windows setup
#
# Usage (PowerShell as Admin):
#   irm https://cdn.jsdelivr.net/gh/Huijie-Liu/dotfiles@windows/setup.ps1 | iex
#
# Options:
#   irm ... | iex -Args "--dotfiles-only"   # Only symlink configs

param(
    [switch]$DotfilesOnly
)

$ErrorActionPreference = "Stop"

$GITHUB_REPO = "https://github.com/Huijie-Liu/dotfiles.git"
$REPO_BRANCH = "windows"

function info($msg)  { Write-Host "[INFO] $msg" -ForegroundColor Blue }
function ok($msg)     { Write-Host "[OK]   $msg" -ForegroundColor Green }
function warn($msg)   { Write-Host "[WARN] $msg" -ForegroundColor Yellow }
function err($msg)    { Write-Host "[ERR]  $msg" -ForegroundColor Red; exit 1 }
function header($msg) { Write-Host ""; Write-Host "=== $msg ===" -ForegroundColor Cyan }

# ── Admin check ──────────────────────────────────────
function Test-Admin {
    $u = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $u.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# ── Clone repo ───────────────────────────────────────
function Clone-Dotfiles {
    $DOTFILES_DIR = "$env:USERPROFILE\.dotfiles"
    if (Test-Path $DOTFILES_DIR) {
        info "Repo exists: $DOTFILES_DIR"
        git -C $DOTFILES_DIR pull --rebase origin $REPO_BRANCH 2>$null
        return $DOTFILES_DIR
    }

    header "Clone dotfiles"
    git clone --branch $REPO_BRANCH $GITHUB_REPO $DOTFILES_DIR
    ok "Cloned to $DOTFILES_DIR"
    return $DOTFILES_DIR
}

# ── Install Scoop ────────────────────────────────────
function Install-Scoop {
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        ok "Scoop already installed"
        return
    }
    header "Install Scoop"
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    ok "Scoop installed"
}

# ── Install packages ─────────────────────────────────
function Install-Packages {
    header "Install packages"

    $packages = @(
        "git", "fish", "neovim", "starship", "zoxide",
        "fzf", "eza", "bat", "fd", "ripgrep", "lazygit", "wezterm"
    )

    scoop bucket add extras 2>$null
    scoop bucket add versions 2>$null

    foreach ($pkg in $packages) {
        if (Get-Command $pkg -ErrorAction SilentlyContinue) {
            info "$pkg already installed"
            continue
        }
        info "Installing $pkg..."
        scoop install $pkg
    }
    ok "Packages installed"
}

# ── Symlink configs ──────────────────────────────────
function Link-Dotfiles {
    header "Link configs"

    $src = "$env:USERPROFILE\.dotfiles\.config"
    $dest = "$env:USERPROFILE\.config"

    if (-not (Test-Path $dest)) {
        New-Item -ItemType Directory -Path $dest -Force | Out-Null
    }

    Get-ChildItem -Path $src | ForEach-Object {
        $target = $_.FullName
        $link = Join-Path $dest $_.Name

        if ((Get-Item $link -ErrorAction SilentlyContinue).Target -eq $target) {
            return
        }

        if (Test-Path $link) {
            $bak = "$link.bak.$(Get-Date -Format 'yyyyMMddHHmmss')"
            Move-Item $link $bak
            info "Backed up: $link -> $bak"
        }

        New-Item -ItemType SymbolicLink -Path $link -Target $target -Force | Out-Null
        info "Linked: $link -> $target"
    }

    ok "Configs linked"
}

# ── Setup PowerShell profile ─────────────────────────
function Setup-Profile {
    header "Setup PowerShell profile"

    $profileDir = Split-Path $PROFILE -Parent
    if (-not (Test-Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    }

    $dotfilesProfile = "$env:USERPROFILE\.dotfiles\.PSprofile.ps1"
    $profileContent = @"
# Source dotfiles PowerShell profile
. "$dotfilesProfile"
"@

    if (-not (Test-Path $PROFILE)) {
        Set-Content -Path $PROFILE -Value $profileContent
        ok "PowerShell profile created"
    } elseif (-not (Select-String -Path $PROFILE -Pattern ".PSprofile.ps1" -SimpleMatch -Quiet)) {
        Add-Content -Path $PROFILE -Value "`n$profileContent"
        ok "PowerShell profile updated"
    } else {
        ok "PowerShell profile already configured"
    }
}

# ══════════════════════════════════════════════════════
# Main
# ══════════════════════════════════════════════════════

Write-Host ""
Write-Host "Dotfiles Setup (Windows)" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Admin)) {
    err "Run PowerShell as Administrator"
}

$DOTFILES_DIR = Clone-Dotfiles

if ($DotfilesOnly) {
    Link-Dotfiles
    Write-Host ""
    ok "Done! Configs linked to ~/.config/"
    return
}

Install-Scoop
Install-Packages
Link-Dotfiles
Setup-Profile

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host "  Setup complete!" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host ""
Write-Host "  Configs linked to: ~\.config\"
Write-Host "  Dotfiles dir:      $DOTFILES_DIR"
Write-Host ""
Write-Host "  Next steps:"
Write-Host "    • Create ~/.config/fish/conf.d/secrets.fish"
Write-Host "    • Restart terminal"
Write-Host ""
