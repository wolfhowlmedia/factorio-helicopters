function playerIsInHeli(p)
	return p.driving and string.find(heliBaseEntityNames, p.vehicle.name .. ",", 1, true)
end

function getHeliFromBaseEntity(ent)
	for k,v in pairs(global.helis) do
		if v.baseEnt == ent then
			return v
		end
	end

	return nil
end

function findNearestAvailableHeli(pos, force, requestingPlayer)
	local nearestHeli = nil
	local nearestDist = nil

	if global.helis then
		for k, curHeli in pairs(global.helis) do
			if curHeli.baseEnt.valid and 
				curHeli.baseEnt.force == force and 
					(not curHeli.baseEnt.get_driver() or (curHeli.hasRemoteController and curHeli.remoteController.driverIsBot)) then

				if not requestingPlayer or (not curHeli.remoteController or curHeli.remoteController.owner == requestingPlayer) then
					local curDist = getDistance(pos, curHeli.baseEnt.position)
					
					if (not nearestDist) or (nearestDist and curDist < nearestDist) then
						nearestDist = curDist
						nearestHeli = curHeli
					end
				end
			end
		end
	end

	return nearestHeli, nearestDist
end

function IsEntityBurnerOutOfFuel(ent)
	return ent.burner.remaining_burning_fuel <= 0 and ent.burner.inventory.is_empty()
end

function transferGridEquipment(srcEnt, destEnt)
	if srcEnt.grid and destEnt.grid then --assume they have the same size and destEnt.grid is empty.
		for i, equip in ipairs(srcEnt.grid.equipment) do
			local newEquip = destEnt.grid.put{name = equip.name, position = equip.position}

			if equip.type == "energy-shield-equipment" then newEquip.shield = equip.shield end
			newEquip.energy = equip.energy
		end
		srcEnt.grid.clear()
	end
end