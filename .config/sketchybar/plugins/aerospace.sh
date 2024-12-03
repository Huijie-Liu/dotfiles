#!/bin/bash

# 获取传入的工作区 ID
WORKSPACE_ID=$1

# 动态生成 label（获取当前工作区的所有应用）
generate_label() {
  # 获取当前工作区的窗口列表
  apps=$(aerospace list-windows --workspace "$WORKSPACE_ID" | awk -F'|' '{
    gsub(/^ +| +$/, "", $2);  # 去除前后空格
    print $2;                # 提取应用名称
  }' | sort -u)              # 去重并生成应用列表

  icon_strip=" "  # 初始化图标字符串

  # 如果存在应用程序
  if [ -n "$apps" ]; then
    while IFS= read -r app; do
      # 调用 icon_map.sh 获取图标
      icon=$("$HOME/.config/sketchybar/plugins/icon_map.sh" "$app")
      icon=${icon:-:default:}  # 设置默认图标
      icon_strip+=" $icon"     # 拼接图标字符串
    done <<< "$apps"
  fi

  # 返回拼接的图标标签，去除最后的多余空格
  echo "$icon_strip" | sed 's/ $//'
}

# 更新项目状态
update() {
  WIDTH="dynamic"
  if [ "$SELECTED" = "true" ]; then
    WIDTH="0"
  fi

  # 动态生成 label 并设置到项目中
  LABEL=$(generate_label)

  sketchybar --animate tanh 20 --set $NAME \
    icon.highlight=$SELECTED \
    label="$LABEL" \
    label.width=$WIDTH \
    label.font="sketchybar-app-font:Regular:16.0" \
    label.padding_right=16 \
    label.background.height=26 \
    label.background.drawing=on \
    label.background.color=$BACKGROUND_2 \
    label.background.corner_radius=8 \
    label.drawing=on \
    update=on
}

# 判断是否为当前焦点的工作区
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on
else
  sketchybar --set $NAME background.drawing=off
fi

# 调用更新函数
update