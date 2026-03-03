local transferralEntityName = "hr-heli-names"

local function addTransferralEntity(name)
  data:extend{
    {
      type = "entity-ghost",
      name = transferralEntityName,
      icon = "__core__/graphics/empty.png",
      icon_size = 1,
      stack_size = 1,
      flags = {"not-on-map", "hide-alt-info", "not-blueprintable", "not-flammable"},
      localised_name = "BIGDATA",
      localised_description = serpent.dump(name),
      hidden_in_factoriopedia = true,
      order = "z",
    }
  }
end

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


cars gotta have

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
local function checkArgs(args, req, opt)
    for field, expected_type in pairs(req) do
      if args[field] == nil then
        error("Required field '"..field.."' is missing!", 2)
      end

      if type(args[field]) ~= expected_type then
        error("Field '"..field.."' has to be of type '"..expected_type.."'", 2)
      end
    end

    for field, expected_type in pairs(opt) do
      if args[field] ~= nil then
        if type(args[field]) ~= expected_type then
          error("Field '"..field.."' has to be of type '"..expected_type.."'", 2)
        end
      end
    end
end

local requiredFields = {
  animation = "table",
  animationShadow = "table",
  animationRotor = "table",
  animationRotorShadow = "table",
  icon = "string",
  iconSize = "number",
  selBox = "table",
  colBox = "table",
  entityProperties = "table",
}
local optionalFields = {
  animationTurret = "table",
  animationTurretShadow = "table",
  smoke = "table",
  smokePositions = "table",
}
local requiredFieldsEntity = {
  max_health = "number",
  energy_per_hit_point = "number",
  rotation_speed = "number",
  turret_rotation_speed = "number",
  inventory_size = "number",
  weight = "number",
  effectivity = "number",
  consumption = "string",
  braking_power = "string",
  friction = "number",
  energy_source = "table",
  animation = "table",
}

---@param args table
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
      animationTurret,
      animationTurretShadow,
        (light)
        (crash_trigger)
        (vehicle_impact_sound)
        (smoke)
        (smokePositions)
    entityProperties
  }
  ]]

  if args.override == nil then
    checkArgs(args, {name = "string"}, {})
    args.name = args.name.."-"
  end
  checkArgs(args, requiredFields, optionalFields)
  checkArgs(args.entityProperties, requiredFieldsEntity, {})

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

  local blueprintPlacement = {type = "car",}
  for property, value in pairs(args.entityProperties) do
    blueprintPlacement[property] = value
  end

  blueprintPlacement.icon = args.icon
  blueprintPlacement.icon_size = args.iconSize
  blueprintPlacement.selection_box = args.selBox
  blueprintPlacement.collision_box = args.colBox
  blueprintPlacement.minable = {mining_time = 1, result = args.name.."helicopter"}
  blueprintPlacement.hidden_in_factoriopedia = true

  local blueprintBase = table.deepcopy(blueprintPlacement)
  blueprintPlacement.name = args.name.."helicopter"
  blueprintPlacement.collision_mask = {layers = {object = true, water_tile = true, player = true}}
  blueprintPlacement.alert_icon_shift = nil

  blueprintBase.name = args.name.."heli-entity-_-"
  blueprintBase.collision_mask = {layers={}}
  blueprintBase.render_layer = "air-object"
  blueprintBase.final_render_layer = "air-object"
  blueprintBase.factoriopedia_alternative  = args.name.."helicopter"
  blueprintBase.animation = util.empty_animation(1)
  blueprintBase.turret_animation = args.animationTurret

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
    blueprintPlacement,
    ---------------base entity---------------------
    blueprintBase,
    ---------------flying collision--------------------
    {
      type = "car",
      name = args.name.."heli-flying-collision-entity-_-",
      collision_box = {{args.colBox[1][1]-0.3, -0.2}, {args.colBox[2][1]+0.3, 0.2}},
      animation = util.empty_animation(1),
    },
    ---------------landed collision--------------------
    {
      type = "car",
      name = args.name.."heli-landed-collision-side-entity-_-",
      collision_box = {{-0.1, args.colBox[1][2]}, {0.1, args.colBox[2][2]}},
      animation = util.empty_animation(1),
    },
    {
      type = "car",
      name = args.name.."heli-landed-collision-end-entity-_-",
      collision_box = {{args.colBox[1][1]-0.3, -0.1}, {args.colBox[2][1]+0.3, 0.1}},
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
      turret_animation = args.animationTurretShadow,
    },
  })

  ---------------smoke and sound--------------------
  if args.smoke ~= nil then
    data:extend({
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

  ---------------flashlight--------------------
  if args.light ~= nil then
    data:extend({
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

  if data.raw["entity-ghost"][transferralEntityName] == nil then
    addTransferralEntity({args.name})
  else
    local _, datas = serpent.load(data.raw["entity-ghost"][transferralEntityName].localised_description)
    if datas ~= nil then
      table.insert(datas, args.name)
    else
      datas = {}
    end
    addTransferralEntity(datas)
  end
end
