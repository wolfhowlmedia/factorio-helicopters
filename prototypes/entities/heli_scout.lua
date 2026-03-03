require("heliMaker")

local math3d = require("math3d")

function by_pixel(t)
  return {t[1]/32,t[2]/32}
end

local fuel_slots = 5
local inventory_slots = 80
local gun_slots = {"heli-gun", "heli-rocket-launcher-item", "heli-flamethrower"}

---------------------------
local dim =
{
	chassis = {300,240},
	chassisShadow = {290,178},

	gun = {100,76},
	gunShadow = {90,60},

	rotor = {202,140},
	rotorShadow = {198,120},
}

local dimHr = {}
for k,v in pairs(dim) do
	dimHr[k] = math3d.vector2.mul(v, 2)
end
dim.hr = dimHr
dim.hr.rotor = {402,279}

---------------------------

local off = {chassis = {0,0}}
off.chassisShadow = math3d.vector2.add(off.chassis, {36.5,33})

off.gun = math3d.vector2.add(off.chassis, {0.5,25.5})
off.gunShadow = math3d.vector2.add(off.gun, {6,8})

off.rotor = math3d.vector2.add(off.chassis, {0,-11})
off.rotorShadow = math3d.vector2.add(off.rotor, {53,39.5})

offHr = {}
for k,v in pairs(off) do
	offHr[k] = by_pixel(v)
	off[k] = by_pixel(v)
end
off.hr = offHr


off.chassis[2] = off.chassis[2] - 5
off.rotor[2] = off.rotor[2] - 5.1
off.rotorShadow[2] = off.rotorShadow[2] - 0.1

off.hr.chassis[2] = off.hr.chassis[2] - 5
off.hr.rotor[2] = off.hr.rotor[2] - 5.1
off.hr.rotorShadow[2] = off.hr.rotorShadow[2] - 0.1
---------------------------

local args = {
  type = "car",
  name = "scout",
  icon = "__HelicopterRevival__/graphics/icons/heli.png",
  iconSize = 64,
  selBox = { { -1.5, -1.8 }, { 0.9, 3 } },
  colBox = { { -1.5, -1.8 }, { 0.9, 3 } },
  icon_size = 64,
  animation = {
    layers = {
      {
        priority = "high",
        width = dim.hr.chassis[1],
        height = dim.hr.chassis[2],
        frame_count = 1,
        direction_count = 64,
        shift = off.hr.chassis,
        animation_speed = 8,
        max_advance = 0.2,
        scale = 0.5,
        stripes =
        {
          {
            filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/Chassis_Hi-0.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/Chassis_Hi-1.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/Chassis_Hi-2.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
          {
            filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/Chassis_Hi-3.png",
            width_in_frames = 4,
            height_in_frames = 4,
          },
        },
      },
    }
  },
  animationShadow = {
    priority = "very-low",
    width = dim.hr.chassisShadow[1],
    height = dim.hr.chassisShadow[2],
    frame_count = 1,
    draw_as_shadow = true,
    direction_count = 64,
    shift = off.hr.chassisShadow,
    animation_speed = 8,
    max_advance = 0.2,
    stripes =
    {
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/ChassisShadow_Hi-0.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/ChassisShadow_Hi-1.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/ChassisShadow_Hi-2.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/ChassisShadow_Hi-3.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
    },
    scale = 0.5,
  },
  animationRotor = {
    priority = "high",
    width = dim.hr.rotor[1],
    height = dim.hr.rotor[2],
    frame_count = 1,
    direction_count = 64,
    shift = off.hr.rotor,
    animation_speed = 8,
    max_advance = 0.2,
    stripes =
    {
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/Rotor_Hi-0.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/Rotor_Hi-1.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/Rotor_Hi-2.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/Rotor_Hi-3.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
    },
    scale = 0.5,
  },
  animationRotorShadow = {
    priority = "very-low",
    width = dim.hr.rotorShadow[1],
    height = dim.hr.rotorShadow[2],
    frame_count = 1,
    draw_as_shadow = true,
    direction_count = 64,
    shift = off.hr.rotorShadow,
    animation_speed = 8,
    max_advance = 0.2,
    stripes =
    {
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/RotorShadow_Hi-0.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/RotorShadow_Hi-1.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/RotorShadow_Hi-2.png",
        width_in_frames = 4,
        height_in_frames = 4,
      },
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/RotorShadow_Hi-3.png",
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
      deviation = { 0, 0 },
      frequency = 200,
      position = { -0.725, 0 },
      starting_frame = 0,
      starting_frame_deviation = 60
    },
    {
      name = "heli-smoke",
      deviation = { 0, 0 },
      frequency = 200,
      position = { 0.725, 0 },
      starting_frame = 0,
      starting_frame_deviation = 60
    }
  },
  entityProperties = {
    max_health = 2500,
    flags = { "placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable" },
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

    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume = 0.7 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.7 },
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
      flags = { "icon" },
      size = { 40, 40 },
      scale = 0.5
    },
    selected_minimap_representation = {
      filename = "__HelicopterRevival__/graphics/icons/heli-minimap-representation-selected.png",
      flags = { "icon" },
      size = { 40, 40 },
      scale = 0.5
    },
    animation = {
      layers = {
        {
          priority = "high",
          width = dim.hr.chassis[1],
          height = dim.hr.chassis[2],
          frame_count = 1,
          direction_count = 1,
          shift = {off.hr.chassis[1], off.hr.chassis[2] + 5},
          animation_speed = 8,
          max_advance = 0.2,
          stripes =
          {
            {
              filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/Chassis_Hi-0.png",
              width_in_frames = 1,
              height_in_frames = 1,
            },
          },
          scale = 0.5,
        },
        {
						priority = "high",
						width = dim.hr.rotor[1],
						height = dim.hr.rotor[2],
						frame_count = 1,
						direction_count = 1,
						shift = {off.hr.rotor[1], off.hr.rotor[2] + 5.1},
						animation_speed = 8,
						max_advance = 0.2,
						stripes =
						{
							{
								filename = "__HelicopterRevival__/graphics/entities/heli_scout/hr/Rotor_Hi-0.png",
								width_in_frames = 1,
								height_in_frames = 1,
							},
						},
						scale = 0.5,
        },
      }
    },
  }
}

log(serpent.dump(args))

HRHelicopterMaker(args)
