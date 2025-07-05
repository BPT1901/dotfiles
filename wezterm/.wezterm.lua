-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- config.color_scheme = 'cyberpunk' 

config.term = "xterm-256color"

-- This is where you actually apply your config choices

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size =16

config.enable_tab_bar = true
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = " " .. tab.active_pane.title .. " "
  if tab.is_active then
    return wezterm.format({
      { Background = { Color = "#CA24B1" } },
      { Foreground = { Color = "#2b2042" } },
      { Text = SOLID_LEFT_ARROW },
      { Background = { Color = "#2b2042" } },
      { Foreground = { Color = "#f0f0f0" } },
      { Text = title },
      { Background = { Color = "#CA24B1" } },
      { Foreground = { Color = "#2b2042" } },
      { Text = SOLID_RIGHT_ARROW },
    })
  else
    return wezterm.format({
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#1b1032" } },
      { Text = SOLID_LEFT_ARROW },
      { Background = { Color = "#1b1032" } },
      { Foreground = { Color = "#808080" } },
      { Text = title },
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#1b1032" } },
      { Text = SOLID_RIGHT_ARROW },
    })
  end
end)

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

config.colors = {
  foreground = "#F8F8F2",
  background = "#0D0221",
  cursor_bg = "#F6019D",
  cursor_border = "#F6019D",
  cursor_fg = "#0D0221",
  selection_bg = "#3D0075",
  selection_fg = "#F8F8F2",
  ansi = {
    "#000000", -- black
    "#FF2975", -- red
    "#00FF9F", -- green
    "#FFFF66", -- yellow
    "#00C3FF", -- blue
    "#FF20E6", -- magenta
    "#0FFBF9", -- cyan
    "#FFFFFF", -- white
  },
  brights = {
    "#666666", -- bright black
    "#FF65A3", -- bright red
    "#38FFB3", -- bright green
    "#FFFF99", -- bright yellow
    "#5EC3FF", -- bright blue
    "#FF6FFF", -- bright magenta
    "#70FFFF", -- bright cyan
    "#F8F8F2", -- bright white
  },
}

--[[
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#CA24B1",
	cursor_border = "#CA24B1",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#F724C6", "#A21B82" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}
]]

--#24EAF7

-- and finally, return the configuration to wezterm
return config