require("heliMaker")

local args = {
  override = true,
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
        shift = {0.665625, -0.5},
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
}

HRHelicopterMaker(args)
