require("heliMaker")

function by_pixel(t)
  return {t[1]/64,t[2]/64}
end

local fuel_slots = 5
local inventory_slots = 80
local gun_slots = {"heli-gun", "heli-rocket-launcher-item", "heli-flamethrower"}

---------------------------
--Width, Height, Count
local dim = {
	chassis = {2400, 1920, 4},
	chassisShadow = {2320, 1424, 4},

	gun = {1600, 1216, 8},
	gunShadow = {1440, 960, 8},

	rotor = {1608, 1116, 4},
	rotorShadow = {1584, 960, 4},
}

for _, v in pairs(dim) do
  v[1] = v[1] / v[3]
  v[2] = v[2] / v[3]
end


local offset = {}

offset.chassis = {0, -4.5}
offset.chassisShadow = {1.25, 1.5}

offset.gun = {0, 1}
offset.gunShadow = {1, 1}

offset.rotor = {0, -5.1}
offset.rotorShadow = {0.75, 1.5}

for _, v in pairs(offset) do
  v[2] = v[2] -1
  v = by_pixel(v)
end

---------------------------

local args = {
  name = "scout",
  icon = "__HelicopterRevival__/graphics/icons/heli.png",
  iconSize = 64,
  selBox = {{-0.75, -1.75}, {0.75, 1.75}},
  colBox = {{-0.75, -1.75}, {0.75, 1.75}},
  icon_size = 64,
  animation = {
    layers = {
      {
        priority = "high",
        width = dim.chassis[1],
        height = dim.chassis[2],
        frame_count = 1,
        direction_count = 64,
        shift = offset.chassis,
        animation_speed = 1,
        max_advance = 1,
        scale = 0.5,
        stripes =
        {
          {
            filename = "__HelicopterRevival__/graphics/entities/heli_scout/Chassis_Hi-0.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli_scout/Chassis_Hi-1.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli_scout/Chassis_Hi-2.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli_scout/Chassis_Hi-3.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
        },
      },
    }
  },
  animationShadow = {
    priority = "high",
    width = dim.chassisShadow[1],
    height = dim.chassisShadow[2],
    frame_count = 1,
    draw_as_shadow = true,
    direction_count = 64,
    shift = offset.chassisShadow,
    animation_speed = 1,
    max_advance = 1,
    stripes =
    {
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/ChassisShadow_Hi-0.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/ChassisShadow_Hi-1.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/ChassisShadow_Hi-2.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/ChassisShadow_Hi-3.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
    },
    scale = 0.5,
  },
  animationTurret = {
    layers = {
      {
        priority = "high",
        width = dim.gun[1],
        height = dim.gun[2],
        frame_count = 1,
        direction_count = 64,
        shift = {offset.gun[1], offset.gun[2]},
        animation_speed = 1,
        max_advance = 1,
        scale = 0.5,
        stripes =
        {
          {
            filename = "__HelicopterRevival__/graphics/entities/heli_scout/Gun_Hi.png",
            width_in_frames = 8,
            height_in_frames = 8,
          },
        },
      },
    }
  },
  animationTurretShadow = {
    layers = {
      {
        priority = "high",
        width = dim.gunShadow[1],
        height = dim.gunShadow[2],
        frame_count = 1,
        direction_count = 64,
        shift = {offset.gunShadow[1], offset.gunShadow[2]},
        animation_speed = 1,
        max_advance = 1,
        scale = 0.5,
        draw_as_shadow = true,
        stripes =
        {
          {
            filename = "__HelicopterRevival__/graphics/entities/heli_scout/GunShadow_Hi.png",
          width_in_frames = 8,
          height_in_frames = 8,
          },
        },
      },
    }
  },
  animationRotor = {
    priority = "high",
    width = dim.rotor[1],
    height = dim.rotor[2],
    frame_count = 1,
    direction_count = 64,
    shift = offset.rotor,
    animation_speed = 1,
    max_advance = 1,
    stripes =
    {
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/Rotor_Hi-0.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/Rotor_Hi-1.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/Rotor_Hi-2.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/Rotor_Hi-3.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
    },
    scale = 0.5,
  },
  animationRotorShadow = {
    priority = "high",
    width = dim.rotorShadow[1],
    height = dim.rotorShadow[2],
    frame_count = 1,
    draw_as_shadow = true,
    direction_count = 64,
    shift = offset.rotorShadow,
    animation_speed = 1,
    max_advance = 1,
    stripes =
    {
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/RotorShadow_Hi-0.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/RotorShadow_Hi-1.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/RotorShadow_Hi-2.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/RotorShadow_Hi-3.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
    },
    scale = 0.5,
  },
  light = {
    {
    type = "oriented",
    minimum_darkness = 0.3,
    picture =
    {
      filename = "__core__/graphics/light-cone.png",
      priority = "extra-high",
      flags = {"light" },
      scale = 2.5,
      width = 200,
      height = 200
    },
    shift = {-0.3, -20},
    size = 2.5,
    intensity = 0.6,
    color = {r = 0.92, g = 0.77, b = 0.3}
    },
  },
  crash_trigger = {
    type = "play-sound",
    sound =
    {
      {
      filename = "__base__/sound/car-crash.ogg",
      volume = 0.25
      },
    }
  },
  workingSound = {
    sound = {
      filename = "__HelicopterRevival__/sound/heli_loop.ogg",
      volume = 0.6
    },
    activate_sound = {
      filename = "__HelicopterRevival__/sound/heli_startup.ogg",
      volume = 0.6
    },
    deactivate_sound = {
      filename = "__HelicopterRevival__/sound/heli_shutdown.ogg",
      volume = 0.6
    },
    --match_speed_to_activity = true,
  },
  smoke = {
    {
      name = "heli-smoke",
      deviation = {0, 0},
      frequency = 200,
      position = {-0.725, 0},
      starting_frame = 0,
      starting_frame_deviation = 60
    },
    {
      name = "heli-smoke",
      deviation = {0, 0},
      frequency = 200,
      position = {0.725, 0},
      starting_frame = 0,
      starting_frame_deviation = 60
    }
  },
  entityProperties = {
    max_health = 2500,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    energy_per_hit_point = 1,
    rotation_speed = 0.005,
    turret_rotation_speed = 1 / 60,
    trash_inventory_size = 10,
    inventory_size = inventory_slots,
    weight = settings.startup["heli-weight"].value,

    allow_remote_driving = true,
    is_military_target = true,
    has_belt_immunity = true,
    tank_driving = true,
    guns = gun_slots,

    deliver_category = "vehicle",
    equipment_grid = "heli-equipment-grid",
    subgroup = "transport",
    order = "b[personal-transport]-c[heli]",

    effectivity = 0.4,
    consumption = settings.startup["heli-consumption"].value,
    braking_power = settings.startup["heli-braking-power"].value,
    friction = 0.002,
    terrain_friction_modifier = 0,
    energy_source = {
      type = "burner",
      effectivity = 0.5,
      emissions = 0.005,
      fuel_inventory_size = fuel_slots,
    },

    open_sound = {filename = "__base__/sound/car-door-open.ogg", volume = 0.7},
    close_sound = {filename = "__base__/sound/car-door-close.ogg", volume = 0.7},
    mined_sound = data.raw["car"]["tank"].mined_sound,
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/tank-no-fuel-1.ogg",
        volume = 0.6
      },
    },

    minimap_representation = {
      filename = "__HelicopterRevival__/graphics/icons/heli-minimap-representation.png",
      flags = {"icon"},
      size = {40, 40},
      scale = 0.5
    },
    selected_minimap_representation = {
      filename = "__HelicopterRevival__/graphics/icons/heli-minimap-representation-selected.png",
      flags = {"icon"},
      size = {40, 40},
      scale = 0.5
    },
    animation = {
      layers = {
        {
          priority = "high",
          width = dim.chassis[1],
          height = dim.chassis[2],
          frame_count = 1,
          direction_count = 1,
          shift = {offset.chassis[1], offset.chassis[2] + 5},
          animation_speed = 1,
          max_advance = 1,
          scale = 0.5,
          stripes =
          {
            {
              filename = "__HelicopterRevival__/graphics/entities/heli_scout/Chassis_Hi-0.png",
              width_in_frames = 1,
              height_in_frames = 1,
            },
          },
        },
        {
          priority = "high",
          width = dim.rotor[1],
          height = dim.rotor[2],
          frame_count = 1,
          direction_count = 1,
          shift = {offset.rotor[1], offset.rotor[2] + 5.1},
          animation_speed = 1,
          max_advance = 1,
          scale = 0.5,
          stripes =
          {
            {
              filename = "__HelicopterRevival__/graphics/entities/heli_scout/Rotor_Hi-0.png",
              width_in_frames = 1,
              height_in_frames = 1,
            },
          },
        },
      }
    },
  }
}

log(serpent.dump(args))

HRHelicopterMaker(args)
