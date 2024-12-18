# ------------------------------- 初始化 BEGIN -------------------------------
# 初始化 Starship 提示符
Invoke-Expression (&starship init powershell)

# 初始化 zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# 引入 PSReadLine 模块并设置 Emacs 风格快捷键
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs

# 配置 fnm (Fast Node Manager)
fnm env --use-on-cd | Out-String | Invoke-Expression

# ------------------------------- PSReadLine 配置 BEGIN -------------------------------
# 设置历史记录为预测文本来源
Set-PSReadLineOption -PredictionSource History

# 设置历史回溯时光标移动至输入末尾
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# 设置 Tab 键为菜单补全与 Intellisense
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete

# ------------------------------- 自定义函数配置 BEGIN -------------------------------
# 终端操作
Function c { Clear }

# 编辑 PowerShell 配置文件
Function e { nvim $env:USERPROFILE\.dotfiles\.PSprofile.ps1 }

# 替换默认 ls 命令为 eza
Remove-Item Alias:\ls
Function ls { eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions $args }
Function l { eza -la --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions $args }
Function ll { eza --long --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions $args }
Function la { eza -la --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions $args }
Function lla { eza --long -la --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions $args }

# 使用 Python 3
Function python { python3 $args }

# 使用 Lazygit
Function lg { lazygit $args }

# 显示系统信息
Function ff { fastfetch $args }

# ------------------------------- Fuzzy Finder 配置 BEGIN -------------------------------
# 设置 fzf 默认参数
$env:FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border"

# 文件模糊搜索函数
function Invoke-FuzzySearch {
    param([string]$directory = (Get-Location))
    $files = Get-ChildItem -Path $directory -Recurse -File | ForEach-Object { $_.FullName }
    if ($files) {
        $selected = $files | fzf
        if ($selected) {
            Set-Location (Split-Path $selected)
        }
    }
}

# 设置 fzf 快捷键
Set-PSReadLineKeyHandler -Key Ctrl+t -ScriptBlock { Invoke-FuzzySearch }
Set-PSReadLineKeyHandler -Key Ctrl+r -ScriptBlock {
    $historyPath = (Get-PSReadlineOption).HistorySavePath
    $selection = Get-Content $historyPath | fzf +s -m --tiebreak=index --tac --toggle-sort=ctrl-r
    if ($selection) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($selection)
    }
}

# ------------------------------- Conda 初始化 BEGIN -------------------------------
If (Test-Path "D:\App\anaconda\Scripts\conda.exe") {
    (& "D:\App\anaconda\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
}

