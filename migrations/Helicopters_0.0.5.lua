--[[
require("logic.heliBase")
require("logic.heliAttack")
require("logic.heliPad")

global.helis = {}
global.heliPads = {}

for _,surface in pairs(game.surfaces) do
    cars = surface.find_entities_filtered{type = "car"}
    for _,car in pairs(cars) do
        if string.find(heliEntityNames, car.name .. ",", 1, true) then
            if string.find(heliBaseEntityNames, car.name .. ",", 1, true) then
                local driver = car.get_driver()
                car.set_driver(nil)
                local newHeli = insertInGlobal("helis", heliAttack.new(car))
                if driver then newHeli.baseEnt.set_driver(driver) end
            else
                car.set_driver(nil)
                car.destroy()
            end
        end
    end

    simples = surface.find_entities_filtered{type = "simple-entity-with-force"}
    padNames = "heli-pad-placement-entity,heli-pad-entity,"
    for _,simple in pairs(simples) do
        if string.find(padNames, simple.name .. ",", 1, true) then
            local newPad = insertInGlobal("heliPads", heliPad.new(simple))
        end
    end
end
]]--