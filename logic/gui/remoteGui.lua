require("logic.gui.heliSelectionGui")
require("logic.gui.playerSelectionGui")
require("logic.gui.markerSelectionGui")
require("logic.gui.heliPadSelectionGui")

function setRemoteBtn(p, show)
	local flow = mod_gui.get_button_flow(p)

	if show and not flow.heli_remote_btn then
		flow.add
		{
			type = "sprite-button",
			name = "heli_remote_btn",
			sprite = "item/helicopter-remote-equipment",
			style = mod_gui.button_style,
			tooltip = {"heli-gui-remote-btn-tt"},
		}

	elseif (not show) and flow.heli_remote_btn and flow.heli_remote_btn.valid then
		flow.heli_remote_btn.destroy()

		local i = searchIndexInTable(storage.remoteGuis, p, "player")
		if i then
			storage.remoteGuis[i]:destroy()
			table.remove(storage.remoteGuis, i)
		end
	end
end

function toggleRemoteGui(player)
	local i = searchIndexInTable(storage.remoteGuis, player, "player")

	if not i then
		insertInGlobal("remoteGuis", remoteGui.new(player))
	else
		storage.remoteGuis[i]:destroy()
		table.remove(storage.remoteGuis, i)
	end
end

function OnHeliControllerCreated(controller)
	if not controller or not controller.heli then return end

	for _, rg in pairs(storage.remoteGuis) do
		local heliGui = rg.guis and rg.guis.heliSelection
		if heliGui and heliGui.OnHeliControllerCreated then
			heliGui:OnHeliControllerCreated(controller)
		end
	end
end

function OnHeliControllerDestroyed(controller)
	if not controller or not controller.heli then return end

	for _, rg in pairs(storage.remoteGuis) do
		local heliGui = rg.guis and rg.guis.heliSelection
		if heliGui and heliGui.OnHeliControllerDestroyed then
			heliGui:OnHeliControllerDestroyed(controller)
		end
	end
end


remoteGui =
{
	new = function(p)
		local obj = {
			valid = true,

			player = p,

			guis = {}
		}

		setmetatable(obj, {__index = remoteGui})
		obj.guis.heliSelection = heliSelectionGui.new(obj, p)
		return obj
	end,

	destroy = function(self)
		self.valid = false
		for k, curGui in pairs(self.guis) do
			if curGui.valid then
				curGui:destroy()
			end
		end
	end,

	hasMyPrefix = function(str)
		return string.startswith(str, heliSelectionGui.prefix) or
			string.startswith(str, playerSelectionGui.prefix) or
			string.startswith(str, markerSelectionGui.prefix) or
			string.startswith(str, heliPadSelectionGui.prefix)
	end,

	OnTick = function(self)
		if not self.player.valid then
			self:destroy()
		else
			for _, curGui in pairs(self.guis) do
				if curGui.OnTick then
					curGui:OnTick()
				end
			end
		end
	end,

	OnGuiClick = function(self, e)
		local name = e.element.name

		for _, curGui in pairs(self.guis) do
			if name:match("^" .. curGui.prefix .. ".+") and curGui.OnGuiClick then
				return curGui:OnGuiClick(e)
			end
		end
	end,

	OnGuiTextChanged = function(self, e)
		local name = e.element.name

		for k, curGui in pairs(self.guis) do
			if name:match("^" .. curGui.prefix .. ".+") and curGui.OnGuiTextChanged then
				curGui:OnGuiTextChanged(e)
			end
		end
	end,

	OnChildEvent = function(self, child, evtName, ...)
		if evtName == "showTargetSelectionGui" then --clicked map marker menu button
			local prot = ...
			self.guis.heliSelection:setVisible(false)
			self.guis.targetSelection = prot.new(self, self.player)

		elseif evtName == "selectedPosition" then --clicked map marker or heli pad
			local pos = ...
			local heli = self.guis.heliSelection.selectedCam.heli

			assignHeliController(self.player, heli, pos, false)

			if child ~= self.guis.heliSelection then
				child:destroy()
				self.guis.targetSelection = nil
			end
			self.guis.heliSelection:setVisible(true)

		elseif evtName == "selectedPlayer" then --clicked to let heli follow player
			local p = ...
			local heli = self.guis.heliSelection.selectedCam.heli

			if heli.baseEnt.surface_index == self.player.surface_index then
				assignHeliController(self.player, heli, p, true)

				if child ~= self.guis.heliSelection then
					child:destroy()
					self.guis.targetSelection = nil
				end
				self.guis.heliSelection:setVisible(true)
			else
				self.player.create_local_flying_text{
					text = {"heli-gui-heliSelection-missmatch"},
					create_at_cursor = true,
					color = {1,0,0,1},
					time_to_live = 120,
				}
				self.player.play_sound{path = "heli-cant-do"}
			end
		elseif evtName == "OnSelectedHeliIsInvalid" then
			if self.guis.targetSelection then
				self.guis.targetSelection:destroy()
				self.guis.heliSelection:setVisible(true)
			end

		elseif evtName == "cancel" then
			if child == self.guis.heliSelection then
				self:destroy()
				removeInGlobal("remoteGuis", self)
			else
				child:destroy()
				self.guis.targetSelection = nil
				self.guis.heliSelection:setVisible(true)
			end
		end
	end,

	OnHeliRemoved = function(self, heli)
		for _,gui in pairs(self.guis) do
			if gui.OnHeliRemoved then
				gui:OnHeliRemoved(heli)
			end
		end
	end,

	OnHeliBuilt = function(self, heli)
		for _,gui in pairs(self.guis) do
			if gui.OnHeliBuilt then
				gui:OnHeliBuilt(heli)
			end
		end
	end,

	OnDrivingStateChanged = function(self, player, heli)
		-- if the callInGlobal reference is broken or misconfigured, self may be nil
		if not self then return end

		-- self.guis is expected to contain references to all open GUI controllers associated with this remoteGui (heliSelection, fuel gauge,...)
		if not self.guis then return end

		local heliSelectionGui = self.guis.heliSelection
		if not heliSelectionGui or not heliSelectionGui.Rebuild then return end

		-- rebuild guarantees GUI state stays consistent with current driving and selection logic
		heliSelectionGui:Rebuild()
	end
}