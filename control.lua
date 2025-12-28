if script.active_mods["gvv"] then require("__gvv__.gvv")() end
math3d = require("math3d")
require("logic.mtMgr")

require("logic.util")
require("logic.timer")
require("logic.simpleNoise")

require("logic.heliBase")
require("logic.heliAttack")
require("logic.heliScout")

require("logic.heliPad")
require("logic.heliController")
require("logic.gui.remoteGui")
require("logic.gui.gaugeGui")

Entity = require("stdlib.entity.entity")

mod_gui = require("mod-gui")

function playerIsInHeli(p)
    if not p.driving or not p.vehicle then
        return false
    end
    return string.find(heliBaseEntityNames, p.vehicle.name .. ",", 1, true) ~= nil
end

function OnLoad(e)
	if storage.helis then
		for _, heli in pairs(storage.helis) do
			if not heli.type or heli.type == "heliAttack" or heli.type == "heliScout" then
				if heli.type == "heliAttack" or not heli.type then
					setmetatable(heli, {__index = heliAttack})
				elseif heli.type == "heliScout" then
					setmetatable(heli, {__index = heliScout})
				end
			end
		end
	end
	setMetatablesInGlobal("remoteGuis", {__index = remoteGui})
	setMetatablesInGlobal("heliPads", {__index = heliPad})
	setMetatablesInGlobal("heliControllers", {__index = heliController})

	--restore gui metatables
	if storage.remoteGuis then
		for _,remotegui in pairs(storage.remoteGuis) do
			for _,gui in pairs(remotegui.guis) do
				if gui.prefix then
					local n = string.gsub(gui.prefix, "heli_(%a+)_.*", "%1")
					if _G[n] then
						setmetatable(gui, {__index = _G[n]})
					end
				end
			end
		end
	end

	callInGlobal("helis", "OnLoad")

	mtMgr.OnLoad()
end

function OnConfigChanged(e)
	if storage.helis then
		for _, curHeli in pairs(storage.helis) do
			if not curHeli.curState then
				if curHeli.goUp then
					curHeli:changeState(curHeli.engineStarting)
				else
					curHeli:changeState(curHeli.descend)
				end
			end

			if not curHeli.surface then
				curHeli.surface = curHeli.baseEnt.surface
			end

			if not curHeli.type then
				curHeli.type = "heliAttack"
			end

			if curHeli.hasLandedCollider and not curHeli.childs.collisionEnt.valid then
				curHeli:setCollider("landed")
			end

			if not curHeli.deactivatedInserters then
				curHeli.deactivatedInserters = {}
			end

			curHeli:reassignCurState()
		end
	end

	if storage.heliPads then
		for k, curPad in pairs(storage.heliPads) do
			if not curPad.surface then
				curPad.surface = curPad.baseEnt.surface
			end
		end
	end

	for k, p in pairs(game.players) do
		local flow = mod_gui.get_button_flow(p)

		if flow.heli_remote_btn and flow.heli_remote_btn.valid then
			flow.heli_remote_btn.destroy()
		end

		OnArmorInventoryChanged({player_index = p.index})
		reSetGaugeGui(p)
	end

	if storage.heliControllers then
		for k, curController in pairs(storage.heliControllers) do
			if not curController.heli.remoteController then
				curController.heli.remoteController = curController
			end
		end
	end

	--fixing left open guis when saved
	if storage.remoteGuis then
		storage.remoteGuis = {}
		for _,p in pairs(game.players) do
			local flow = mod_gui.get_frame_flow(p)
			if flow["heli_heliSelectionGui_rootFrame"] then
				flow["heli_heliSelectionGui_rootFrame"].destroy()
			end
		end
	end
end

function OnTick(e)
	checkAndTickInGlobal("helis")
	checkAndTickInGlobal("remoteGuis")
	checkAndTickInGlobal("heliControllers")

	OnTimerTick()
end

function OnBuilt(e)
	local ent = e.entity

	if ent.name == "helicopter" then
		local newHeli = insertInGlobal("helis", heliAttack.new(ent))

		if storage.remoteGuis then
			for _,rg in pairs(storage.remoteGuis) do
				rg:OnHeliBuilt(newHeli)
			end
		end

	elseif ent.name == "helicopter-scout" then
		local newHeli = insertInGlobal("helis", heliScout.new(ent))

		if storage.remoteGuis then
			for _,rg in pairs(storage.remoteGuis) do
				rg:OnHeliBuilt(newHeli)
			end
		end

	elseif ent.name == "helicopter-pad" then
		local newPad = insertInGlobal("heliPads", heliPad.new(ent))
		callInGlobal("remoteGuis", "OnHeliPadBuilt", newPad)

	elseif ent.type == "inserter" then
		ent.active = true
	end
end

