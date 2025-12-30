local tile_graphics = require("__base__/prototypes/tile/tile-graphics")
local tile_sounds = require("__space-age__/prototypes/tile/tile-sounds")

--Heli Pad Concrete
local heliConcrete = table.deepcopy(data.raw.tile["refined-concrete"])
heliConcrete.name = "heli-pad-concrete"
heliConcrete.minable = {hardness = 0.2, mining_time = 0.5}
heliConcrete.decorative_removal_probability = 1
heliConcrete.hidden = true
data:extend({heliConcrete})

if mods["Krastorio2"] or mods["Krastorio2-spaced-out"] then
	for _, car in pairs(data.raw.car) do
		if car.energy_source and car.energy_source.type == "burner" then
			car.energy_source.fuel_categories = {"kr-vehicle-fuel"}
		end
	end
end

--[[
if mods["Krastorio2"] then
	-- copy K2 eqipment categories into heli-equipment-grid
	data.raw["equipment-grid"]["heli-equipment-grid"].equipment_categories = data.raw["equipment-grid"]["kr-car-grid"].equipment_categories
end

if mods["VehicleGrid"] then
	if mods["bobvehicleequipment"] then
		-- copy Bob's equipment categories into heli-equipment-grid
		data.raw["equipment-grid"]["heli-equipment-grid"].equipment_categories = data.raw["equipment-grid"]["bob-car"].equipment_categories
	end
end

-- VTK armor
if mods["vtk-armor-plating"] then
	table.insert(data.raw["equipment-grid"]["heli-equipment-grid"].equipment_categories, "vtk-armor-plating")
end
]]


local function frozen_concrete(base_name, item_name, transition_merge_tile)
  local frozen_name = "frozen-" .. base_name
  local base_prototype = data.raw.tile[base_name]
  base_prototype.frozen_variant = frozen_name
  local frozen_concrete = table.deepcopy(base_prototype)
  frozen_concrete.order = "z[frozen-concrete]-" .. frozen_name
  frozen_concrete.subgroup = "aquilo-tiles"
  frozen_concrete.name = frozen_name
  frozen_concrete.can_be_part_of_blueprint = true
  frozen_concrete.placeable_by = {item = item_name, count = 1}
  frozen_concrete.layer = base_prototype.layer + 1
  frozen_concrete.sprite_usage_surface = "aquilo"
  frozen_concrete.variants =
  {
    material_background =
    {
      picture = "__space-age__/graphics/terrain/aquilo/frozen-refined-concrete.png",
      count = 8,
      scale = 0.5
    },
    transition = tile_graphics.generic_texture_on_concrete_transition
  }
  frozen_concrete.transition_merges_with_tile = transition_merge_tile
  frozen_concrete.transitions = nil
  frozen_concrete.transitions_between_transitions = nil
  frozen_concrete.thawed_variant = base_name
  frozen_concrete.frozen_variant = nil
  frozen_concrete.walking_sound = tile_sounds.walking.frozen_concrete
  data:extend({ frozen_concrete })
end

frozen_concrete("heli-pad-concrete", "refined-concrete", "refined-concrete")