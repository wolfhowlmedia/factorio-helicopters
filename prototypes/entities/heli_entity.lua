local fuel_slots = 5
local inventory_slots = 80

gun_slots = {"heli-gun", "heli-rocket-launcher-item", "heli-flamethrower"}

if mods["Krastorio2"] and data.raw["ammo-category"]["anti-material-rifle-ammo"] then
  -- Override  gun slots for K2
  gun_slots = {"heli-gun", "heli-rocket-launcher-item", "heli-flamethrower", "heli-k2-anti-material-gun"}
end

data:extend({
  {
    type = "car",
    name = "heli-placement-entity-_-",
    icon = "__HelicopterRevival__/graphics/icons/heli.png",
    icon_size = 64,
    flags = {"placeable-off-grid", "player-creation"},
		-- render_layer = "air-object",
		-- final_render_layer = "air-object",
    has_belt_immunity = true,
    minable = {mining_time = 1, result = "heli-item"},
    max_health = 2500,
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    selection_box = {{-1.5, -1.8}, {0.9, 3}},
    collision_box = {{-1.5, -1.8}, {0.9, 3}},
    collision_mask = {layers = {object=true, water_tile=true, player=true}},
    energy_per_hit_point = 1,
    effectivity = 0.3,
    energy_source = {
      type = "burner",
      consumption = "3MW",
      braking_power = "1MW",
      effectivity = 0.5,
      emissions = 0,
      fuel_inventory_size = 0,
    },
    consumption = "3MW",
    braking_power = "1MW",
    friction = 0.002,
    terrain_friction_modifier = 0,
    weight = 3000,

    rotation_speed = 0.005,
    inventory_size = 0,
    equipment_grid = nil,

    animation = {
      layers = {
        {
          priority = "high",
          width = 360,
          height = 300,
          frame_count = 1,
          direction_count = 1,
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
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
          width = 360,
          height = 300,
          frame_count = 1,
          direction_count = 1,
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
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

  ---------------------base entity---------------------
  {
    type = "car",
    name = "heli-entity-_-",
    icon = "__HelicopterRevival__/graphics/icons/heli.png",
    icon_size = 64,
    flags = {"placeable-off-grid", "player-creation"},
		render_layer = "air-object",
		final_render_layer = "air-object",
    has_belt_immunity = true,
    minable = {mining_time = 1, result = "heli-item"},
    max_health = 2500,
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    selection_box = {{-1.8, -1.8}, {1.2, 3}},
    collision_box = {{-1.8, -1.8}, {1.2, 3}},
    alert_icon_shift = {-0.25, -0.5},
    collision_mask = {layers={}},
    energy_per_hit_point = 1,
    effectivity = 0.4,
    energy_source = {
      type = "burner",
      effectivity = 0.5,
      emissions = 0.005,
      fuel_inventory_size = fuel_slots,
    },
    consumption = settings.startup["heli-consumption"].value,
    braking_power = settings.startup["heli-braking-power"].value,
    friction = 0.002,
    terrain_friction_modifier = 0,
    weight = settings.startup["heli-weight"].value,

    rotation_speed = 0.005,
    tank_driving = true,
    inventory_size = inventory_slots,
    -- equipment_grid = "heli-equipment-grid",

    animation = {
      layers = {
        {
          priority = "high",
          width = 1,
          height = 1,
          frame_count = 1,
          direction_count = 64,
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
          stripes =
          {
            {
              filename = "__HelicopterRevival__/graphics/void.png",
              width_in_frames = 8,
              height_in_frames = 8,
            },
          }
        },
      }
    },
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/tank-no-fuel-1.ogg",
        volume = 0.6
      },
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume = 0.7 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.7 },
    guns = gun_slots,
    turret_rotation_speed = 1 / 60,
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
  },





----------------------flying collision--------------------
  {
    type = "car",
    name = "heli-flying-collision-entity-_-",
    icon = "__HelicopterRevival__/graphics/icons/heli.png",
    icon_size = 64,
    flags = {"placeable-off-grid", "not-on-map"},
		render_layer = "air-object",
		final_render_layer = "air-object",
    minable = {mining_time = 1, result = "heli-item"},
    has_belt_immunity = true,
    max_health = 999999,
    corpse = "medium-remnants",
    selection_box = {{0,0},{0,0}},
    collision_box = {{-1.8, -0.2}, {1.2, 0.2}},
    energy_per_hit_point = 1,
    effectivity = 0.3,
    energy_source = {
      type = "burner",
      effectivity = 0.5,
      emissions = 0,
      fuel_inventory_size = 1,
    },
    consumption = "1W",
    braking_power = "1W",
    friction = 0.002,
    terrain_friction_modifier = 0,
    weight = 3000,

    rotation_speed = 0.005,
    inventory_size = 0,

    animation = {
      layers = {
        {
          priority = "high",
          width = 1,
          height = 1,
          frame_count = 1,
          direction_count = 1,
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
          stripes =
          {
            {
              filename = "__HelicopterRevival__/graphics/void.png",
              width_in_frames = 1,
              height_in_frames = 1,
            },
          }
        },
      }
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
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  },


----------------------landed collision--------------------
  {
    type = "car",
    name = "heli-landed-collision-side-entity-_-",
    icon = "__HelicopterRevival__/graphics/icons/heli.png",
    icon_size = 64,
    flags = {"placeable-off-grid", "not-on-map"},
		-- render_layer = "air-object",
		-- final_render_layer = "air-object",
    minable = {mining_time = 1, result = "heli-item"},
    has_belt_immunity = true,
    max_health = 999999,
    corpse = "medium-remnants",
    selection_box = {{0,0},{0,0}},
    collision_box = {{-0.1, -2.4}, {0.1, 2.4}}, --{{-0.1, -1.8}, {0.1, 3}},
    energy_per_hit_point = 1,
    effectivity = 0.3,
    energy_source = {
      type = "burner",
      effectivity = 0.5,
      emissions = 0,
      fuel_inventory_size = 1,
    },
    consumption = "1W",
    braking_power = "1W",
    friction = 0.002,
    terrain_friction_modifier = 0,
    weight = 3000,

    rotation_speed = 0.005,
    inventory_size = 0,

    animation = {
      layers = {
        {
          priority = "high",
          width = 1,
          height = 1,
          frame_count = 1,
          direction_count = 1,
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
          stripes =
          {
            {
              filename = "__HelicopterRevival__/graphics/void.png",
              width_in_frames = 1,
              height_in_frames = 1,
            },
          }
        },
      }
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
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  },

  {
    type = "car",
    name = "heli-landed-collision-end-entity-_-",
    icon = "__HelicopterRevival__/graphics/icons/heli.png",
    icon_size = 64,
    flags = {"placeable-off-grid", "not-on-map"},
		-- render_layer = "air-object",
		-- final_render_layer = "air-object",
    has_belt_immunity = true,
    minable = {mining_time = 1, result = "heli-item"},
    max_health = 999999,
    corpse = "medium-remnants",
    selection_box = {{0,0},{0,0}},
    collision_box = {{-1.5, -0.1}, {1.5, 0.1}}, --{{-1.8, -0.1}, {1.2, 0.1}} --{{-1.8, -1.8}, {1.2, 3}}
    energy_per_hit_point = 1,
    effectivity = 0.3,
    energy_source = {
      type = "burner",
      effectivity = 0.5,
      emissions = 0,
      fuel_inventory_size = 1,
    },
    consumption = "1W",
    braking_power = "1W",
    friction = 0.002,
    terrain_friction_modifier = 0,
    weight = 3000,

    rotation_speed = 0.005,
    inventory_size = 0,

    animation = {
      layers = {
        {
          priority = "high",
          width = 1,
          height = 1,
          frame_count = 1,
          direction_count = 1,
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
          stripes =
          {
            {
              filename = "__HelicopterRevival__/graphics/void.png",
              width_in_frames = 1,
              height_in_frames = 1,
            },
          }
        },
      }
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
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  },











  ---------------body--------------
  {
    type = "car",
    name = "heli-body-entity-_-",
    icon = "__HelicopterRevival__/graphics/icons/heli.png",
    icon_size = 64,
    flags = {"placeable-off-grid", "not-on-map"},
		render_layer = "air-object",
		final_render_layer = "air-object",
    minable = {mining_time = 1, result = "heli-item"},
    has_belt_immunity = true,
    max_health = 1500,
    corpse = "medium-remnants",
    selection_box = {{0,0},{0,0}},
    collision_box = {{0,0},{0,0}},
    collision_mask = {layers = {}},
    energy_per_hit_point = 1,
    effectivity = 0.5,
    braking_power = "100kW",
    energy_source = {
      type = "burner",
      effectivity = 1,
      emissions = 0,
      fuel_inventory_size = 1,
    },
    consumption = "100kW",
    friction = 0.01,

    animation = {
      layers = {
        {
          priority = "high",
          width = 360,
          height = 300,
          frame_count = 1,
          direction_count = 64,
          shift = {0, -5},
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
          },
          hr_version = {
            priority = "high",
            width = 720,
            height = 600,
            frame_count = 1,
            direction_count = 64,
            shift = {0, -5},
            scale = 0.5,
            animation_speed = 8,
            max_advance = 0.2,
            stripes =
            {
              {
                filename = "__HelicopterRevival__/graphics/entities/heli/hr-body-0.png",
                width_in_frames = 4,
                height_in_frames = 4,
              },
              {
                filename = "__HelicopterRevival__/graphics/entities/heli/hr-body-1.png",
                width_in_frames = 4,
                height_in_frames = 4,
              },
              {
                filename = "__HelicopterRevival__/graphics/entities/heli/hr-body-2.png",
                width_in_frames = 4,
                height_in_frames = 4,
              },
              {
                filename = "__HelicopterRevival__/graphics/entities/heli/hr-body-3.png",
                width_in_frames = 4,
                height_in_frames = 4,
              },
            }
          }
        },
      }
    },
    inventory_size = 0,
    rotation_speed = 0.005,
    weight = 50,
  },








  ---------------shadow------------
  {
    type = "car",
    name = "heli-shadow-entity-_-",
    icon = "__HelicopterRevival__/graphics/icons/heli.png",
    icon_size = 64,
    flags = {"placeable-off-grid", "not-on-map"},
		-- render_layer = "air-object",
		-- final_render_layer = "air-object",
    minable = {mining_time = 1, result = "heli-item"},
    has_belt_immunity = true,
    max_health = 1500,
    corpse = "medium-remnants",
    selection_box = {{0,0},{0,0}},
    collision_box = {{0,0},{0,0}},
    collision_mask = {layers={}},
    energy_per_hit_point = 1,
    effectivity = 0.5,
    braking_power = "100kW",
    energy_source = {
      type = "burner",
      effectivity = 1,
      emissions = 0,
      fuel_inventory_size = 1,
    },
    consumption = "100kW",
    friction = 0.01,

    animation = {
      layers = {
        {
          priority = "very-low",
          width = 360,
          height = 300,
          frame_count = 1,
          draw_as_shadow = true,
          direction_count = 64,
          shift = {0.4, -0.5},
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
          hr_version = {
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
                filename = "__HelicopterRevival__/graphics/entities/heli/hr-body_shadow-0.png",
                width_in_frames = 4,
                height_in_frames = 4,
              },
              {
                filename = "__HelicopterRevival__/graphics/entities/heli/hr-body_shadow-1.png",
                width_in_frames = 4,
                height_in_frames = 4,
              },
              {
                filename = "__HelicopterRevival__/graphics/entities/heli/hr-body_shadow-2.png",
                width_in_frames = 4,
                height_in_frames = 4,
              },
              {
                filename = "__HelicopterRevival__/graphics/entities/heli/hr-body_shadow-3.png",
                width_in_frames = 4,
                height_in_frames = 4,
              },
            },
          }
        },
      }
    },
    inventory_size = 0,
    rotation_speed = 0.005,
    weight = 50,
  },








----------------------smoke and sound--------------------
  {
    type = "car",
    name = "heli-burner-entity-_-",
    icon = "__HelicopterRevival__/graphics/icons/heli.png",
    icon_size = 64,
    flags = {"placeable-off-grid", "not-on-map"},
		render_layer = "air-object",
		final_render_layer = "air-object",
    minable = {mining_time = 1, result = "heli-item"},
    has_belt_immunity = true,
    max_health = 999999,
    corpse = "medium-remnants",
    selection_box = {{0,0},{0,0}},
    collision_box = {{0,0},{0,0}},
    collision_mask = {layers = {}},
    energy_per_hit_point = 1,
    effectivity = 0.01,
    energy_source = {
      type = "burner",
      effectivity = 0.01,
      emissions = 0.002,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "heli-smoke",
          deviation = {0,0},
          frequency = 200,
          position = {-1, 0},
          starting_frame = 0,
          starting_frame_deviation = 60
        },
        {
          name = "heli-smoke",
          deviation = {0,0},
          frequency = 200,
          position = {0.45, 0},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = "1W",
    braking_power = "1W",
    friction = 1,
    terrain_friction_modifier = 0,
    weight = 9999,

    rotation_speed = 0.005,
    inventory_size = 0,

    animation = {
      layers = {
        {
          priority = "high",
          width = 1,
          height = 1,
          frame_count = 1,
          direction_count = 1,
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
          stripes =
          {
            {
              filename = "__HelicopterRevival__/graphics/void.png",
              width_in_frames = 1,
              height_in_frames = 1,
            },
          }
        },
      }
    },

    working_sound = {
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
  },






----------------------flashlight--------------------
  {
    type = "car",
    name = "heli-floodlight-entity-_-",
    icon = "__HelicopterRevival__/graphics/icons/heli.png",
    icon_size = 64,
    flags = {"placeable-off-grid", "not-on-map"},
    minable = {mining_time = 1, result = "heli-item"},
    has_belt_immunity = true,
    max_health = 999999,
    corpse = "medium-remnants",
    selection_box = {{0,0},{0,0}},
    collision_box = {{0,0},{0,0}},
    collision_mask = {layers = {}},
    energy_per_hit_point = 1,
    effectivity = 0.3,
    energy_source = {
      type = "burner",
      effectivity = 0.5,
      emissions = 0,
      fuel_inventory_size = 1,
    },
    consumption = "1W",
    braking_power = "1W",
    friction = 0.002,
    terrain_friction_modifier = 0,
    weight = 3000,

    rotation_speed = 0.005,
    inventory_size = 0,

    animation = {
      layers = {
        {
          priority = "high",
          width = 1,
          height = 1,
          frame_count = 1,
          direction_count = 1,
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
          stripes =
          {
            {
              filename = "__HelicopterRevival__/graphics/void.png",
              width_in_frames = 1,
              height_in_frames = 1,
            },
          }
        },
      }
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
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

    light =
    {
      {
      type = "oriented",
      minimum_darkness = 0.3,
      picture =
      {
        filename = "__core__/graphics/light-cone.png",
        priority = "extra-high",
        flags = { "light" },
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
  },
})
