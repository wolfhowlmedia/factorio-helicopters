data:extend({
	{
		type = "item-with-entity-data",
		name = "helicopter",
		icon = "__HelicopterRevival__/graphics/icons/heli.png",
		icon_size = 64,
		flags = {},
		subgroup = "transport",
		order = "b[personal-transport]-c[heli]",
		place_result = "helicopter",
        inventory_move_sound = data.raw["item-with-entity-data"]["car"].inventory_move_sound,
        pick_sound = data.raw["item-with-entity-data"]["car"].pick_sound,
        drop_sound = data.raw["item-with-entity-data"]["car"].drop_sound,
		stack_size = 1,
        weight = 1000000,
	},
    {
        type = "gun",
        name = "heli-gun",
        icon = "__base__/graphics/icons/submachine-gun.png",
        icon_size = 64,
        flags = {},
        hidden = true,
        subgroup = "gun",
        order = "a[basic-clips]-b[tank-machine-gun]-c[flamethrower-ammo]",
        attack_parameters =
        {
            type = "projectile",
            ammo_category = "bullet",
            cooldown = 4,
            damage_modifier = settings.startup["heli-gun-damage-modifier"].value,
            movement_slow_down_factor = 0.7,
            shell_particle =
            {
                name = "shell-particle",
                direction_deviation = 0.1,
                speed = 0.1,
                speed_deviation = 0.03,
                center = {0, 0},
                creation_distance = -0.6875,
                starting_frame_speed = 0.4,
                starting_frame_speed_deviation = 0.1
            },
            projectile_center = {-0.15625, -0.07812},
            projectile_creation_distance = 1,
            range = settings.startup["heli-gun-range"].value,
            sound =
            {
                {
                    filename = "__base__/sound/fight/tank-cannon.ogg",
                    volume = 0.45
                }
            },
        },
        stack_size = 1
    },
    {
        type = "gun",
        name = "heli-flamethrower",
        icon = "__base__/graphics/icons/flamethrower.png",
        icon_size = 64,
        flags = {},
        hidden = true,
        subgroup = "gun",
        order = "a[basic-clips]-b[tank-machine-gun]-c[flamethrower-ammo]",
        attack_parameters =
        {
            type = "stream",
            ammo_category = "flamethrower",
            cooldown = 1,
            movement_slow_down_factor = 0.4,
            damage_modifier = settings.startup["heli-flamethrower-damage-modifier"].value,
            gun_barrel_length = 0.8,
            gun_center_shift = { 0, -1 },
            range = settings.startup["heli-flamethrower-range"].value,
            min_range = 3,
            cyclic_sound =
            {
                begin_sound =
                {
                    {
                        filename = "__base__/sound/fight/flamethrower-start.ogg",
                        volume = 0.7
                    }
                },
                middle_sound =
                {
                    {
                        filename = "__base__/sound/fight/flamethrower-mid.ogg",
                        volume = 0.7
                    }
                },
                end_sound =
                {
                    {
                        filename = "__base__/sound/fight/flamethrower-end.ogg",
                        volume = 0.7
                    }
                }
            }
        },
        stack_size = 1
    },
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

    {
        type = "item",
        name = "helicopter-remote-equipment",
        icon = "__HelicopterRevival__/graphics/icons/heli-remote-icon.png",
        icon_size = 64,
        place_as_equipment_result = "helicopter-remote-equipment",
        flags = {},
        subgroup = "equipment",
        order = "g[heli-remote]-a[heli-remote-item]",
        inventory_move_sound = data.raw["item"]["night-vision-equipment"].inventory_move_sound,
        pick_sound = data.raw["item"]["night-vision-equipment"].pick_sound,
        drop_sound = data.raw["item"]["night-vision-equipment"].drop_sound,
        stack_size = 1,
        default_request_amount = 1,
    },
    {
        type = "item",
        name = "helicopter-pad",
        icon = "__HelicopterRevival__/graphics/icons/heli_pad.png",
        icon_size = 64,
        flags = {},
        subgroup = "transport",
        order = "b[personal-transport]-d[helicopter-pad]",
        inventory_move_sound = data.raw["item"]["stone-wall"].inventory_move_sound,
        pick_sound = data.raw["item"]["stone-wall"].pick_sound,
        drop_sound = data.raw["item"]["stone-wall"].drop_sound,
        place_result = "helicopter-pad",
        stack_size = 10
    },
})
if (mods["Krastorio2"] or mods["Krastorio2-spaced-out"]) and data.raw["ammo-category"]["kr-anti-materiel-rifle-ammo"] then
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
                ammo_category = "kr-anti-materiel-rifle-ammo",
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
end
