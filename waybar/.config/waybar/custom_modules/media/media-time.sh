#!/usr/bin/env bash

# Prevent broken pipes if Waybar cuts the connection mid-execution
trap 'exit 0' PIPE

# Fetch current position and total length
time_info=$(playerctl metadata --format '{{duration(position)}}/{{duration(mpris:length)}}' 2>/dev/null)

# Sanitize: If playerctl returns a lonely "/", "0:00/", or is completely empty, 
# output nothing to prevent broken symbols on your status bar.
if [ "$time_info" == "/" ] || [[ "$time_info" =~ ^/ ]] || [ -z "$time_info" ]; then
    echo ""
else
    echo "$time_info"
fi
