data:extend({
	{
	type = "gun",
	name = "heli-rocket-launcher-item",
	icon = "__HelicopterRevival__/graphics/icons/rocket_pod.png",
	icon_size = 64,
	flags = {},
	subgroup = "gun",
	order = "d[rocket-launcher]",
	attack_parameters =
	{
		type = "projectile",
		ammo_category = "rocket",
		movement_slow_down_factor = 1.2,
		cooldown = 20,
		damage_modifier = settings.startup["heli-rocket-damage-modifier"].value,
		projectile_creation_distance = 0.6,
		range = settings.startup["heli-rocket-launcher-range"].value,
		projectile_center = {-0.17, 0},
		sound =
		{
			{
				filename = "__base__/sound/fight/rocket-launcher.ogg",
				volume = 0.7
			}
		}
	},
	stack_size = 50
	},
})