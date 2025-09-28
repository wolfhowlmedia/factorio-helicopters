--[[data.raw["gui-style"].default["heli-listbox_button"] =
{
  type = "button_style",
  parent = "button",
  font = "default-bold",
  align = "left",
  scalable = true,

        --maximal_height = 33,
        minimal_height = 33,
        --maximal_width = 33,
        minimal_width = 33,

  left_click_sound =
  {
    {
      filename = "__core__/sound/list-box-click.ogg",
      volume = 1
    }
  },

  default_font_color={r=1, g=1, b=1},
  default_graphical_set =
  {
    type = "composition",
    filename = "__HelicopterRevival__/graphics/gui/black.png",
    priority = "extra-high-no-scale",
    position = {0, 0}
  },

  hovered_font_color={r=1, g=1, b=1},
  hovered_graphical_set =
  {
    type = "composition",
    filename = "__HelicopterRevival__/graphics/gui/grey.png",
    priority = "extra-high-no-scale",
    corner_size = {0, 0},
    position = {0, 0}
  },

  clicked_font_color = {r=0, g=0, b=0},
  clicked_graphical_set =
  {
    type = "composition",
    filename = "__HelicopterRevival__/graphics/gui/orange.png",
    priority = "extra-high-no-scale",
    corner_size = {0, 0},
    position = {0, 0}
  },
}
--]]
data.raw["gui-style"].default["heli-listbox_button"] =
    {
        type = "button_style",
        parent = "button",
        font = "default-bold",
        --maximal_height = 33,
        minimal_height = 33,
        --maximal_width = 33,
        minimal_width = 33,
        --top_padding = 0,
        --bottom_padding = 0,
        --right_padding = 0,
        --left_padding = 0,
        left_click_sound = {
            {
                filename = "__core__/sound/gui-click.ogg",
                volume = 1
            }
        },
        right_click_sound = {
            {
                filename = "__core__/sound/gui-click.ogg",
                volume = 1
            }
        }
    }

function makeButtonStyle(width, height, image, padding)
  padding = padding or {}

  return {
    type = "button_style",
    parent = "button",
    scalable = true,

    width = width,
    height = height,

    top_padding = padding.top or 0,
    right_padding = padding.right or 0,
    bottom_padding = padding.bottom or 0,
    left_padding = padding.left or 0,

    default_graphical_set =
    {
      filename = image,
      priority = "extra-high-no-scale",
      width = width,
      height = height,
    },

    hovered_graphical_set =
    {
      filename = image,
      priority = "extra-high-no-scale",
      width = width,
      height = height,
      x = width,
    },

    clicked_graphical_set =
    {
      filename = image,
      priority = "extra-high-no-scale",
      width = width,
      height = height,
      x = width * 2,
    },
  }
end

data.raw["gui-style"].default["heli-clear_text_button"] = makeButtonStyle(15, 15, "__HelicopterRevival__/graphics/gui/clear-text.png", {top = 4})
data.raw["gui-style"].default["heli-speaker_on_button"] = makeButtonStyle(24, 24, "__HelicopterRevival__/graphics/gui/speaker_on_hr.png")
data.raw["gui-style"].default["heli-speaker_off_button"] = makeButtonStyle(24, 24, "__HelicopterRevival__/graphics/gui/speaker_off_hr.png")
