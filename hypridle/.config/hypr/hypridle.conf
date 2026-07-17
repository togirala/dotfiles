general {
    lock_cmd = pidof hyprlock || hyprlock                                     # avoid starting multiple hyprlock instances.
    before_sleep_cmd = loginctl lock-session                                  # lock before suspend.
    after_sleep_cmd = hyprctl dispatch dpms on                                # to avoid having to press a key twice to turn on the display.
    
    # Force hypridle to drop the system into sleep states even if browsers or players say otherwise
    ignore_dbus_inhibit = true                                                # blocks browsers (like Chromium/Firefox) or Steam from halting idle
    ignore_systemd_inhibit = true                                             # blocks systemd-level sleep barriers
    ignore_wayland_inhibit = true                                             # blocks native wayland window idle requests
}

# Dim screen backlight
listener {
    timeout = 150                                 # 2.5min.
    on-timeout = brightnessctl -s set 10          # set monitor backlight to minimum, avoid 0 on OLED monitor.
    on-resume = brightnessctl -r                   # monitor backlight restore.
}

# Turn off keyboard backlight
# NOTE: 'rgb:kbd_backlight' is a placeholder. If your keyboard light doesn't change, 
# run `brightnessctl -l` in terminal and swap it with your exact device name (e.g., 'kbd_backlight').
listener { 
    timeout = 150                                             # 2.5min.
    on-timeout = brightnessctl -sd rgb:kbd_backlight set 0   # turn off keyboard backlight.
    on-resume = brightnessctl -rd rgb:kbd_backlight          # turn on keyboard backlight.
}

# Lock Session
listener {
    timeout = 300                                 # 5min
    on-timeout = loginctl lock-session            # lock screen when timeout has passed
}

# Turn display DPMS off
listener {
    timeout = 330                                 # 5.5min
    on-timeout = hyprctl dispatch dpms off        # screen off when timeout has passed (standard CLI syntax)
    on-resume = hyprctl dispatch dpms on          # screen on when activity is detected (standard CLI syntax)
}

# Suspend Computer
listener {
    timeout = 1800                                # 30min
    on-timeout = systemctl suspend                # suspend pc
}
