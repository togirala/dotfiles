#!/usr/bin/env bash

# Soundwave animation frames
animation_frames=("▂▄▆" "▄▂▆" "▄▆▂" "▆▄▂" "▆▂▄")

while :; do
  status=$(playerctl status 2>/dev/null)

  if [ "$status" == "Playing" ]; then
    for frame in "${animation_frames[@]}"; do
      # Quick check to exit early if playback paused/stopped mid-loop
      if [ "$(playerctl status 2>/dev/null)" != "Playing" ]; then
        break
      fi
      echo "$frame"
      sleep 0.1
    done
  elif [ "$status" == "Paused" ]; then
    echo ""
    sleep 1 # Pause state is static; sleep longer to save CPU cycles
  else
    echo ""
    sleep 2 # No active player; deep sleep to reduce CPU overhead
  fi
done