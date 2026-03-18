data:extend({
    {
      type = "trivial-smoke",
      name = "heli-smoke",
      flags = {"not-on-map"},
      duration = 50,
      fade_in_duration = 20,
      fade_away_duration = 30,
      spread_duration = 30,
      start_scale = 0.1,
      end_scale = 0.3,
      color = {r = 0.1, g = 0.1, b = 0.1, a = 0.1},
      cyclic = true,
      affected_by_wind = true,
      animation =
      {
        width = 152,
        height = 120,
        line_length = 5,
        frame_count = 60,
        axially_symmetrical = false,
        direction_count = 1,
        shift = {0, 0},
        priority = "high",
        animation_speed = 0.25,
        filename = "__base__/graphics/entity/smoke/smoke.png",
        flags = {"smoke"}
      }
    }
})