function OnRemoved(e)
	local ent = e.entity

	if ent.valid then
		local entName = ent.name

		if string.find(heliEntityNames, entName .. ",", 1, true) then
			for i,val in ipairs(storage.helis) do
				if val:isBaseOrChild(ent) then
					val:destroy()
					table.remove(storage.helis, i)

					if storage.remoteGuis then
						for _,rg in pairs(storage.remoteGuis) do
							rg:OnHeliRemoved(val)
						end
					end
				end
			end
		end

		if entName == "heli-pad-entity" then
			local i = getHeliPadIndexFromBaseEntity(ent)
			if i then
				storage.heliPads[i]:destroy()

				callInGlobal("remoteGuis", "OnHeliPadRemoved", storage.heliPads[i])
				table.remove(storage.heliPads, i)
			end
		end
	end
end

function OnHeliUp(e)
	local p = game.players[e.player_index]
	if playerIsInHeli(p) then
		getHeliFromBaseEntity(p.vehicle):OnUp()
	end
end

function OnHeliDown(e)
	local p = game.players[e.player_index]
	if playerIsInHeli(p) then
		getHeliFromBaseEntity(p.vehicle):OnDown()
	end
end

function OnHeliIncreaseMaxHeight(e)
	local p = game.players[e.player_index]
	if playerIsInHeli(p) then
		getHeliFromBaseEntity(p.vehicle):OnIncreaseMaxHeight()
	end
end

function OnHeliDecreaseMaxHeight(e)
	local p = game.players[e.player_index]
	if playerIsInHeli(p) then
		getHeliFromBaseEntity(p.vehicle):OnDecreaseMaxHeight()
	end
end

function OnHeliToggleFloodlight(e)
	local p = game.players[e.player_index]
	if playerIsInHeli(p) then
		getHeliFromBaseEntity(p.vehicle):OnToggleFloodlight()
	end
end

function OnHeliFollow(e)
	local p = game.players[e.player_index]

	if playerHasEquipment(p, "helicopter-remote-equipment") then
		local heli, dist = findNearestAvailableHeli(p.position, p.force, p)

		if heli then
			if heli.surface_index == p.surface_index then
				assignHeliController(p, heli, p, true)
				p.add_custom_alert(heli.baseEnt, {type = "item", name = "helicopter"}, {"heli-alert-follow", chopDecimal(dist)}, true)
			else
				p.create_local_flying_text{
					text = {"heli-gui-heliSelection-missmatch"},
					position = p.position,
					color = {1,0,0,1},
					time_to_live = 120,
				}
				p.play_sound{path = "heli-cant-do"}
			end
		end
	end
end

function OnSurfaceChange(e)
	--e.surface_index = FROM which surface
	local p = game.players[e.player_index]

	--throws a fake event with fake event data where flag is set and heli position will be taken
	local fakeEvent = {
		player_index = e.player_index,
		shift = true,
		surfaceSwap = true,
		element = {
			name = "heli_heliSelectionGui_btn_toPlayer",
		}
	}
	if OnGuiClick(fakeEvent) == true then
		p.create_local_flying_text{
			text = {"heli-gui-heliSelection-surfSwap"},
			position = p.position,
			color = {1,0,0,1},
		}
		p.play_sound{path = "heli-cant-do"}
	end
end

function OnRemoteOpen(e)
	local p = game.players[e.player_index]

	if playerHasEquipment(p, "helicopter-remote-equipment") then
		toggleRemoteGui(p)
	end
end

function OnPlacedEquipment(e)
	if e.equipment.name == "helicopter-remote-equipment" then
		local p = game.players[e.player_index]

		setRemoteBtn(p, true)
	end
end

function OnRemovedEquipment(e)
	if e.equipment == "helicopter-remote-equipment" then
		local p = game.players[e.player_index]

		if not equipmentGridHasItem(e.grid, "helicopter-remote-equipment") then
			setRemoteBtn(p, false)
		end
	end
end

function OnArmorInventoryChanged(e)
	local p = game.players[e.player_index]

	if playerHasEquipment(p, "helicopter-remote-equipment") then
		setRemoteBtn(p, true)
	else
		setRemoteBtn(p, false)
	end
end

function OnGuiClick(e)
	local name = e.element.name

	if name:match("^heli_") then
		local p = game.players[e.player_index]

		if name == "heli_remote_btn" then
			toggleRemoteGui(p)

		elseif gaugeGui.hasMyPrefix(name) then
			local i = searchIndexInTable(storage.gaugeGuis, p, "player")

			if i then
				storage.gaugeGuis[i]:OnGuiClick(e)
			end

		elseif remoteGui.hasMyPrefix(name) then
			local i = searchIndexInTable(storage.remoteGuis, p, "player")

			if i then
				return storage.remoteGuis[i]:OnGuiClick(e)
			end
		end
	end
end

function OnGuiTextChanged(e)
	local name = e.element.name

	if name:match("^heli_") then
		local p = game.players[e.player_index]
		local i = searchIndexInTable(storage.remoteGuis, p, "player")

		if i then
			storage.remoteGuis[i]:OnGuiTextChanged(e)
		end
	end
end

function OnPlayerChangedForce(e)
	local p = game.players[e.player_index]

	callInGlobal("remoteGuis", "OnPlayerChangedForce", p)
end

function OnPlayerDied(e)
	local p = game.players[e.player_index]

	setRemoteBtn(p, false)

	callInGlobal("remoteGuis", "OnPlayerDied", p)
end

