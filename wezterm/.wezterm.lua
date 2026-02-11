local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.automatically_reload_config = true
config.enable_tab_bar = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.default_cursor_style = "BlinkingBar"
config.color_scheme = "cyberpunk"
config.font = wezterm.font("JetBrains Mono", {weight = "Bold"})
config.font_size = 16

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
  position = "top",
  max_width = 32,
  padding = {
    left = 1,
    right = 1,
    tabs = {
      left = 0,
      right = 2,
    },
  },
  separator = {
    space = 1,
    left_icon = wezterm.nerdfonts.fa_long_arrow_right,
    right_icon = wezterm.nerdfonts.fa_long_arrow_left,
    field_icon = wezterm.nerdfonts.indent_line,
  },
  modules = {
    tabs = {
      active_tab_fg = 4,
      inactive_tab_fg = 6,
      new_tab_fg = 2,
    },
    workspace = {
      enabled = false,
      icon = wezterm.nerdfonts.cod_window,
      color = 8,
    },
    leader = {
      enabled = false,
      icon = wezterm.nerdfonts.oct_rocket,
      color = 2,
    },
    zoom = {
      enabled = false,
      icon = wezterm.nerdfonts.md_fullscreen,
      color = 4,
    },
    pane = {
      enabled = false,
      icon = wezterm.nerdfonts.cod_multiple_windows,
      color = 7,
    },
    username = {
      enabled = false,
      icon = wezterm.nerdfonts.fa_user,
      color = 6,
    },
    hostname = {
      enabled = true,
      icon = wezterm.nerdfonts.cod_server,
      color = 8,
    },
    clock = {
      enabled = false,
      icon = wezterm.nerdfonts.md_calendar_clock,
      format = "%H:%M",
      color = 5,
    },
    cwd = {
      enabled = false,
      icon = wezterm.nerdfonts.oct_file_directory,
      color = 7,
    },
    spotify = {
      enabled = false,
      icon = wezterm.nerdfonts.fa_spotify,
      color = 3,
      max_width = 64,
      throttle = 15,
    },
  },
})

config.window_background_opacity = 1.0
config.macos_window_background_blur = 0
config.background = {
  {
    source = {
      File = "/Users/benturner/Downloads/joydivision.png",
    },
    hsb = {
      hue = 1.0,
      saturation = 1.02,
      brightness = 0.25,
    },
  },
  {
    source = {
      Color = "#282c35",
    },
    width = "80%",
    height = "80%",
    opacity = 0.50,
  },
}

config.colors = {
  tab_bar = {
    background = '#9370db',  -- Medium purple for overall tab bar
    active_tab = {
      bg_color = '#ffb6c1',  -- Light pink for active tab
      fg_color = '#000000',  -- Black text
    },
    inactive_tab = {
      bg_color = '#e6d5e6',  -- Very light pinkish/lavender
      fg_color = '#666666',  -- Gray text
    },
  }
}

return config

