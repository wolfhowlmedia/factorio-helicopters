if not mods["Krastorio2"] then
    return
end

data:extend({
	{
	type = "gun",
	name = "heli-k2-anti-material-gun",
	icon = "__HelicopterRevival__/graphics/icons/anti-material-rifle.png",
	icon_size = 64,
	flags = {},
	subgroup = "gun",
	order = "d[rocket-launcher]",
	attack_parameters =
	{
		type = "projectile",
		ammo_category = "anti-material-rifle-ammo",
		movement_slow_down_factor = 1.2,
		cooldown = 20,
		damage_modifier = settings.startup["heli-k2-anti-material-gun-damage-modifier"].value,
		projectile_creation_distance = 0.6,
		range = settings.startup["heli-k2-anti-material-gun-range"].value,
		projectile_center = {-0.17, 0},
		sound =
		{
			{
				filename = "__base__/sound/fight/artillery-shoots-1.ogg",
				volume = 0.5
			}
		}
	},
	stack_size = 50
	},
})