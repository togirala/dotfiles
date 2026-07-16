#!/usr/bin/env bash

# Runs zscroll when a player is active, and cleanly terminates it when the player closes.
# This ensures that when no music is playing, the output is TRULY empty,
# forcing Waybar to hide the styled backgrounds/borders of #custom-media-now-playing.

while :; do
  status=$(playerctl status 2>/dev/null)
  
  if [ -n "$status" ]; then
    # Start zscroll in the background and route its scrolled output directly to stdout
    zscroll -l 20 \
        --delay 0.3 \
        --update-check true \
        "playerctl metadata --format '{{title}} - {{artist}}'" 2>/dev/null &
        
    zscroll_pid=$!
    
    # Check every second if the player is still active
    while [ -n "$(playerctl status 2>/dev/null)" ]; do
      sleep 1
    done
    
    # Clean up zscroll process cleanly once playback fully stops
    kill "$zscroll_pid" 2>/dev/null
    wait "$zscroll_pid" 2>/dev/null
    echo ""
  else
    # No active media player; output absolutely nothing and idle-sleep
    echo ""
    sleep 2
  fi
done