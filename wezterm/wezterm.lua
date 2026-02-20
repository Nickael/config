local wezterm = require("wezterm")
local mux = wezterm.mux

-- Correctly handle the initial window maximization with a slight delay
wezterm.on('gui-startup', function(cmd)
    local _, _, window = mux.spawn_window(cmd or {})
    wezterm.sleep_ms(50) -- Increased delay for better OS compatibility
    window:gui_window():maximize()
end)

local config = wezterm.config_builder()

-- Dynamic Theme Loading
local theme_dir = wezterm.home_dir .. "/.wezterm/themes/"
package.path = package.path .. ";" .. theme_dir .. "?.lua"

local ok, dark_theme = pcall(require, "nord-dark")
if ok then
    config.colors = dark_theme.colors
end

-- FONT CONFIGURATION
-- This uses an ordered list; if "Roboto Mono" isn't found, it tries JetBrains Mono, etc.
config.font = wezterm.font_with_fallback({
    { family = "JetBrainsMono Nerd Font Mono", weight = "Bold" },
    { family = "JetBrains Mono", weight = "Regular" },
    "Menlo",
    "Monaco",
})
config.font_size = 15.0

-- UI Settings
config.bold_brightens_ansi_colors = "BrightAndBold"
config.cursor_blink_rate = 300
config.default_cursor_style = "BlinkingBlock"
config.default_prog = { "/bin/zsh", "-l" }
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

-- Sizing & Opacity
config.window_background_opacity = 0.95
config.macos_window_background_blur = 50
config.initial_cols = 120
config.initial_rows = 35

-- Window Appearance
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = "MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR | RESIZE | TITLE"
config.window_padding = { left = 0, right = 0, top = 2, bottom = 0 }

config.window_frame = {
    active_titlebar_bg = '#1E2128',
    active_titlebar_border_bottom = '#1E2128',
    active_titlebar_fg = '#E5E9F0',
    border_bottom_color = '#1E2128',
    border_bottom_height = '0.01cell',
    -- Titlebar font uses standard system font for stability
    font = wezterm.font({ family = "Helvetica", weight = "Bold" }),
    font_size = 12,
    inactive_titlebar_bg = '#1E2128',
    inactive_titlebar_fg = '#E5E9F0',
}

-- Keybindings
config.keys = {
    -- Cmd + Enter: Toggle Fullscreen
    { key = 'Enter', mods = 'CMD', action = wezterm.action.ToggleFullScreen },

    -- macOS Style Navigation (Cmd + Arrows)
    { key = 'LeftArrow', mods = 'CMD', action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' } },
    { key = 'RightArrow', mods = 'CMD', action = wezterm.action.SendKey { key = 'e', mods = 'CTRL' } },

    -- Splitting Panes
    { key = "e", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "o", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

    -- Zoom Current Pane
    { key = 'x', mods = 'CTRL|SHIFT', action = wezterm.action.TogglePaneZoomState },
}

return config
