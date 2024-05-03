require("prototypes.tiles.heli-pad-concrete")

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

-- data.raw["equipment-grid"]["heli-equipment-grid"].equipment_categories = data.raw["equipment-grid"]["kr-car-grid"].equipment_categories
local ir3car = data.raw["car"]["car"]
if ir3car and ir3car.burner then
	local heli_entities = {"heli-placement-entity-_-", "heli-entity-_-", "heli-flying-collision-entity-_-",
	                       "heli-landed-collision-side-entity-_-", "heli-landed-collision-end-entity-_-",
						   "heli-body-entity-_-", "heli-shadow-entity-_-", "heli-burner-entity-_-", "heli-floodlight-entity-_-"}
	for _, heli_entity in ipairs(heli_entities) do
		data.raw["car"][heli_entity].burner.fuel_category = ir3car.burner.fuel_category
		data.raw["car"][heli_entity].burner.fuel_categories = ir3car.burner.fuel_categories
		data.raw["car"][heli_entity].burner.burnt_inventory_size = ir3car.burner.burnt_inventory_size
		-- log(data.raw["heli-burner-entity-_-"])
		-- log(serpent.block(data.raw["car"]["heli-burner-entity-_-"]))
		-- log(serpent.block(data.raw))
		-- log(heli_entity)
		-- data.raw["heli-item"].burner = ir3car.burner.fuel_category
		-- data.raw["heli-item"].burner.fuel_categories = ir3car.burner.fuel_categories
		-- data.raw["heli-item"].burner.burnt_inventory_size = ir3car.burner.burnt_inventory_size
	end
end
