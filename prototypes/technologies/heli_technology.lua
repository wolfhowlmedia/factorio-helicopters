data:extend({
  {
    type = "technology",
    name = "heli-technology",
    icon = "__HelicopterRevival__/graphics/technology/heli-technology.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "heli-recipe"
      },
    },
    prerequisites = {"automobilism", "advanced-electronics-2", "gun-turret", "rocketry"},
    unit =
    {
      count = 400,
      ingredients =
      {
						{"automation-science-pack", 1},
						{"logistic-science-pack", 1},
						{"chemical-science-pack", 2},
      },
      time = 30
    },
    order = "e-d"
  },
})