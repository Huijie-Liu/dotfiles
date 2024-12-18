# ======================================
# Windows PowerShell 开发环境初始化脚本
# ======================================

# 定义颜色
$RED = "`e[31m"
$GREEN = "`e[32m"
$BLUE = "`e[34m"
$NC = "`e[0m"  # 无色

# 输出函数
function Info($msg) {
    Write-Host "${BLUE}[ℹ️  信息]${NC} $msg"
}

function Success($msg) {
    Write-Host "${GREEN}[✅ 成功]${NC} $msg"
}

function ErrorExit($msg) {
    Write-Host "${RED}[❌ 错误]${NC} $msg"
    exit 1
}

# 检查管理员权限
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# 提示并退出
function ExitIfNotAdmin {
    if (-not (Test-Admin)) {
        Write-Host "⚠️ 此脚本需要管理员权限。请以管理员身份运行 PowerShell。" -ForegroundColor Yellow
        exit 1
    }
}

# 检查命令是否存在
function CommandExists($command) {
    $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
}

# 设置执行策略
function Set-ExecutionPolicyIfNeeded {
    if ((Get-ExecutionPolicy -Scope CurrentUser) -ne 'RemoteSigned') {
        try {
            Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
            Success "执行策略已设置为 RemoteSigned"
        } catch {
            ErrorExit "无法设置执行策略为 RemoteSigned，请确保具有管理员权限。"
        }
    }
}

# 安装 Scoop
function Install-Scoop {
    if (-not (CommandExists 'scoop')) {
        Info "正在安装 Scoop..."
        try {
            Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
            if (CommandExists 'scoop') {
                Success "Scoop 安装完成"
            } else {
                ErrorExit "Scoop 安装失败，请检查网络连接或手动安装。"
            }
        } catch {
            ErrorExit "Scoop 安装过程中出错: $_"
        }
    } else {
        Success "Scoop 已安装，跳过..."
    }
}

# 使用 Scoop 安装工具
function Install-WithScoop($package) {
    if (-not (CommandExists $package)) {
        Info "安装 $package..."
        scoop install $package
        if (-not (CommandExists $package)) { ErrorExit "安装 $package 失败" }
        Success "$package 安装完成"
    } else {
        Success "$package 已安装，跳过..."
    }
}

# 安装和配置 Starship
function Configure-Starship {
    Install-WithScoop 'starship'
    Invoke-Expression (&starship init powershell)
}

# 安装并初始化 zoxide
function Configure-Zoxide {
    Install-WithScoop 'zoxide'
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# 安装并配置 PSReadLine
function Configure-PSReadLine {
    if (-not (Get-Module -ListAvailable -Name PSReadLine)) {
        Info "正在安装 PSReadLine 模块..."
        
        # 将 PSGallery 设置为受信任的库
        Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
        
        # 安装 PSReadLine 模块
        Install-Module PSReadLine -Force -Scope CurrentUser
        Import-Module PSReadLine
        Success "PSReadLine 模块安装完成。"
    } else {
        Info "PSReadLine 模块已安装，跳过安装步骤。"
        # 如果模块已安装，可以直接导入
        Import-Module PSReadLine
    }

    # 配置 PSReadLine
    Set-PSReadLineOption -EditMode Emacs
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete
}

# 创建 Python 3 别名
function Set-PythonAlias {
    Set-Alias python3 python
}

# 安装并配置 FZF
function Configure-FZF {
    Install-WithScoop 'fzf'
    $env:FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border"

    function Invoke-FuzzySearch {
        param([string]$directory = (Get-Location))
        $files = Get-ChildItem -Path $directory -Recurse -File | ForEach-Object { $_.FullName }
        if ($files) {
            $selected = $files | fzf
            if ($selected) { Set-Location (Split-Path $selected) }
        }
    }

    Set-PSReadLineKeyHandler -Key Ctrl+t -ScriptBlock { Invoke-FuzzySearch }
    Set-PSReadLineKeyHandler -Key Ctrl+r -ScriptBlock {
        $historyPath = (Get-PSReadLineOption).HistorySavePath
        $selection = Get-Content $historyPath | fzf +s -m --tiebreak=index --tac --toggle-sort=ctrl-r
        if ($selection) { [Microsoft.PowerShell.PSConsoleReadLine]::Insert($selection) }
    }
}

# 配置 Anaconda (Conda)
function Configure-Anaconda {
    $condaPath = "D:\App\anaconda\Scripts\conda.exe"
    if (Test-Path $condaPath) {
        (& $condaPath "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
        Success "Anaconda 配置完成"
    } else {
        Info "未找到 Anaconda 安装，跳过 Conda 配置..."
    }
}

# 软链接创建函数
function Create-Symlink($target, $linkName) {
    if (-not (Test-Path $linkName)) {
        New-Item -ItemType SymbolicLink -Path $linkName -Target $target | Out-Null
        Success "创建软链接 $linkName -> $target"
    } else {
        Success "$linkName 已存在，跳过..."
    }
}

# 创建基础配置目录
function Create-ConfigDirectories {
    $configDir = "$HOME\.config"
    $localBinDir = "$HOME\.local\bin"

    if (-not (Test-Path $configDir)) { New-Item -ItemType Directory -Path $configDir }
    if (-not (Test-Path $localBinDir)) { New-Item -ItemType Directory -Path $localBinDir }
}

# 创建配置文件软链接
function Link-Dotfiles {
    $DOTFILES_DIR = "$HOME\.dotfiles"
    
    # 创建 .condarc 的软链接
    Create-Symlink "$DOTFILES_DIR\.condarc" "$HOME\.condarc"

    # 配置文件夹中的所有项目
    if (Test-Path "$DOTFILES_DIR\.config") {
        Get-ChildItem -Path "$DOTFILES_DIR\.config" | ForEach-Object {
            Create-Symlink $_.FullName "$HOME\.config\$($_.Name)"
        }
    }
}

# ======================================
# 开始执行
# ======================================

# 提示并检查管理员权限
ExitIfNotAdmin

# 设置执行策略并安装 Scoop
Set-ExecutionPolicyIfNeeded
Install-Scoop

# 安装和配置各项工具
Configure-Starship
Configure-Zoxide
Configure-PSReadLine
Set-PythonAlias
Configure-FZF
Configure-Anaconda

# 创建配置目录和软链接
Create-ConfigDirectories
Link-Dotfiles

Write-Host "${GREEN}🎉 所有工具安装和配置完成！${NC}"
Write-Host "${GREEN}===============================${NC}"
Write-Host "${GREEN}🚀 环境已成功配置，享受你的开发之旅吧！${NC}"
Write-Host "${GREEN}===============================${NC}"

