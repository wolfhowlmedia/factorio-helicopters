data:extend({
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
		results = {{type = "item", name = "heli-pad-item", amount = 1},},
	},
})