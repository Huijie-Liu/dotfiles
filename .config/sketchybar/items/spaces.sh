#!/bin/bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
  space=(
    background.color=$BACKGROUND_2
    background.corner_radius=8
    background.height=20
    background.drawing=off
    icon=${SPACE_ICONS[$((sid - 1))]}
    icon.padding_left=8
    icon.padding_right=8
    icon.highlight_color=$RED
    padding_left=5
    padding_right=2
    click_script="aerospace workspace $sid"
    script="$PLUGIN_DIR/aerospace.sh $sid"
  )
  sketchybar --add item space.$sid left \
    --set space.$sid "${space[@]}" \
    --subscribe space.$sid aerospace_workspace_change
done

spaces=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.border_width=2
  background.drawing=on
)

separator=(
  icon=􀆊
  icon.font="$FONT:Heavy:16.0"
  padding_left=15
  padding_right=15
  label.drawing=off
  associated_display=active
  click_script='aerospace workspace new && sketchybar --trigger space_change'
  icon.color=$WHITE
)

sketchybar --add bracket spaces '/space\..*/' \
  --set spaces "${spaces[@]}" \
  \
  --add item separator left \
  --set separator "${separator[@]}"
