require("keybinds")
require("workspace_rules")
local palette = dofile("/home/shrimp/.config/stylix/palette.lua")
-- require("window_rules")
-- require("workspaces")

hl.env("JBR_FORCE_WAYLAND", "1")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")

hl.on("hyprland.start", function()
  hl.exec_cmd("wl-paste --watch cliphist store")
end)

hl.monitor({
  output = "eDP-1",
  mode = "preferred",
  position = "auto-down",
  scale = 1.0,
})

hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto-up",
  scale = 1.0,
})

hl.config({
  binds = {
    allow_workspace_cycles = true,
    workspace_back_and_forth = true,
  },

  cursor = {
    inactive_timeout = 0.500000
  },

  decoration = {
    shadow = {
      -- color=$base00
      color = "rgba(0, 0, 0, 0)"

    },
    active_opacity = 1.0,
    inactive_opacity = 0.65,
    rounding = 0
  },

  general = {
    border_size = 0,
    -- col.active_border=$base0D
    -- col.inactive_border=$base03
    gaps_in = 0,
    gaps_out = 0,
    layout = "master",
  },

  group = {
    groupbar = {
      -- col.active=$base0D
      col = {
        active = palette.base08,
        inactive = palette.base0B
      },
      gaps_in = 5,
      gaps_out = 0,
      render_titles = false,
    },
    -- col.border_active=$base0D
    -- col.border_inactive=$base03
    -- col.border_locked_active=$base0C
  },

  input = {
    touchpad = {
      natural_scroll = true,
    },
    follow_mouse = 3,
    kb_layout = "us,ru",
    kb_options = "grp:win_space_toggle",
    repeat_delay = 300,
    repeat_rate = 40
  },

  misc = {
    -- background_color=$base00,
    force_default_wallpaper = -1,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  },
})
