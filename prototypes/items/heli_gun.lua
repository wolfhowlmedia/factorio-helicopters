data:extend({
    {
        type = "gun",
        name = "heli-gun",
        icon = "__base__/graphics/icons/submachine-gun.png",
        icon_size = 64,
        flags = {"hidden"},
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
    }
})
