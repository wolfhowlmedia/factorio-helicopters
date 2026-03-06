require("prototypes.prototypes")
require("prototypes.items")

require("prototypes.entities.heli_pad")
require("prototypes.entities.smoke")
require("prototypes.input")
require("prototypes.style")

if settings.startup["heli-disabler"].value == false then
    require("prototypes.entities.heli_entity")
    require("prototypes.entities.heli_scout")
    require("prototypes.prototypesHelis")
    require("prototypes.itemsHelis")
else
    table.insert(data.raw["technology"]["heli-remote-technology"].prerequisites, "heli-technology-pad")
    table.insert(data.raw["technology"]["heli-remote-technology"].prerequisites, "processing-unit")
end

if mods["alien-biomes"] and alien_biomes_priority_tiles then
    table.insert(alien_biomes_priority_tiles, "heli-pad-entity")
end
