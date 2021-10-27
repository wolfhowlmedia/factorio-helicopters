data:extend({
    {
        type = "gun",
        name = "heli-flamethrower",
        icon = "__base__/graphics/icons/flamethrower.png",
        icon_size = 64,
        flags = {"hidden"},
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
    }
})