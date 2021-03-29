require("prototypes.tiles.heli-pad-concrete")

if mods["Krastorio2"] then
	-- copy K2 eqipment categories into heli-equipment-grid
	data.raw["equipment-grid"]["heli-equipment-grid"].equipment_categories = data.raw["equipment-grid"]["kr-car-grid"].equipment_categories
end