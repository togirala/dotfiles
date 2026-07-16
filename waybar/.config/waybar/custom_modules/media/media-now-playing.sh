#!/usr/bin/env bash

# Clean up the background zscroll process and exit gracefully on exit or broken pipe
cleanup() {
  if [ -n "$zscroll_pid" ]; then
    kill "$zscroll_pid" 2>/dev/null
  fi
  exit 0
}
trap cleanup EXIT PIPE INT TERM

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
    zscroll_pid=""
    echo ""
  else
    # No active media player; output absolutely nothing and idle-sleep
    echo ""
    sleep 2
  fi
done
