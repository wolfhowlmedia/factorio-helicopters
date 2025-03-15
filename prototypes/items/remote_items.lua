data:extend({
    {
        type = "item",
        name = "heli-remote-equipment",
        icon = "__HelicopterRevival__/graphics/icons/heli-remote-icon.png",
        icon_size = 64,
        place_as_equipment_result = "heli-remote-equipment", -- Updated to match Factorio 2.0 API
        flags = {},
        subgroup = "equipment",
        order = "g[heli-remote]-a[heli-remote-item]",
        stack_size = 1,
        default_request_amount = 1,
    },
    {
        type = "item",
        name = "heli-pad-item",
        icon = "__HelicopterRevival__/graphics/icons/heli_pad.png",
        icon_size = 64,
        flags = {},
        subgroup = "transport",
        order = "b[personal-transport]-d[heli-pad-item]",
        place_result = "heli-pad-placement-entity",
        stack_size = 10
    },
})
