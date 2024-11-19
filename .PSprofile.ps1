# ------------------------------- Initialization BEGIN -------------------------------

# 初始化 Starship 提示符
Invoke-Expression (&starship init powershell)

# 初始化 zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# 引入 PSReadLine 模块
Import-Module PSReadLine

# 设置 Emacs 风格快捷键
Set-PSReadLineOption -EditMode Emacs

# ------------------------------- Initialization END   -------------------------------


# ------------------------------- PSReadLine Configuration BEGIN -------------------------------

# 设置历史记录为预测文本来源
Set-PSReadLineOption -PredictionSource History

# 每次回溯历史时，将光标移到输入内容末尾
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# 设置 Tab 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete

# ------------------------------- PSReadLine Configuration END   -------------------------------


# ------------------------------- Alias Configuration BEGIN -------------------------------

# 设置 Python3 的别名
Set-Alias python3 python

# ------------------------------- Alias Configuration END   -------------------------------


# ------------------------------- Fuzzy Finder Configuration BEGIN -------------------------------

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

# 为 Ctrl+t 和 Ctrl+r 设置 fzf 快捷键
Set-PSReadLineKeyHandler -Key Ctrl+t -ScriptBlock { Invoke-FuzzySearch }
Set-PSReadLineKeyHandler -Key Ctrl+r -ScriptBlock {
    $historyPath = (Get-PSReadlineOption).HistorySavePath
    $selection = Get-Content $historyPath | fzf +s -m --tiebreak=index --tac --toggle-sort=ctrl-r
    if ($selection) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($selection)
    }
}

# ------------------------------- Fuzzy Finder Configuration END   -------------------------------


# ------------------------------- Conda Initialization BEGIN -------------------------------

# Conda 初始化
If (Test-Path "D:\App\anaconda\Scripts\conda.exe") {
    (& "D:\App\anaconda\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
}

# ------------------------------- Conda Initialization END   -------------------------------
