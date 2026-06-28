hl.monitor({
  output = "DP-1",
  mode = "preferred",
  position = "auto",
  scale = "auto",
  cm = "hdredid",
  bitdepth = 16,
  sdrbrightness = 3.0,
})

hl.monitor({
  output = "DP-2",
  mode = "preferred",
  position = "2560x0",
  scale = "auto",
})

hl.on("hyprland.start", function()
  hl.exec_cmd("wl-gammarelay")
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")


hl.config({
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 2,
    col = {
      active_border = {
        colors = { "rgba(84c66fff)", "rgba(84c66fff)" },
        angle = 45,
      },
      inactive_border = "rgba(999999ff)",
    },
    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
  },
  decoration = {
    rounding = 5,
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
  animations = {
    enabled = true,
  },
  dwindle = {
    preserve_split = true,
  },
  master = {
    new_status = "master",
  },
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
  },
})

hl.bind("SUPER + SHIFT + CTRL + C", hl.dsp.window.close())
hl.bind("ALT + TAB", hl.dsp.window.cycle_next())
hl.bind("SUPER + SHIFT + CTRL + M", hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.exit()'"))

hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd("toggle_dark_mode"))

hl.bind("SUPER + Space", hl.dsp.exec_cmd("tofi-drun --drun-launch=true"))
hl.bind("SUPER + Return", hl.dsp.exec_cmd("ghostty"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("dolphin"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("google-chrome-stable"))
hl.bind("SUPER + CTRL + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))

hl.bind("SUPER + CTRL + ALT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + CTRL + ALT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + CTRL + ALT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + CTRL + ALT + right", hl.dsp.window.move({ direction = "r" }))

hl.bind("SUPER + h", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "d" }))

for i = 1, 10 do
  local key = i % 10
  hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind("SUPER + M", hl.dsp.workspace.toggle_special("music"))
hl.bind("SUPER + SHIFT + M", hl.dsp.window.move({ workspace = "special:music" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

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
