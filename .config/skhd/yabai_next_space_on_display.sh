#!/bin/bash
# yabai_prev_space_on_display.sh
# This script will focus the previous space in the current display

# What's the current display and space?
curdis=$(yabai -m query --displays --display | jq '.index')
curspa=$(yabai -m query --spaces --space | jq '.index')
# get all spaces
allspa=$(yabai -m query --spaces --display $curdis | jq ".[].index")
# get all spaces of index higher than current one
lowspa=$(yabai -m query --spaces --display $curdis | jq ".[].index | select(. < $curspa)")

if [ ! -z "$lowspa" ]
then
  # there is at least one space with lower index on this display, switch to it 
  set -- $lowspa
  yabai -m space --focus ${@: -1}
else
  # there is no space with lower index on this display, 
  # circle around to highest index space.
  # comment if you don't want to wrap around.
  set -- $allspa
  yabai -m space --focus ${@: -1}
fi
