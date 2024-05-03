if not mods["Krastorio2"] or not data.raw["ammo-category"]["anti-material-rifle-ammo"] then
    return
end

local anti_material_rifle_shot_sound = {
	variations = {
	  {
		filename = "__Krastorio2Assets__/sounds/weapons/advanced-tank-anti-material-rifle-1.ogg",
		volume = 0.35,
	  },
	  {
		filename = "__Krastorio2Assets__/sounds/weapons/advanced-tank-anti-material-rifle-2.ogg",
		volume = 0.35,
	  },
	},
	aggregation = {
	  max_count = 2,
	  remove = false,
	  count_already_playing = true,
	},
  }

data:extend({
	{
	type = "gun",
	name = "heli-k2-anti-material-gun",
	icon = "__HelicopterRevival__/graphics/icons/anti-material-rifle.png",
	icon_size = 64,
	flags = {},
	subgroup = "gun",
	order = "d[heli-k2-anti-material-gun]",
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
		sound = anti_material_rifle_shot_sound
	},
	stack_size = 1
	},
})