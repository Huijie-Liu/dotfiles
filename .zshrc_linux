# 性能分析配置和工具函数
: ${ZSH_PROFILE_STARTUP:=false}

# 性能分析工具函数
function _init_perf() {
    zmodload zsh/datetime
    typeset -gA start_times end_times
    start_times[total]=$EPOCHREALTIME
}

function _log_perf() {
    if ! $ZSH_PROFILE_STARTUP; then
        return
    fi
    local section=$1
    local start=$2
    local end=$3
    local duration=$(( (end - start) * 1000 ))
    printf "\033[0;36m%s:\033[0m \033[0;33m%.2f ms\033[0m\n" "$section" $duration
}

function _print_perf_report() {
    if ! $ZSH_PROFILE_STARTUP; then
        return
    fi
    echo "\n\033[1;34m性能报告:\033[0m"
    _log_perf "Basic Setup" $start_times[basic] $end_times[basic]
    _log_perf "Config Check" $start_times[config_check] $end_times[config_check]
    _log_perf "Modules Loading" $start_times[modules] $end_times[modules]
    echo "\033[1;34m──────────────────────\033[0m"
    _log_perf "Total Time" $start_times[total] $end_times[total]
}

# 检查是否在 Linux 环境
if [[ "$(uname)" != "Linux" ]]; then
    echo "\033[0;31mWarning: This configuration is intended for Linux systems\033[0m"
    return 1
fi

# 初始化性能分析
_init_perf

# 基础设置
start_times[basic]=$EPOCHREALTIME
umask 022
[[ -e $HISTFILE ]] && chmod 600 $HISTFILE
end_times[basic]=$EPOCHREALTIME

# 检查配置目录
start_times[config_check]=$EPOCHREALTIME
[[ ! -d ~/.config/zsh ]] && mkdir -p ~/.config/zsh
end_times[config_check]=$EPOCHREALTIME

# 模块加载
start_times[modules]=$EPOCHREALTIME
if [ -d ~/.config/zsh ]; then
    for conf in ~/.config/zsh/*.zsh; do
        if [[ -r $conf ]]; then
            local module_start=$EPOCHREALTIME
            source $conf
            local module_end=$EPOCHREALTIME
            _log_perf "module: ${conf:t}" $module_start $module_end
        else
            echo "\033[0;31mWarning: Unable to read config file $conf\033[0m"
        fi
    done
fi
end_times[modules]=$EPOCHREALTIME

# 结束总计时并输出统计信息
end_times[total]=$EPOCHREALTIME

# 在文件末尾输出性能报告
_print_perf_report
