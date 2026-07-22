-----------------------------------------------------------------------------------------
-- HYPRLOCK LUA CONFIGURATION
-- Audited & Verified against hyprlock.conf
-----------------------------------------------------------------------------------------

-- Sourcing color palette (adjust path if needed)
-- source = ~/.config/hypr/vantaglow.conf

local font = "JetBrainsMono Nerd Font"
local accent = "$highlight"
local accentAlpha = "$highlightAlpha"

-----------------------------
--- GENERAL CONFIGURATION ---
-----------------------------

general = {
    disable_loading_bar = true,
    hide_cursor = false, -- Keeps cursor visible
    grace = 5, -- 5-second grace period to unlock without password
}

------------------------
--- SMOOTH ANIMATIONS ---
------------------------

animations = {
    enabled = true,
    bezier = {
        { "easeOutQuint", 0.16, 1, 0.3, 1 },
        { "easeInQuint", 0.64, 0, 0.78, 0 },
        { "linear", 0, 0, 1, 1 },
    },
    animation = {
        { "fadeIn", 1, 5, "easeOutQuint" },
        { "fadeOut", 1, 5, "easeInQuint" },
        { "inputFieldDots", 1, 4, "easeOutQuint" },
    },
}

------------------
--- BACKGROUND ---
------------------

background = {
    {
        path = "screenshot", -- Uses active live screenshot
        blur_passes = 3, -- High blur depth
        blur_size = 8,
        noise = 0.0117,
        contrast = 0.8916,
        brightness = 0.30, -- Heavily dimmed
        color = "$dark9_solid", -- Fallback solid color
    },
}

------------------
--- USER AVATAR ---
------------------

image = {
    {
        path = "~/.face",
        size = 100,
        border_size = 2,
        border_color = accent,
        position = { 0, 125 },
        halign = "center",
        valign = "center",
    },
}

-------------------
--- INPUT FIELD ---
-------------------

input_field = {
    {
        size = { 300, 60 },
        outline_thickness = 4,
        dots_size = 0.2,
        dots_spacing = 0.2,
        dots_center = true,
        outer_color = accent,
        inner_color = "$dark9",
        font_color = "$text",
        fade_on_empty = false,
        placeholder_text = '<span foreground="##ffffffaa"><i>󰌾 Enter Password...</i></span>',
        hide_input = false,

        -- Status colors
        check_color = accent,
        fail_color = "$red",
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>",
        capslock_color = "$yellow", -- Yellow border when Caps Lock is active

        position = { 0, -45 },
        halign = "center",
        valign = "center",
    },
}

--------------
--- LABELS ---
--------------

label = {
    -- 1. Dynamic Greeting
    {
        text = [[cmd[update:60000] echo "Good $(date +%H | awk '{if ($1<12) print "morning"; else if ($1<18) print "afternoon"; else print "evening"}')!"]],
        color = "$text",
        font_size = 15,
        font_family = font,
        position = { 0, 45 },
        halign = "center",
        valign = "center",
    },

    -- 2. Clock (Top-Right)
    {
        text = [[cmd[update:30000] echo "$(date +"%R")"]],
        color = "$text",
        font_size = 80,
        font_family = font,
        position = { -50, -50 },
        halign = "right",
        valign = "top",
    },

    -- 3. Date (Top-Right, under clock)
    {
        text = [[cmd[update:43200000] echo "$(date +"%A, %d %B %Y")"]],
        color = "$text",
        font_size = 20,
        font_family = font,
        position = { -50, -170 },
        halign = "right",
        valign = "top",
    },

    -- 4. Battery Indicator (Bottom-Left)
    {
        text = [[cmd[update:5000] BAT=$(ls /sys/class/power_supply/ | grep -E '^BAT[0-9]' | head -n 1); if [ -n "$BAT" ]; then status=$(cat /sys/class/power_supply/$BAT/status); cap=$(cat /sys/class/power_supply/$BAT/capacity); [ "$status" = "Charging" ] && echo -n "󱐋 "; echo "${cap}%"; else echo "󰚥 AC"; fi]],
        color = "$text",
        font_size = 14,
        font_family = font,
        position = { 50, 50 },
        halign = "left",
        valign = "bottom",
    },

    -- 5. Weather Widget (Top-Left)
    {
        text = [[cmd[update:3600000] echo "$(curl -s --connect-timeout 2 'wttr.in?format=%c+%t' || echo '󰖪 Weather Offline')"]],
        color = "$text",
        font_size = 14,
        font_family = font,
        position = { 50, -50 },
        halign = "left",
        valign = "top",
    },

    -- 6. Hostname & Uptime (Top-Left)
    {
        text = [[cmd[update:60000] echo "󰍹  $HOSTNAME | 󱘖  $(uptime -p | sed 's/up //')"]],
        color = "$text",
        font_size = 11,
        font_family = font,
        position = { 50, -95 },
        halign = "left",
        valign = "top",
    },

    -- 7. Active Network SSID (Bottom-Center)
    {
        text = [[cmd[update:10000] echo "󰖩  $(nmcli -t -f active,ssid dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2 || ip route | grep default | awk '{print $5}' || echo 'Disconnected')"]],
        color = "$text",
        font_size = 11,
        font_family = font,
        position = { 0, 50 },
        halign = "center",
        valign = "bottom",
    },

    -- 8. Compact System Resources (Bottom-Center)
    {
        text = [[cmd[update:5000] echo "  $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')%  |    $(free -m | awk '/Mem:/ {printf("%2.0f%%", $3/$2*100)}') "]],
        color = "$text",
        font_size = 11,
        font_family = font,
        position = { 0, 85 },
        halign = "center",
        valign = "bottom",
    },

    -- 9. Media Player (Bottom-Center)
    {
        text = [[cmd[update:1000] playerctl status 2>/dev/null | grep -q "Playing" && echo "󰎆  $(playerctl metadata title) - $(playerctl metadata artist)" || echo ""]],
        color = "$text",
        font_size = 11,
        font_family = font,
        position = { 0, 120 },
        halign = "center",
        valign = "bottom",
    },

    -- 10. Multi-Line Open Apps List (Bottom-Right)
    {
        text = [[cmd[update:2000] apps=$(hyprctl clients | grep "class: " | sed 's/^.*class: //' | sort -u | sed 's/^/    /'); [ -n "$apps" ] && printf "󱡠  Active Windows\n%s" "$apps" || printf "󱡠  No active windows"]],
        color = "$text",
        font_size = 11,
        font_family = font,
        position = { -50, 50 },
        halign = "right",
        valign = "bottom",
        align = "left",
    },
}