data:extend({
  {
    type = "simple-entity-with-force",
    name = "helicopter-pad",
    flags = {"placeable-neutral", "player-creation"},
    icon = "__HelicopterRevival__/graphics/icons/heli_pad.png",
    icon_size = 64,
    subgroup = "grass",
    order = "b[decorative]-k[stone-rock]-a[big]",
    collision_box = {{-3.5, -3.5}, {3.5, 3.5}},
    collision_mask = {layers = {object=true, water_tile=true}},
    selection_box = {{-3.5, -3.5}, {3.5, 3.5}},
    minable =
    {
      mining_time = 2,
      result = "helicopter-pad",
      count = 1
    },

    count_as_rock_for_filtered_deconstruction = false,
    mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg"},
    render_layer = "object",
    max_health = 200,
    resistances =
    {
      {
        type = "fire",
        percent = 100
      },
      {
        type = "physical",
        percent = 100
      },
      {
        type = "impact",
        percent = 100
      },
      {
        type = "explosion",
        percent = 90
      },
      {
        type = "acid",
        percent = 100
      }
    },

    pictures =
    {
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_pad.png",
        width = 520,
        height = 520,
        scale = 0.5,
      },
    }
  },

  {
    type = "simple-entity-with-force",
    name = "heli-pad-entity",
    flags = {"placeable-neutral", "player-creation"},
    icon = "__HelicopterRevival__/graphics/icons/heli_pad.png",
    icon_size = 64,
    subgroup = "grass",
    order = "b[decorative]-k[stone-rock]-a[big]",
    collision_box = {{-3.5, -3.5}, {3.5, 3.5}},
    collision_mask = {layers = {}},--{"object-layer"},
    selection_box = {{-2, -2}, {2, 2}},
    is_military_target = false,
    hidden_in_factoriopedia = true,
    factoriopedia_alternative = "helicopter-pad",
    minable =
    {
      mining_time = 2,
      result = "helicopter-pad",
      count = 1
    },

    count_as_rock_for_filtered_deconstruction = false,
    mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg"},
    render_layer = "decorative",
    max_health = 200,
    resistances =
    {
      {
        type = "fire",
        percent = 100
      },
            {
        type = "physical",
        percent = 100
      },
      {
        type = "impact",
        percent = 100
      },
      {
        type = "explosion",
        percent = 90
      },
      {
        type = "acid",
        percent = 100
      }
    },

    pictures =
    {
      {
        filename = "__HelicopterRevival__/graphics/entities/heli_pad_inner.png",
        width = 173,
        height = 172,
      },
    }
  },
})
