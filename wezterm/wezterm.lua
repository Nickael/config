local wezterm = require("wezterm")

-- Define theme paths using the user's home directory
local __THEME_DIR__ = os.getenv("HOME") .. "/.wezterm/themes/"
package.path = package.path .. ";" .. __THEME_DIR__ .. "?.lua"
local dark_theme = require("nord-dark")
local config = wezterm.config_builder()
config.bold_brightens_ansi_colors = "No"
config.colors = dark_theme.colors
config.cursor_blink_rate = 300
config.default_cursor_style = "BlinkingBlock"
config.default_prog = { "/bin/zsh", "-l" }
config.font_size = 15.0
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.window_close_confirmation = 'NeverPrompt'
config.window_padding = { left = 0, right = 0, top = 2, bottom = 0 }
config.window_background_opacity = 0.9
config.macos_window_background_blur = 50 -- Has effect only on macOS
config.window_decorations = "MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR | RESIZE | TITLE"
config.window_frame = {
  font = wezterm.font({ family = "Roboto", weight = "Bold" }),
  font_size = 18.0,
  inactive_titlebar_bg = '#1E2128',
  active_titlebar_bg = '#1E2128',
  inactive_titlebar_fg = '#E5E9F0',
  active_titlebar_fg = '#E5E9F0',
  inactive_titlebar_border_bottom = '#1E2128',
  active_titlebar_border_bottom = '#1E2128',
  button_fg = '#9ba5a8',
  button_bg = '#1E2128',
  button_hover_fg = '#9ba5a8',
  button_hover_bg = '#1E2128',
  font = require('wezterm').font 'Roboto',
  font_size = 14,
  border_left_width = '0.01cell',
  border_right_width = '0.01cell',
  border_bottom_height = '0.01cell',
  border_top_height = '0.01cell',
  border_left_color = '#1E2128',
  border_right_color = '#1E2128',
  border_bottom_color = '#1E2128',
  border_top_color = '#1E2128',
}
config.keys = {
  { key = "e", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "o", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  {
    key = 'a',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },
  {
    key = 'x',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },
}
return config
