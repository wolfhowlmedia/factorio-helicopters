data:extend({
  {
    type = "technology",
    name = "heli-remote-technology",
    icon = "__HelicopterRevival__/graphics/technology/heli-remote-technology.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "heli-remote-recipe"
      },
      {
        type = "unlock-recipe",
        recipe = "heli-pad-recipe"
      },
    },
    prerequisites = {"heli-technology", "concrete", "processing-unit", "battery", "modular-armor"},
    unit =
    {
      count = 450,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 45
    },
    order = "e-d"
  },
})