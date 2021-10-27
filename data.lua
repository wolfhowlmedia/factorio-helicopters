require("prototypes.entities.heli_entity")
require("prototypes.entities.rotor_entity")
require("prototypes.entities.smoke")
require("prototypes.entities.heli_pad")

require("prototypes.items.heli_item")
require("prototypes.items.heli_rocket_launcher_item")
require("prototypes.items.remote_items")
require("prototypes.items.heli_gun")
require("prototypes.items.heli_flamethrower")
require("prototypes.items.heli_k2_anti_material_gun")

require("prototypes.recipes.heli_recipe")
require("prototypes.recipes.remote_recipes")

require("prototypes.technologies.heli_technology")
require("prototypes.technologies.remote_technology")
require("prototypes.equipment.equipment")

require("prototypes.sounds.sounds")
require("prototypes.sprites.sprites")
require("prototypes.font.font")
require("prototypes.style.style")
require("prototypes.signals.signals")

require("input.input")

if alien_biomes_priority_tiles then
    table.insert(alien_biomes_priority_tiles, "heli-pad-entity")
end
