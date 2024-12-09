-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Macchiato'

-- Modify the font
config.font = wezterm.font("JetBrains Mono NL")
config.font_size = 18

--- Disable the tab bar, switch this to 'true' to show tabs
config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 8

-- Key Bindings
config.disable_default_key_bindings = true

config.leader= { key = 'g', mods = 'SUPER', timeout_milliseconds = 1000 }
config.keys = {
    {
        key = 'c',
        mods = 'LEADER',
        action = act.SpawnTab "CurrentPaneDomain"
    },
    {
        key = 'x',
        mods = 'LEADER',
        action = act.CloseCurrentPane { confirm = false }
    },
    --- Open a pane to the right - this works well on my remapped moonlander
    --- needs work on my laptop :)
    {
        key = '(',
        mods = 'LEADER',
        action = act.SplitPane {
            direction = 'Right'
        }
    },
    --- Open a pane to the bottom, see above
    {
        key = '[',
        mods = 'LEADER',
        action = act.SplitPane {
            direction = 'Down'
        }
    },
    --- Navigate panes ---
    {
        key = 'k',
        mods = 'LEADER',
        action = act.ActivatePaneDirection "Up"
    },
    {
        key = 'j',
        mods = 'LEADER',
        action = act.ActivatePaneDirection "Down"
    },
    {
        key = 'h',
        mods = 'LEADER',
        action = act.ActivatePaneDirection "Left"
    },
    {
        key = 'l',
        mods = 'LEADER',
        action = act.ActivatePaneDirection "Right"
    },
    --- Copy, Cut and Paste
    --- NOTE: to get this to work correctly in neovim, I also had to add the
    --- following line to my neovim configuration:
    --- vim.opt.clipboard:append { 'unnamedplus' }
    {
        key = 'c',
        mods = 'CMD',
        action = act.CopyTo 'ClipboardAndPrimarySelection'
    },
    { key ='v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
    { key ='v', mods = 'CMD', action = act.PasteFrom 'PrimarySelection' },
    {
        key = 'x',
        mods = 'CMD',
        action = act.Multiple{
            act.CopyTo 'ClipboardAndPrimarySelection',
            act.ClearScrollback 'ScrollbackAndViewPort'
        }
    }
}

-- and finally, return the configuration to wezterm
return config
