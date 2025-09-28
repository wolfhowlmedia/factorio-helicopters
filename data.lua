require("prototypes.entities.heli_entity")
require("prototypes.entities.rotor_entity")
require("prototypes.entities.smoke")
require("prototypes.entities.heli_pad")

require("prototypes.prototypes")
require("prototypes.items")
require("prototypes.input")
require("prototypes.style")

if mods["alien-biomes"] and alien_biomes_priority_tiles then
    table.insert(alien_biomes_priority_tiles, "heli-pad-entity")
end
