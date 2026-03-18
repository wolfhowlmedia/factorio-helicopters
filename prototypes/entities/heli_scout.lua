require("heliMaker")

function by_pixel(t)
  return {t[1]/64,t[2]/64}
end

local fuel_slots = 5
local inventory_slots = 20
local gun_slots = {"heli-gun-scout"}

---------------------------
--Width, Height, Count
local dim = {
	chassis = {5632, 5632, 8},
	chassisLight = {5632, 5632, 8},
	chassisShadow = {6144, 6144, 8},

	gun = {5632, 5632, 8},
	gunShadow = {6144, 6144, 8},

	rotor = {5632, 5632, 8},
	rotorShadow = {6144, 6144, 8},
}

for _, v in pairs(dim) do
  v[1] = v[1] / v[3]
  v[2] = v[2] / v[3]
end


local offset = {}

offset.chassis = {0, -3.5}
offset.chassisLight = {0, -3.5}
offset.chassisShadow = {1, 1.5}

offset.gun = {0, 1.5}
offset.gunShadow = {1.5, 1.5}

offset.rotor = {0, -3.6}
offset.rotorShadow = {0.5, 1.5}

for _, v in pairs(offset) do
  v[2] = v[2] -1
  v = by_pixel(v)
end

---------------------------

local args = {
  name = "scout",
  bobbing = false,
  icon = "__HelicopterRevival__/graphics/icons/heli-scout.png",
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
            filename = "__HelicopterRevival__/graphics/entities/heli_scout/scout.png",
            width_in_frames = 8,
            height_in_frames = 8,
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
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/scout_shadow.png",
        width_in_frames = 8,
        height_in_frames = 8,
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
            filename = "__HelicopterRevival__/graphics/entities/heli_scout/scout_tower.png",
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
            filename = "__HelicopterRevival__/graphics/entities/heli_scout/scout_tower_shadow.png",
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
    counterclockwise = true,
    stripes =
    {
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/scout_rotor.png",
        width_in_frames = 8,
        height_in_frames = 8,
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
    counterclockwise = true,
    stripes =
    {
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/scout_rotor_shadow.png",
        width_in_frames = 8,
        height_in_frames = 8,
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
  crashTrigger = {
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
  smokePositions = {pos = {{0, 0.35}}, height = 0.55},
  entityProperties = {
    max_health = 750,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    energy_per_hit_point = 3,
    rotation_speed = 0.0075,
    turret_rotation_speed = 1 / 120,
    trash_inventory_size = 10,
    inventory_size = inventory_slots,
    weight = settings.startup["heli-weight"].value / 2,

    allow_remote_driving = true,
    is_military_target = true,
    has_belt_immunity = true,
    tank_driving = true,
    guns = gun_slots,

    deliver_category = "vehicle",
    subgroup = "transport",
    order = "b[personal-transport]-c[heli]",

    effectivity = 0.5,
    consumption = "1000kW",
    braking_power = "500kW",
    friction = 0.002,
    terrain_friction_modifier = 0,
    energy_source = {
      type = "burner",
      effectivity = 0.75,
      emissions = 0.005,
      fuel_inventory_size = 2,
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
              filename = "__HelicopterRevival__/graphics/entities/heli_scout/scout.png",
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
              filename = "__HelicopterRevival__/graphics/entities/heli_scout/scout_rotor.png",
              width_in_frames = 1,
              height_in_frames = 1,
            },
          },
        },
      }
    },
    darkness_to_render_light_animation = -100,
    light_animation = {
      layers = {
        {
          priority = "high",
          width = dim.chassisLight[1],
          height = dim.chassisLight[2],
          frame_count = 1,
          direction_count = 64,
          shift = offset.chassisLight,
          animation_speed = 1,
          blend_mode = "additive",
          draw_as_glow = true,
          max_advance = 1,
          scale = 0.5,
          stripes =
          {
            {
              filename = "__HelicopterRevival__/graphics/entities/heli_scout/scout_light.png",
              width_in_frames = 8,
              height_in_frames = 8,
            },
          },
        },
      }
    },
  }
}

HRHelicopterMaker(args)
