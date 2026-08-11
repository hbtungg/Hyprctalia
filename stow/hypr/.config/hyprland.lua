-- CachyOS Hyprland Configuration

require("config.animations")
require("config.autostart")
require("config.colors")
require("config.decorations")
require("config.variables")
require("config.environment")
require("config.inputs")
require("config.binds")
require("config.misc")
require("config.monitors")
require("config.windowrules")
require("config.workspaces")

hl.layer_rule({

    name = "noctalia",

    match = {

        namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",

    },

    no_anim = true,

    ignore_alpha = 0.5,

    blur = true,

    blur_popups = true,

})



