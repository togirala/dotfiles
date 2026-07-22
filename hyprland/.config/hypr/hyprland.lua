-----------------------------------------------------------------------------------------
-- HYPRLAND LUA CONFIGURATION
-----------------------------------------------------------------------------------------

----------------
--- MONITORS ---
----------------

-- See https://wiki.hypr.land/Configuring/Monitors/
hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.monitor({
    output = "DP-2",
    mode = "preferred",
    position = "auto-right",
    scale = "auto",
    transform = 1,
})

-------------------
--- MY PROGRAMS ---
-------------------

local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "pkill wofi || wofi --show=drun"

-----------------
--- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
    -- Autostart applications on launch
    hl.exec_cmd("waybar & swaync & hyprpaper & hypridle")
    hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')

    -- Fix for Signal: Update D-Bus and systemd environments
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Start the gnome-keyring daemon
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")

    -- Set the cursor on startup
    hl.exec_cmd("hyprctl setcursor oxy-black 24")
end)

-- Unified Layer Rules (Hyprland v0.53+)
hl.layer_rule({
    match = { namespace = "^(waybar)$" },
    blur = true,
    ignore_alpha = true,
})

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

hl.env("XCURSOR_THEME", "oxy-black")
hl.env("XCURSOR_SIZE", "24")

hl.env("HYPRCURSOR_THEME", "oxy-black")
hl.env("HYPRCURSOR_SIZE", "24")

---------------------
--- LOOK AND FEEL ---
---------------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        ["col.active_border"] = "rgba(33ccffee) rgba(00ff99ee) 45deg",
        ["col.inactive_border"] = "rgba(595959aa)",
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    dwindle = {
        pseudotile = true,
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        left_handed = true,
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Default curves
hl.curve({ name = "easeOutQuint", x0 = 0.23, y0 = 1, x1 = 0.32, y1 = 1 })
hl.curve({ name = "easeInOutCubic", x0 = 0.65, y0 = 0.05, x1 = 0.36, y1 = 1 })
hl.curve({ name = "linear", x0 = 0, y0 = 0, x1 = 1, y1 = 1 })
hl.curve({ name = "almostLinear", x0 = 0.5, y0 = 0.5, x1 = 0.75, y1 = 1 })
hl.curve({ name = "quick", x0 = 0.15, y0 = 0, x1 = 0.1, y1 = 1 })

-- Animations
hl.animation({ name = "global", enabled = true, speed = 10, curve = "default" })
hl.animation({ name = "border", enabled = true, speed = 5.39, curve = "easeOutQuint" })
hl.animation({ name = "windows", enabled = true, speed = 4.79, curve = "easeOutQuint" })
hl.animation({ name = "windowsIn", enabled = true, speed = 4.1, curve = "easeOutQuint", style = "popin 87%" })
hl.animation({ name = "windowsOut", enabled = true, speed = 1.49, curve = "linear", style = "popin 87%" })
hl.animation({ name = "fadeIn", enabled = true, speed = 1.73, curve = "almostLinear" })
hl.animation({ name = "fadeOut", enabled = true, speed = 1.46, curve = "almostLinear" })
hl.animation({ name = "fade", enabled = true, speed = 3.03, curve = "quick" })
hl.animation({ name = "layers", enabled = true, speed = 3.81, curve = "easeOutQuint" })
hl.animation({ name = "layersIn", enabled = true, speed = 4, curve = "easeOutQuint", style = "fade" })
hl.animation({ name = "layersOut", enabled = true, speed = 1.5, curve = "linear", style = "fade" })
hl.animation({ name = "fadeLayersIn", enabled = true, speed = 1.79, curve = "almostLinear" })
hl.animation({ name = "fadeLayersOut", enabled = true, speed = 1.39, curve = "almostLinear" })
hl.animation({ name = "workspaces", enabled = true, speed = 1.94, curve = "almostLinear", style = "fade" })
hl.animation({ name = "workspacesIn", enabled = true, speed = 1.21, curve = "almostLinear", style = "fade" })
hl.animation({ name = "workspacesOut", enabled = true, speed = 1.94, curve = "almostLinear", style = "fade" })
hl.animation({ name = "zoomFactor", enabled = true, speed = 7, curve = "quick" })

-- Gestures
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- Per-device config
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

-------------------
--- KEYBINDINGS ---
-------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave-browser --ozone-platform=wayland --enable-features=UseOzonePlatform"))

-- Region Screenshot bound exclusively to SUPER + SHIFT + S
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("bash -c '$HOME/.local/bin/hyprshot -m region -o $HOME/Pictures/screenshots -f \"screenshot_$(date +%Y-%m-%d_%H-%M-%S).png\"'"))

-- Screen Lock
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.workspace(tostring(i)))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i) }))
end
hl.bind(mainMod .. " + 0", hl.dsp.workspace("10"))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.workspace("e+1"))
hl.bind(mainMod .. " + mouse_up", hl.dsp.workspace("e-1"))

-- Move/resize windows with mainMod + LMB/RMB dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.move_mouse(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize_mouse(), { mouse = true })

-- Multimedia keys (Volume & Brightness)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true, locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true, locked = true })

-- Playerctl Media keys
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true,
})