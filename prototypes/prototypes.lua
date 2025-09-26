require("util")

--Equipment
data:extend({
	{
		type = "battery-equipment",
		name = "heli-remote-equipment",
		sprite =
		{
			filename = "__HelicopterRevival__/graphics/equipment/heli-remote-equipment.png",
			width = 128,
			height = 128,
			priority = "medium",
			scale = 0.5,
		},
		shape =
		{
			width = 2,
			height = 2,
			type = "full"
		},
		energy_source =
		{
			type = "electric",
			buffer_capacity = "2MJ",
			input_flow_limit = "1MW",
			output_flow_limit = "1MW",
			usage_priority = "tertiary"
		},
		categories = {"armor"}
	},
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	{ -- Gunship grid
		type = "equipment-grid",
		name = "heli-equipment-grid",
		width = 8,
		height = 4,
		equipment_categories = {"armor"}
	},
})

--Font
data:extend({
  {
    type = "font",
    name = "pixelated",
    from = "pixelated",
    size = 12
  },
})

--Recipes
data:extend({
	{
		type = "recipe",
		name = "heli-recipe",
		enabled = false,
		ingredients = {
			{type = "item", name = "engine-unit", amount = 150},
			{type = "item", name = "steel-plate", amount = 150},
			{type = "item", name = "iron-gear-wheel", amount = 250},
			{type = "item", name = "processing-unit", amount = 250},
			{type = "item", name = "gun-turret", amount = 10},
			{type = "item", name = "rocket-launcher", amount = 10},
		},
		results = {{type = "item", name = "heli-item", amount = 1},},
	},
	{
		type = "recipe",
		name = "heli-remote-recipe",
		enabled = false,
		energy_required = 15,
		ingredients = {
			{type = "item", name = "processing-unit", amount = 125},
			{type = "item", name = "battery", amount = 20},
			{type = "item", name = "plastic-bar", amount = 40},
			{type = "item", name = "iron-stick", amount = 20},
		},
		results = {{type = "item", name = "heli-remote-equipment", amount = 1},}
	},
	{
		type = "recipe",
		name = "heli-pad-recipe",
		enabled = false,
		energy_required = 5,
		ingredients = {
			{type = "item", name = "refined-concrete", amount = 50},
		},
		results = {{type = "item", name = "heli-pad-item", amount = 1}},
	},
})

--Signals
data:extend({
	{
		type = "virtual-signal",
		name = "signal-heli-fuel-warning",
		icon = "__HelicopterRevival__/graphics/icons/fuel_warning.png",
		icon_size = 64,
		subgroup = "virtual-signal-number",
		order = "e[warnings]-[1]"
	},{
		type = "virtual-signal",
		name = "signal-heli-fuel-warning-critical",
		icon = "__core__/graphics/icons/alerts/fuel-icon-red.png",
		icon_size = 64,
		subgroup = "virtual-signal-number",
		order = "e[warnings]-[2]"
	},
})

--Sounds
data:extend({
	{
		type = "sound",
		name = "heli-fuel-warning",
		filename = "__HelicopterRevival__/sound/fuel_warning.ogg",
		volume = 0.5,
	},
})

--Technologies
data:extend({
    {
        type = "technology",
        name = "heli-remote-technology",
        icon = "__HelicopterRevival__/graphics/technology/heli-remote-technology.png",
        icon_size = 256,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "heli-remote-recipe"
            },
        },
        prerequisites = {"heli-technology", "concrete", "processing-unit", "battery", "modular-armor"},
        unit =
        {
            count = 450,
            ingredients =
            {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"utility-science-pack", 1},
            },
            time = 45
        },
        order = "e-d"
    },

    {
        type = "technology",
        name = "heli-technology",
        icon = "__HelicopterRevival__/graphics/technology/heli-technology.png",
        icon_size = 256,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "heli-recipe"
            },
            {
                type = "unlock-recipe",
                recipe = "heli-pad-recipe"
            },
        },
        prerequisites = {"automobilism", "processing-unit", "gun-turret", "rocketry"},
        unit =
        {
            count = 400,
            ingredients =
            {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 2},
            },
            time = 30
        },
        order = "e-d"
    },
})

--Sprites
data:extend({
    {
        type = "sprite",
        name = "heli_to_player",
        filename = "__HelicopterRevival__/graphics/icons/to_player.png",
        priority = "medium",
        width = 64,
        height = 64,
        flags = {"icon"},
    },
    {
        type = "sprite",
        name = "heli_to_map",
        filename = "__HelicopterRevival__/graphics/icons/map.png",
        priority = "medium",
        width = 64,
        height = 64,
        flags = {"icon"},
    },
    {
        type = "sprite",
        name = "heli_to_pad",
        filename = "__HelicopterRevival__/graphics/icons/to_pad.png",
        priority = "medium",
        width = 64,
        height = 64,
        flags = {"icon"},
    },
    {
        type = "sprite",
        name = "heli_stop",
        filename = "__HelicopterRevival__/graphics/icons/stop.png",
        priority = "medium",
        width = 64,
        height = 64,
        flags = {"icon"},
    },
    {
        type = "sprite",
        name = "heli_gui_selected",
        filename = "__HelicopterRevival__/graphics/gui/selected.png",
        priority = "medium",
        width = 210,
        height = 210,
        flags = {"icon"},
    },
    {
        type = "sprite",
        name = "heli_search_icon",
        filename = "__HelicopterRevival__/graphics/gui/search-icon.png",
        priority = "medium",
        width = 15,
        height = 15,
        shift = {-17, 1},
        flags = {"icon"},
    },
    {
        type = "sprite",
        name = "heli_void_128",
        filename = "__HelicopterRevival__/graphics/gui/gauges/void_128.png",
        priority = "medium",
        width = 128,
        height = 128,
    },
    {
        type = "sprite",
        name = "heli_gauge_fs",
        filename = "__HelicopterRevival__/graphics/gui/gauges/gauge_fs.png",
        width = 128,
        height = 128,
        priority = "extra-high-no-scale",
    },
    {
        type = "sprite",
        name = "heli_gauge_fs_led_fuel",
        filename = "__HelicopterRevival__/graphics/gui/gauges/gauge_fs_led_fuel.png",
        width = 128,
        height = 128,
        priority = "extra-high-no-scale",
    },
    {
        type = "sprite",
        name = "heli_gauge_hr",
        filename = "__HelicopterRevival__/graphics/gui/gauges/gauge_hr.png",
        width = 128,
        height = 128,
        priority = "extra-high-no-scale",
    },
})

gauge_pointers = {}
for i = 0, 127 do
	table.insert(gauge_pointers, {
		type = "sprite",
		name = "heli_gauge_pointer_" .. tostring(i),
		filename = "__HelicopterRevival__/graphics/gui/gauges/pointers/pointer-" .. tostring(i) .. ".png",
		priority = "medium",
		width = 128,
		height = 128,
	})
end
data:extend(gauge_pointers)
