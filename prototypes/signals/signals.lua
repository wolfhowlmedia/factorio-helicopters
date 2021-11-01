data:extend(
{
	{
		type = "virtual-signal",
		name = "signal-heli-fuel-warning",
		icon = "__HelicopterRevival__/graphics/icons/fuel_warning.png",
		icon_size = 64,
		subgroup = "virtual-signal-number",
		order = "e[warnings]-[1]"
	},

	{
		type = "virtual-signal",
		name = "signal-heli-fuel-warning-critical",
		icon = "__core__/graphics/icons/alerts/fuel-icon-red.png",
		icon_size = 64,
		subgroup = "virtual-signal-number",
		order = "e[warnings]-[2]"
	},
})