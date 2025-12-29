local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.7
config.keys = {
  {
    key = "T",
    mods = "CTRL|SHIFT",
    action = wezterm.action{SpawnTab = "DefaultDomain" },
  },
  {
    key = "E",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  {
    key = "O",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    key = "Tab",
    mods = "CTRL",
    action = wezterm.action{ActivateTabRelative = 1 },
  },
  {
    key = "Tab",
    mods = "CTRL|SHIFT",
    action = wezterm.action{ActivateTabRelative = -1 },
  },
  {
    key = "h",
    mods = "ALT",
    action = wezterm.action{ActivatePaneDirection = "Left" },
  },
  {
    key = "j",
    mods = "ALT",
    action = wezterm.action{ActivatePaneDirection = "Down" },
  },
  {
    key = "k",
    mods = "ALT",
    action = wezterm.action{ActivatePaneDirection = "Up" },
  },
  {
    key = "l",
    mods = "ALT",
    action = wezterm.action{ActivatePaneDirection = "Right" },
  },
  {
    key = "h",
    mods = "ALT|SHIFT",
    action = wezterm.action{AdjustPaneSize = {"Left", 2} },
  },
  {
    key = "j",
    mods = "ALT|SHIFT",
    action = wezterm.action{AdjustPaneSize = {"Down", 2} },
  },
  {
    key = "k",
    mods = "ALT|SHIFT",
    action = wezterm.action{AdjustPaneSize = {"Up", 2} },
  },
  {
    key = "l",
    mods = "ALT|SHIFT",
    action = wezterm.action{AdjustPaneSize = {"Right", 2} },
  }
}

return config
