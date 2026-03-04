--Equipment
data:extend({
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	{-- Gunship grid
		type = "equipment-grid",
		name = "heli-equipment-grid",
		width = 8,
		height = 4,
		equipment_categories = {"armor"}
	},
})

local categories = {"armor"}
if mods["Krastorio2"] then
    categories = {}
    table.insert(categories, "kr-vehicle")
    table.insert(categories, "kr-vehicle-motor")
    table.insert(categories, "kr-vehicle-roboport")
end

if mods["space-exploration"] then
    table.insert(categories, "armor")
end

if mods["space-exploration"] and mods["Krastorio2"] then
    table.insert(categories, "reactor-equipment")
    table.insert(categories, "armor-shield")
    table.insert(categories, "armor-weapons")
    table.insert(categories, "belt-immunity")
end

data.raw["equipment-grid"]["heli-equipment-grid"].equipment_categories = categories

--Recipes
data:extend({
	{
		type = "recipe",
        name = "helicopter",
		enabled = false,
		energy_required = 60,
		ingredients = {
			{type = "item", name = "engine-unit", amount = 150},
			{type = "item", name = "steel-plate", amount = 150},
			{type = "item", name = "iron-gear-wheel", amount = 250},
			{type = "item", name = "processing-unit", amount = 250},
			{type = "item", name = "gun-turret", amount = 10},
			{type = "item", name = "rocket-launcher", amount = 10},
		},
		results = {{type = "item", name = "helicopter", amount = 1},},
	},
	{
		type = "recipe",
        name = "scout-helicopter",
		enabled = false,
		energy_required = 60,
		ingredients = {
			{type = "item", name = "iron-plate", amount = 1},
		},
        results = { { type = "item", name = "scout-helicopter", amount = 1 }, },
	},
})

--Technologies
data:extend({
    {
        type = "technology",
        name = "heli-technology",
        icon = "__HelicopterRevival__/graphics/technology/heli-technology.png",
        icon_size = 256,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "helicopter"
            },
            {
                type = "unlock-recipe",
                recipe = "scout-helicopter"
            },
            {
                type = "unlock-recipe",
                recipe = "helicopter-pad"
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
