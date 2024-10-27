require("prototypes.tiles.heli-pad-concrete")
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

