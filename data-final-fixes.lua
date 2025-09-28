--Heli Pad Concrete
local heliConcrete = table.deepcopy(data.raw.tile["refined-concrete"])
heliConcrete.name = "heli-pad-concrete"
heliConcrete.minable = {hardness = 0.2, mining_time = 0.5}
heliConcrete.decorative_removal_probability = 1

data:extend({heliConcrete})

if mods["Krastorio2"] then
	for _, car in pairs(data.raw.car) do
		if car.energy_source and car.energy_source.type == "burner" then
			car.energy_source.fuel_categories = { "kr-vehicle-fuel" }
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

