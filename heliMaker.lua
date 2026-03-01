--[[
  helicopter - placement entity, has all the stats so it shows in crafting
  heli-entity-_- - actual entity that player is riding

  heli-body-entity-_- - body anim entity
  heli-shadow-entity-_- - shadow anim that is put below
  rotor-entity-_- - rotor anim entity
  rotor-shadow-entity-_- - rotor shadow anim that is being rotated
  (replacable with lua rendering maybe?)

  heli-burner-entity-_- - sole purpose is to emit smoke and sound

  heli-floodlight-entity-_- - entity used for the floodlight (can't we just use a normal light?)

  heli-flying-collision-entity-_- - collision entity when airborne
  heli-landed-collision-end-entity-_- - landed collider front+back (needs distance input)
  heli-landed-collision-side-entity-_- - landed collider sides (needs distance input)
]]

--cars gotta have
--[[
  consumption
  effectivity
  energy_source
  inventory_size
  rotation_speed
  braking_power
  energy_per_hit_point
  friction
  weight
]]

local fuel_slots = 5
local inventory_slots = 80
local gun_slots = {"heli-gun", "heli-rocket-launcher-item", "heli-flamethrower"}
if (mods["Krastorio2"] or mods["Krastorio2-spaced-out"]) and data.raw["ammo-category"]["kr-anti-materiel-rifle-ammo"] then
  -- Override  gun slots for K2
  gun_slots = {"heli-gun", "heli-rocket-launcher-item", "heli-flamethrower", "heli-k2-anti-material-gun"}
end

local heliEntityNames = {
  --"",
  --"heli-entity-_-",
  "heli-body-entity-_-",
  "heli-shadow-entity-_-",

  "rotor-entity-_-",
  "rotor-shadow-entity-_-",
  "heli-burner-entity-_-",

  "heli-floodlight-entity-_-",
  "heli-flying-collision-entity-_-",
  "heli-landed-collision-end-entity-_-",
  "heli-landed-collision-side-entity-_-",
}

function HRHelicopterMaker(args)
  --[[
  args{
    name,
    icon,
    iconSize,
    selBox,
    colBox,
    animation,
    animationShadow,
    animationRotor,
    animationRotorShadow,
    animation,
    animationShadow,
    (light)
    (crash_trigger)
    (vehicle_impact_sound)
    (smoke)
    (smokePositions)
  }
  ]]

  if args.override == nil then
    assert(type(args.name) == "string", "Missing helicopter name!")
    args.name = args.name.."-"
  end
  assert(type(args.animation) == "table", "Missing animation!")
  assert(type(args.animationShadow) == "table", "Missing animation shadow!")
  assert(type(args.animationRotor) == "table", "Missing rotor animation!")
  assert(type(args.animationRotorShadow) == "table", "Missing rotor shadow animation!")
  assert(type(args.icon) == "string", "Missing helicopter icon!")
  assert(type(args.iconSize) == "number", "Missing icon size!")

  assert(type(args.selBox) == "table", "Missing selection box!")
  assert(type(args.colBox) == "table", "Missing collision box!")

  assert(type(args.animation) == "table", "Missing animation!")
  assert(type(args.animationShadow) == "table", "Missing shadow animation!")

  if args.smokePositions ~= nil then
    args.smoke = {}
    for _, pos in pairs(args.smokePositions) do
      table.insert(args.smoke, {
          name = "heli-smoke",
          deviation = {0,0},
          frequency = 200,
          position = pos,
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      )
    end
  end

  data:extend({
    ---------------rotor entity---------------
    {
      type = "car",
      name = args.name.."rotor-entity-_-",
      render_layer = "air-object",
      final_render_layer = "air-object",
      collision_box = {{0,0},{0,0}},
      collision_mask = {layers = {}},
      animation = args.animationRotor,
    },
    ---------------rotor entity shadow---------------
    {
      type = "car",
      name = args.name.."rotor-shadow-entity-_-",
      collision_box = {{0,0},{0,0}},
      collision_mask = {layers = {}},
      animation = args.animationRotorShadow,
    },
    ---------------placement entity---------------
    {
      type = "car",
      name = args.name.."helicopter",
      icon = args.icon,
      icon_size = args.iconSize,
      flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
      has_belt_immunity = true,
      minable = {mining_time = 1, result = args.name.."helicopter"},
      max_health = 2500,
      hidden_in_factoriopedia = true,
      corpse = "medium-remnants",
      dying_explosion = "medium-explosion",
      selection_box = args.selBox,
      collision_box = args.colBox,
      collision_mask = {layers = {object = true, water_tile = true, player = true}},
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
      deliver_category = "vehicle",
      guns = gun_slots,
      rotation_speed = 0.005,
      inventory_size = inventory_slots,
      equipment_grid = "heli-equipment-grid",
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
    ---------------base entity---------------------
    {
      type = "car",
      name = args.name.."heli-entity-_-",
      icon = args.icon,
      icon_size = args.iconSize,
      flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
      render_layer = "air-object",
      final_render_layer = "air-object",
      has_belt_immunity = true,
      minable = {mining_time = 1, result = args.name.."helicopter"},
      max_health = 2500,
      hidden_in_factoriopedia = true,
      factoriopedia_alternative  = args.name,
      corpse = "medium-remnants",
      dying_explosion = "medium-explosion",
      selection_box = args.selBox,
      collision_box = args.colBox,
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
      allow_remote_driving = true,
      trash_inventory_size = 10,
      friction = 0.002,
      terrain_friction_modifier = 0,
      weight = settings.startup["heli-weight"].value,
      is_military_target = true,
      deliver_category = "vehicle",
      rotation_speed = 0.005,
      tank_driving = true,
      inventory_size = inventory_slots,
      equipment_grid = "heli-equipment-grid",
      animation = util.empty_animation(1),
      sound_no_fuel =
      {
        {
          filename = "__base__/sound/fight/tank-no-fuel-1.ogg",
          volume = 0.6
        },
      },
      open_sound = {filename = "__base__/sound/car-door-open.ogg", volume = 0.7 },
      close_sound = {filename = "__base__/sound/car-door-close.ogg", volume = 0.7 },
      mined_sound = data.raw["car"]["tank"].mined_sound,
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
      subgroup = "transport",
      order = "b[personal-transport]-c[heli]",
    },
    ---------------flying collision--------------------
    {
      type = "car",
      name = args.name.."heli-flying-collision-entity-_-",
      collision_box = {{-1.5, -0.2}, {1.5, 0.2}},------------------------------------------------------------
      animation = util.empty_animation(1),
    },
    ---------------landed collision--------------------
    {
      type = "car",
      name = args.name.."heli-landed-collision-side-entity-_-",
      collision_box = {{-0.1, -2.4}, {0.1, 2.4}},------------------------------------------------------------
      animation = util.empty_animation(1),
    },

    {
      type = "car",
      name = args.name.."heli-landed-collision-end-entity-_-",
      collision_box = {{-1.5, -0.1}, {1.5, 0.1}},------------------------------------------------------------
      animation = util.empty_animation(1),
    },
    ---------------body--------------
    {
      type = "car",
      name = args.name.."heli-body-entity-_-",
      render_layer = "air-object",
      final_render_layer = "air-object",
      collision_box = {{0,0},{0,0}},
      collision_mask = {layers = {}},
      animation = args.animation,
    },
    ---------------shadow------------
    {
      type = "car",
      name = args.name.."heli-shadow-entity-_-",
      collision_box = {{0,0},{0,0}},
      collision_mask = {layers = {}},
      animation = args.animationShadow,
    },
  })

  if args.smoke ~= nil then
    data:extend({
      ---------------smoke and sound--------------------
      {
        type = "car",
        name = args.name.."heli-burner-entity-_-",
        collision_box = {{0,0},{0,0}},
        collision_mask = {layers = {}},
        animation = util.empty_animation(1),
        working_sound = args.workingSound,
      },
    })
  end

  if args.light ~= nil then
    data:extend({
      ---------------flashlight--------------------
      {
        type = "car",
        name = args.name.."heli-floodlight-entity-_-",
        collision_box = {{0,0},{0,0}},
        collision_mask = {layers = {}},
        animation = util.empty_animation(1),
        light = args.light,
      },
    })
  end

  for _, name in ipairs(heliEntityNames) do
    data.raw["car"][args.name..name].icon = args.icon
    data.raw["car"][args.name..name].icon_size = args.iconSize
    data.raw["car"][args.name..name].flags = {"placeable-off-grid", "not-on-map"}
    data.raw["car"][args.name..name].max_health = 999999
    data.raw["car"][args.name..name].minable = {mining_time = 1, result = args.name.."helicopter"}
    data.raw["car"][args.name..name].has_belt_immunity = true
    data.raw["car"][args.name..name].hidden_in_factoriopedia = true
    data.raw["car"][args.name..name].selection_box = {{0,0},{0,0}}
    data.raw["car"][args.name..name].energy_per_hit_point = 1
    data.raw["car"][args.name..name].effectivity = 1
    data.raw["car"][args.name..name].energy_source = {type = "void"}
    data.raw["car"][args.name..name].consumption = "1W"
    data.raw["car"][args.name..name].braking_power = "1W"
    data.raw["car"][args.name..name].friction = 1
    data.raw["car"][args.name..name].terrain_friction_modifier = 0
    data.raw["car"][args.name..name].weight = 1
    data.raw["car"][args.name..name].rotation_speed = 1
    data.raw["car"][args.name..name].inventory_size = 0
    data.raw["car"][args.name..name].deliver_category = "vehicle"
    data.raw["car"][args.name..name].crash_trigger = args.crash_trigger
  end

  if args.smoke ~= nil then
    data.raw["car"][args.name.."heli-burner-entity-_-"].energy_source = {
      type = "burner",
      effectivity = 0.01,
      emissions = 0.002,
      fuel_inventory_size = 1,
      smoke = args.smoke,
    }
  end
end
