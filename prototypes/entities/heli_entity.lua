require("heliMaker")

local fuel_slots = 5
local inventory_slots = 80
local gun_slots = {"heli-gun", "heli-rocket-launcher-item", "heli-flamethrower"}
if (mods["Krastorio2"] or mods["Krastorio2-spaced-out"]) and data.raw["ammo-category"]["kr-anti-materiel-rifle-ammo"] then
  -- Override  gun slots for K2
  gun_slots = {"heli-gun", "heli-rocket-launcher-item", "heli-flamethrower", "heli-k2-anti-material-gun"}
end

local args = {
  override = true,
  bobbing = true,
  name = "",
  icon = "__HelicopterRevival__/graphics/icons/heli.png",
  iconSize = 64,
  selBox = {{-1.2, -2.4}, {1.2, 2.4}},
  colBox = {{-1.2, -2.4}, {1.2, 2.4}},
  animation = {
    layers = {
      {
        priority = "high",
        width = 720,
        height = 600,
        frame_count = 1,
        direction_count = 64,
        shift = {0.265625, -5},
        scale = 0.5,
        animation_speed = 8,
        max_advance = 0.2,
        stripes =
        {
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/body-0.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/body-1.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/body-2.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/body-3.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
        }
      },
    }
  },
  animationShadow = {
    layers = {
      {
        priority = "very-low",
        width = 720,
        height = 600,
        frame_count = 1,
        draw_as_shadow = true,
        direction_count = 64,
        shift = {0.4, -0.5},
        scale = 0.5,
        animation_speed = 8,
        max_advance = 0.2,
        stripes =
        {
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/body_shadow-0.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/body_shadow-1.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/body_shadow-2.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/body_shadow-3.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
        },
      },
    },
  },
  animationRotor = {
    layers = {
      {
        priority = "high",
        width = 720,
        height = 600,
        frame_count = 1,
        direction_count = 64,
        shift = {0.265625, -5.1},
        scale = 0.5,
        animation_speed = 8,
        max_advance = 0.2,
        stripes =
        {
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/rotor-0.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/rotor-1.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/rotor-2.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/rotor-3.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
        },
      },
    },
  },
  animationRotorShadow = {
    layers = {
      {
        priority = "very-low",
        width = 720,
        height = 600,
        frame_count = 1,
        draw_as_shadow = true,
        direction_count = 64,
        shift = {0.665625, -1},
        scale = 0.5,
        animation_speed = 8,
        max_advance = 0.2,
        stripes =
        {
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/rotor_shadow-0.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/rotor_shadow-1.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/rotor_shadow-2.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli/rotor_shadow-3.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
        },
      },
    }
  },
  light = {
    {
      type = "oriented",
      minimum_darkness = 0.3,
      picture =
      {
        filename = "__core__/graphics/light-cone.png",
        priority = "extra-high",
        flags = {"light"},
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
      deviation = {0,0},
      frequency = 200,
      position = {-0.725, 0},
      starting_frame = 0,
      starting_frame_deviation = 60
    },
    {
      name = "heli-smoke",
      deviation = {0,0},
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
          width = 720,
          height = 600,
          frame_count = 1,
          direction_count = 1,
          shift = {0.265625, 0},
          animation_speed = 8,
          max_advance = 0.2,
          scale = 0.5,
          stripes =
          {
            {
              filename = "__HelicopterRevival__/graphics/entities/heli/body-0.png",
              width_in_frames = 1,
              height_in_frames = 1,
            },
          }
        },
        {
          priority = "high",
          width = 720,
          height = 600,
          frame_count = 1,
          direction_count = 1,
          shift = {0.265625, 0},
          animation_speed = 8,
          max_advance = 0.2,
          scale = 0.5,
          stripes =
          {
            {
              filename = "__HelicopterRevival__/graphics/entities/heli/rotor-0.png",
              width_in_frames = 1,
              height_in_frames = 1,
            },
          }
        },
      }
    },
  },
}

HRHelicopterMaker(args)
