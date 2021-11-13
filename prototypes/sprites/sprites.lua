data:extend({
  {
    type = "sprite",
    name = "heli_to_player",
    filename = "__HelicopterRevival__/graphics/icons/to_player.png",
    priority = "medium",
    width = 64,
    height = 64,
    flags = {"icon"},
  },

  {
    type = "sprite",
    name = "heli_to_map",
    filename = "__HelicopterRevival__/graphics/icons/map.png",
    priority = "medium",
    width = 64,
    height = 64,
    flags = {"icon"},
  },

  {
    type = "sprite",
    name = "heli_to_pad",
    filename = "__HelicopterRevival__/graphics/icons/to_pad.png",
    priority = "medium",
    width = 64,
    height = 64,
    flags = {"icon"},
  },

  {
    type = "sprite",
    name = "heli_stop",
    filename = "__HelicopterRevival__/graphics/icons/stop.png",
    priority = "medium",
    width = 64,
    height = 64,
    flags = {"icon"},
  },

  {
    type = "sprite",
    name = "heli_gui_selected",
    filename = "__HelicopterRevival__/graphics/gui/selected.png",
    priority = "medium",
    width = 210,
    height = 210,
    flags = {"icon"},
  },

  {
    type = "sprite",
    name = "heli_search_icon",
    filename = "__HelicopterRevival__/graphics/gui/search-icon.png",
    priority = "medium",
    width = 15,
    height = 15,
    shift = {-17, 1},
    flags = {"icon"},
  },

  {
    type = "sprite",
    name = "heli_void_128",
    filename = "__HelicopterRevival__/graphics/gui/gauges/void_128.png",
    priority = "medium",
    width = 128,
    height = 128,
  },

  {
    type = "sprite",
    name = "heli_gauge_fs",
    filename = "__HelicopterRevival__/graphics/gui/gauges/gauge_fs.png",
    width = 128,
    height = 128,
    priority = "extra-high-no-scale",
  },

  {
    type = "sprite",
    name = "heli_gauge_fs_led_fuel",
    filename = "__HelicopterRevival__/graphics/gui/gauges/gauge_fs_led_fuel.png",
    width = 128,
    height = 128,
    priority = "extra-high-no-scale",
  },

  {
    type = "sprite",
    name = "heli_gauge_hr",
    filename = "__HelicopterRevival__/graphics/gui/gauges/gauge_hr.png",
    width = 128,
    height = 128,
    priority = "extra-high-no-scale",
  },
})

gauge_pointers = {}

for i = 0, 127 do
	table.insert(gauge_pointers, {
		type = "sprite",
    name = "heli_gauge_pointer_" .. tostring(i),
    filename = "__HelicopterRevival__/graphics/gui/gauges/pointers/pointer-" .. tostring(i) .. ".png",
    priority = "medium",
    width = 128,
    height = 128,
	})
end

data:extend(gauge_pointers)