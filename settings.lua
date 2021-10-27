data:extend({
    --------- Armory settings ---------
    {
        type = "double-setting",
        name = "heli-gun-damage-modifier",
        setting_type = "startup",
        default_value = 1,
        minimum_value = 0.1,
    },
    {
        type = "int-setting",
        name = "heli-gun-range",
        setting_type = "startup",
        default_value = 20,
        minimum_value = 0,
    },
    {
        type = "double-setting",
        name = "heli-flamethrower-damage-modifier",
        setting_type = "startup",
        default_value = 1.2,
        minimum_value = 0.1,
    },
    {
        type = "int-setting",
        name = "heli-flamethrower-range",
        setting_type = "startup",
        default_value = 50,
        minimum_value = 0,
    },
    {
        type = "double-setting",
        name = "heli-rocket-damage-modifier",
        setting_type = "startup",
        default_value = 1,
        minimum_value = 0.1,
    },
    {
        type = "int-setting",
        name = "heli-rocket-launcher-range",
        setting_type = "startup",
        default_value = 30,
        minimum_value = 0,
    },
    {
        type = "double-setting",
        name = "heli-k2-anti-material-gun-damage-modifier",
        setting_type = "startup",
        default_value = 1,
        minimum_value = 0.1,
    },
    {
        type = "int-setting",
        name = "heli-k2-anti-material-gun-range",
        setting_type = "startup",
        default_value = 70,
        minimum_value = 0,
    },

    ------------------------------
    {
        type = "string-setting",
        name = "heli-consumption",
        setting_type = "startup",
        default_value = "3.2MW",
    },
    {
        type = "string-setting",
        name = "heli-braking-power",
        setting_type = "startup",
        default_value = "1MW",
    },
    {
        type = "int-setting",
        name = "heli-weight",
        setting_type = "startup",
        default_value = 2800,
        minimum_value = 0,
    },
    
    ------------- Misc -------------------
    {
        type = "bool-setting",
        name = "heli-deactivate-inserters",
        setting_type = "runtime-global",
        default_value = true,
    },

    {
        type = "double-setting",
        name = "heli-crash-dmg-mult",
        setting_type = "runtime-global",
        default_value = 1,
        minimum_value = 0,
    },

    ----------------------------------------------

    {
        type = "bool-setting",
        name = "heli-auto-focus-searchfields",
        setting_type = "runtime-per-user",
        default_value = false,
    },

    {
        type = "double-setting",
        name = "heli-gui-heliSelection-defaultZoom",
        setting_type = "runtime-per-user",
        default_value = 0.3,
        minimum_value = 0.2,
        maximum_value = 1.26,
    },

    {
        type = "double-setting",
        name = "heli-gui-heliPadSelection-defaultZoom",
        setting_type = "runtime-per-user",
        default_value = 0.2,
        minimum_value = 0.025,
        maximum_value = 1.0125,
    },

    {
        type = "bool-setting",
        name = "heli-gaugeGui-show",
        setting_type = "runtime-per-user",
        default_value = true,
    },

    {
        type = "bool-setting",
        name = "heli-gaugeGui-play-fuel-warning-sound",
        setting_type = "runtime-per-user",
        default_value = true,
    },

    {
        type = "bool-setting",
        name = "heli-fuel-alert",
        setting_type = "runtime-per-user",
        default_value = false,
    },

    {
        type = "bool-setting",
        name = "heli-remote-dont-auto-land-player",
        setting_type = "runtime-per-user",
        default_value = true,
    },

    {
        type = "bool-setting",
        name = "heli-remote-dont-land-following-player",
        setting_type = "runtime-per-user",
        default_value = false,
    },
})