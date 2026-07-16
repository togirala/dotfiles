#!/usr/bin/env bash
# Optimized auto-reload script for Waybar.
# Watches only key files to avoid infinite loops from editor swap/temp files.

CONFIG_DIR="$HOME/.config/waybar"

# Ensure inotify-tools is installed
if ! command -v inotifywait &> /dev/null; then
    echo "Error: 'inotify-tools' is not installed on your system."
    echo "Please run: sudo apt install inotify-tools"
    exit 1
fi

echo "Waybar auto-reload watcher active. Monitoring configuration changes..."

while true; do
    # Only trigger reload for changes to actual target configuration files
    inotifywait -e close_write \
        "$CONFIG_DIR/config.jsonc" \
        "$CONFIG_DIR/config-minimal.jsonc" \
        "$CONFIG_DIR/style.css" \
        "$CONFIG_DIR/style-minimal.css" 2>/dev/null
    
    echo "Configuration update detected! Reloading Waybar..."
    killall -SIGUSR2 waybar || {
        echo "Waybar is not running. Launching active instance..."
        waybar &
    }
done