function OnPlayerLeft(e)
	local p = game.players[e.player_index]
	local i = searchIndexInTable(storage.remoteGuis, p, "player")

	if i then
		storage.remoteGuis[i]:destroy()
		table.remove(storage.remoteGuis, i)
	end

	callInGlobal("remoteGuis", "OnPlayerLeft", p)
end

function OnPlayerRespawned(e)
	callInGlobal("remoteGuis", "OnPlayerRespawned", game.players[e.player_index])
end

function OnDrivingStateChanged(e)
	local p = e and e.player_index and game.players[e.player_index] or nil
	local ent = e and e.entity or nil

	if not p or not ent or not ent.valid then return end

	local entityName = ent.name

	-- heliEntityNames = comma-separated string containing all valid heli base and heli child entity names
	if not string.find(heliEntityNames, entityName .. ",", 1, true) then return end

	local heli = nil
	for _, currentHeli in ipairs(storage.helis) do
		-- isBaseOrChild returns true if the entity belongs to this heli
		if currentHeli:isBaseOrChild(ent) then
			heli = currentHeli
			break
		end
	end

	if not heli then log("Warning: No Heli found!") return end

	reSetGaugeGui(p)

	if p.driving then -- player just entered heli 
		-- store heli as "last selected heli" for heli selection GUI (to preselect active heli / show only this heli while the player is inside it)
		Entity.set_data(p, heli, "heliSelectionGui_lastSelectedHeli")
	else -- player just exited heli
		-- execute heli-specific eject logic to  handle cleanup, state resets, delayed actions
		heli:OnPlayerEjected(p)
	end

	-- notify all remote GUI controllers that driving state changed
	-- callInGlobal dispatches to globally registered "remoteGuis" object
	-- -> triggers rebuild of open GUIs, ensuring UI immediately reflects new driving state without requiring manual reopen
	callInGlobal("remoteGuis", "OnDrivingStateChanged", p, heli)
end

function OnPlayerJoined(e)
	OnArmorInventoryChanged(e)
end

function OnPlayerCreated(e)
	OnArmorInventoryChanged(e)
end

function OnRuntimeSettingsChanged(e)
	local name = e.setting

	if name:match("^heli-") then
		local p = game.players[e.player_index]

		if e.setting_type == "runtime-per-user" then
			local val = p.mod_settings[name].value

			if name == "heli-gaugeGui-show" then
				reSetGaugeGui(p)
			end

		--elseif e.setting_type == "runtime-global" then
		--	local val = settings.global[name]

		end
	end
end

-- raised when a helicopter is damaged
function OnHeliDamaged(e)
	local ent = e.entity

	if ent.valid then
		local entName = ent.name

		if entName == "heli-entity-_-" then
			getHeliFromBaseEntity(ent):OnDamaged(e)
		end
	end
end

script.on_event(defines.events.on_built_entity, OnBuilt)
script.on_event(defines.events.on_robot_built_entity, OnBuilt)

script.on_load(OnLoad)
script.on_configuration_changed(OnConfigChanged)
script.on_event(defines.events.on_tick, OnTick)

script.on_event(defines.events.on_player_mined_entity, OnRemoved)
script.on_event(defines.events.on_robot_mined_entity, OnRemoved)
script.on_event(defines.events.on_entity_died, OnRemoved)

script.on_event(defines.events.on_entity_damaged, OnHeliDamaged)
script.set_event_filter(defines.events.on_entity_damaged, {{filter = "name", name = "heli-entity-_-"}})

script.on_event("heli-up", OnHeliUp)
script.on_event("heli-down", OnHeliDown)
script.on_event("heli-zaa-height-increase", OnHeliIncreaseMaxHeight)
script.on_event("heli-zab-height-decrease", OnHeliDecreaseMaxHeight)
script.on_event("heli-zba-toogle-floodlight", OnHeliToggleFloodlight)
script.on_event("heli-zca-remote-heli-follow", OnHeliFollow)
script.on_event("heli-zcb-remote-open", OnRemoteOpen)

script.on_event(defines.events.on_player_changed_surface, OnSurfaceChange)

script.on_event(defines.events.on_player_placed_equipment, OnPlacedEquipment)
script.on_event(defines.events.on_player_removed_equipment, OnRemovedEquipment)
script.on_event(defines.events.on_gui_click, OnGuiClick)
script.on_event(defines.events.on_gui_text_changed, OnGuiTextChanged)

script.on_event(defines.events.on_player_changed_force, OnPlayerChangedForce)
script.on_event(defines.events.on_player_died, OnPlayerDied)
script.on_event(defines.events.on_player_left_game, OnPlayerLeft)
script.on_event(defines.events.on_player_respawned, OnPlayerRespawned)
script.on_event(defines.events.on_player_joined_game, OnPlayerJoined)
script.on_event(defines.events.on_player_created, OnPlayerCreated)

script.on_event(defines.events.on_player_armor_inventory_changed, OnArmorInventoryChanged)
script.on_event(defines.events.on_player_driving_changed_state, OnDrivingStateChanged)

script.on_event(defines.events.on_runtime_mod_setting_changed, OnRuntimeSettingsChanged)
