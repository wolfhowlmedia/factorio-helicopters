mod_gui = require("mod-gui")

heliSelectionGui =
{
	prefix = "heli_heliSelectionGui_",

	new = function(mgr, p)
		obj =
		{
			valid = true,
			manager = mgr,
			player = p,

			guiElems =
			{
				parent = mod_gui.get_frame_flow(p),
			},
			prefix = "heli_heliSelectionGui_",

			curCamID = 0,
		}

		setmetatable(obj, {__index = heliSelectionGui})
		obj:buildGui()

		return obj
	end,

	destroy = function(self)
		self.valid = false

		if self.guiElems.root and self.guiElems.root.valid then
			self.guiElems.root.destroy()
		end
	end,

	setVisible = function(self, val)
		self.guiElems.root.visible = val
	end,

	OnTick = function(self)
		self:updateCamPositions()
	end,

	OnPlayerChangedForce = function(self, player)
		if player == self.player then
			local vis = self.visible
			self.guiElems.root.destroy()
			self.guiElems = {parent = self.guiElems.parent}
			self.selectedCam = nil
			self:buildGui()
			self:setVisible(vis)
		end
	end,

	OnGuiClick = function(self, e)
		local name = e.element.name

		if name:match("^" .. self.prefix .. "cam_%d+$") then
			self:OnCamClicked(e) --Heli Selected Clicked

		elseif name == self.prefix .. "rootFrame" and e.button == defines.mouse_button_type.right then
			self.manager:OnChildEvent(self, "cancel")

		elseif self.selectedCam then
			if name == self.prefix .. "btn_toPlayer" then
				if e.surfaceSwap == nil then
					if e.button == defines.mouse_button_type.left then
						if e.shift then --land on current player position
							self.manager:OnChildEvent(self, "selectedPosition", self.player.position)
						else
							self.manager:OnChildEvent(self, "selectedPlayer", self.player)
						end
					else
						self.manager:OnChildEvent(self, "showTargetSelectionGui", playerSelectionGui)
					end
				else
					if self.selectedCam.heli.curState.name ~= "landed" and self.selectedCam.heli.remoteController and self.selectedCam.heli.remoteController.targetIsPlayer == true then
						self.manager:OnChildEvent(self, "selectedPosition", self.selectedCam.heli.baseEnt.position)--heli was on the way to player, but player changed surface -> landing at last spot
						return true
					end
				end

			elseif name == self.prefix .. "btn_toMap" then --To Map Marker Button Pressed
				self.manager:OnChildEvent(self, "showTargetSelectionGui", markerSelectionGui)

			elseif name == self.prefix .. "btn_toPad" then --To Pad Button Pressed
				self.manager:OnChildEvent(self, "showTargetSelectionGui", heliPadSelectionGui)

			elseif name == self.prefix .. "btn_stop" then --Stop Button Pressed
				if self.selectedCam.heliController then
					self.selectedCam.heliController:stopAndDestroy()
				end
			end
		end
	end,

	OnHeliBuilt = function(self, heli)
		if heli.baseEnt.force == self.player.force then
			local flow, cam = self:buildCam(self.guiElems.camTable, self.curCamID, heli.baseEnt.position, heli.baseEnt.surface_index, 0.3, false, false)

			table.insert(self.guiElems.cams,
			{
				flow = flow,
				cam = cam,
				heli = heli,
				ID = self.curCamID,
			})

			self.curCamID = self.curCamID + 1

			self:setNothingAvailableIfNecessary()
		end
	end,

	OnHeliRemoved = function(self, heli)
		for i, curCam in ipairs(self.guiElems.cams) do
			if curCam.heli == heli then
				if curCam == self.selectedCam then
					self.selectedCam = nil
					self:setControlBtnsStatus(false, false)
					self.manager:OnChildEvent(self, "OnSelectedHeliIsInvalid")
				end

				curCam.flow.destroy()
				table.remove(self.guiElems.cams, i)
				self:setNothingAvailableIfNecessary()
				break
			end
		end
	end,

	OnHeliControllerCreated = function(self, controller)
		local cam = searchInTable(self.guiElems.cams, controller.heli, "heli")
		if cam then
			cam.heliController = controller
			self:setCamStatus(cam, cam == self.selectedCam, true)
		end
	end,

	OnHeliControllerDestroyed = function(self, controller)
		local cam = searchInTable(self.guiElems.cams, controller, "heliController")
		if cam then
			cam.heliController = nil
			self:setCamStatus(cam, cam == self.selectedCam, false)
		end
	end,

	OnCamClicked = function(self, e)
		if e.button == defines.mouse_button_type.left then
			local camID = tonumber(e.element.name:match("%d+"))
			local cam = searchInTable(self.guiElems.cams, camID, "ID")
			self:setCamStatus(cam, true, cam.heliController)

			Entity.set_data(self.player, cam.heli, "heliSelectionGui_lastSelectedHeli")

		elseif e.button == defines.mouse_button_type.right then
			local zoomMax = 1.26
			local zoomMin = 0.2
			local zoomDelta = 0.333

			if e.shift then
				e.element.zoom = e.element.zoom * (1 + zoomDelta)
				if e.element.zoom > zoomMax then
					e.element.zoom = zoomMin
				end
			else
				e.element.zoom = e.element.zoom * (1 - zoomDelta)
				if e.element.zoom < zoomMin then
					e.element.zoom = zoomMax
				end
			end
		end
	end,

	getDefaultZoom = function(self)
		return self.player.mod_settings["heli-gui-heliSelection-defaultZoom"].value
	end,

	getCamIndexById = function(self, ID)
		for i, curCam in ipairs(self.guiElems.cams) do
			if curCam.ID == ID then return i end
		end
	end,

	updateCamPositions = function(self)
		for k, curCam in pairs(self.guiElems.cams) do
			if curCam.heli.valid then
				curCam.cam.position = curCam.heli.baseEnt.position
			end
		end
	end,

	setCamStatus = function(self, cam, isSelected, hasController)
		local flow = cam.flow

		local pos = cam.cam.position
		local zoom = cam.cam.zoom
		local surfaceIndex = 1
		if cam.heli.baseEnt.valid then
			surfaceIndex = cam.heli.baseEnt.surface_index or 1
		end
		--game.print("Surface "..surfaceIndex)

		flow.clear()

		cam.cam = self:buildCamInner(flow, cam.ID, pos, surfaceIndex, zoom, isSelected, cam.heliController)

		if isSelected then
			if self.selectedCam and self.selectedCam ~= cam then
				self:setCamStatus(self.selectedCam, false, hasController)
			end
			self.selectedCam = cam
			self:setControlBtnsStatus(isSelected, hasController)
		else
			if self.selectedCam and self.selectedCam == cam then
				self.selectedCam = nil
			end
		end
	end,

	setControlBtnsStatus = function(self, heliSelected, hasController)
		self.guiElems.btnToPlayer.enabled = heliSelected
		self.guiElems.btnToMap.enabled = heliSelected
		self.guiElems.btnToPad.enabled = heliSelected
		self.guiElems.btnStop.enabled = heliSelected and not isNil(hasController)
	end,

	setNothingAvailableIfNecessary = function(self)
		local els = self.guiElems
		local nec = #els.cams == 0

		if nec and not els.nothingAvailable then
			els.nothingAvailable = els.camTable.add
			{
				type = "label",
				name = self.prefix .. "nothingAvailable",
				caption = {"heli-gui-heliSelection-noHelisAvailable"},
			}
			els.nothingAvailable.style.font = "default-bold"
			els.nothingAvailable.style.font_color = {r = 1, g = 0, b = 0}

		elseif not nec and els.nothingAvailable then
			els.nothingAvailable.destroy()
			els.nothingAvailable = nil
		end
	end,

	buildCamInner = function(self, parent, ID, position, surfaceIndex, zoom, isSelected, hasController)
		local camParent = parent
		local padding = 8
		local size = 210
		local camSize = size - padding

		if isSelected then
			camParent = camParent.add
			{
				type = "sprite",
				name = self.prefix .. "camBox_selected_" .. tostring(ID),
				sprite = "heli_gui_selected",
			}
			camParent.style.minimal_width = size
			camParent.style.minimal_height = size
			camParent.style.maximal_width = size
			camParent.style.maximal_height = size
		end

		local cam = camParent.add
		{
			type = "camera",
			name = self.prefix .. "cam_" .. tostring(ID),
			position = position,
			surface_index = surfaceIndex,
			zoom = zoom,
			tooltip = {"heli-gui-cam-tt"},
		}
		cam.style.top_padding = padding
		cam.style.left_padding = padding

		cam.style.minimal_width = camSize
		cam.style.minimal_height = camSize

		if hasController then
			local label = cam.add
			{
				type = "label",
				caption = {"heli-gui-heliSelection-controlled"},
			}

			label.style.font = "pixelated"
			label.style.left_padding = 3
			label.style.top_padding = 16
			label.style.font_color = {r = 1, g = 0, b = 0}
		end

		local surface = cam.add
		{
			type = "label",
			caption = titleCase(game.surfaces[surfaceIndex].name),
		}
		surface.style.font = "pixelated"
		surface.style.left_padding = 3
		surface.style.font_color = {r = 1, g = 1, b = 1}

		return cam
	end,

	buildCam = function(self, parent, ID, position, surfaceIndex, zoom, isSelected, hasController)
		local flow = parent.add
		{
			type = "flow",
			name = self.prefix .. "camFlow_" .. tostring(ID),
		}

		flow.style.minimal_width = 214
		flow.style.minimal_height = 214
		flow.style.maximal_width = 214
		flow.style.maximal_height = 214

		return flow, self:buildCamInner(flow, ID, position, surfaceIndex, zoom, isSelected, hasController)
	end,

	buildGui = function(self, selectedIndex)
		local els = self.guiElems

		if not els then
			self.guiElems = {}
			els = self.guiElems
		end

		if not els.parent or not els.parent.valid then
			els.parent = mod_gui.get_frame_flow(self.player)
		end

		els.root = els.parent.add
		{
			type = "frame",
			name = self.prefix .. "rootFrame",
			caption = {"heli-gui-heliSelection-frame-caption"},
			style = "frame",
			direction = "vertical",
			tooltip = {"heli-gui-frame-tt"},
		}

		els.root.style.maximal_width = 1000
		els.root.style.maximal_height = 700

		els.buttonFlow = els.root.add
		{
			type = "flow",
			name = self.prefix .. "btnFlow",
		}
		els.buttonFlow.style.left_padding = 7

		els.btnToPlayer = els.buttonFlow.add
		{
			type = "sprite-button",
			name = self.prefix .. "btn_toPlayer",
			sprite = "heli_to_player",
			style = mod_gui.button_style,
			tooltip = {"heli-gui-heliSelection-to-player-btn-tt"},
		}

		els.btnToMap = els.buttonFlow.add
		{
			type = "sprite-button",
			name = self.prefix .. "btn_toMap",
			sprite = "heli_to_map",
			style = mod_gui.button_style,
			tooltip = {"heli-gui-heliSelection-to-map-btn-tt"},
		}

		els.btnToPad = els.buttonFlow.add
		{
			type = "sprite-button",
			name = self.prefix .. "btn_toPad",
			sprite = "heli_to_pad",
			style = mod_gui.button_style,
			tooltip = {"heli-gui-heliSelection-to-pad-btn-tt"},
		}

		els.btnStop = els.buttonFlow.add
		{
			type = "sprite-button",
			name = self.prefix .. "btn_stop",
			sprite = "heli_stop",
			style = mod_gui.button_style,
			tooltip = {"heli-gui-heliSelection-stop-btn-tt"},
		}
		self:setControlBtnsStatus(false, false)

		els.scrollPane = els.root.add
		{
			type = "scroll-pane",
			name = self.prefix .. "scroller",
		}

		els.scrollPane.style.maximal_width = 1000
		els.scrollPane.style.maximal_height = 600

		els.camTable = els.scrollPane.add
		{
			type = "table",
			name = self.prefix .. "camTable",
			column_count = 4,
		}
		els.camTable.style.horizontal_spacing = 10
		els.camTable.style.vertical_spacing = 10

		els.cams = {}
		self.curCamID = 0

		if storage.helis then
			-- Retrieve last heli that was selected in this GUI
			local lastSelected = Entity.get_data(self.player, "heliSelectionGui_lastSelectedHeli")

			-- Flag to track whether a heli was explicitly selected
			local selectedSomething = false

			--[[
			local activeHeli = nil
			-- check if player in heli
			for _, possibleHeli in pairs(storage.helis) do
				if possibleHeli.baseEnt and possibleHeli.baseEnt.valid then
					local possibleDriver = possibleHeli.baseEnt.get_driver()

					-- Compare entity identity, not name
					if possibleDriver
					   and possibleDriver.valid
					   and self.player.character
					   and possibleDriver == self.player.character
					then
						activeHeli = possibleHeli
						break
					end
				end
			end
			]]

			-- decide which helis to appear in the GUI
			for _, curHeli in pairs(storage.helis) do
				if curHeli.baseEnt and curHeli.baseEnt.valid then

					--[[
					local curDriver = curHeli.baseEnt.get_driver()
					-----------------------------------------------------------------
					-- Two heli display modes:
					-- MODE 1: Player is NOT inside any heli (activeHeli == nil)
					--   Show helicopters that are:
					--     - unmanned,
					--     - remotely controllable,
					--     - driven by the player's own character
					-- MODE 2: Player IS inside a heli (activeHeli ~= nil)
					--   Show ONLY the heli the player is currently driving
					-----------------------------------------------------------------
					local showHeli =
						(
							(
								-- MODE 1: Player not inside a heli
								activeHeli == nil and
								(
									-- No driver present
									curDriver == nil

									-- heli is being controlled
									or curHeli.hasRemoteController

									-- heli is driven by the player's character
									or (
										curDriver
										and curDriver.valid
										and self.player.character
										and curDriver == self.player.character
									)
								)
							)
							or
							(
								-- MODE 2: Player is inside a heli
								curHeli == activeHeli
							)
						)
					]]

					-- If heli passes filters, create GUI entry
					if (curHeli.baseEnt.force == self.player.force) --[[and showHeli]] then
						-- Look up existing controller object for this heli
						local controller = searchInTable(storage.heliControllers, curHeli, "heli")

						-- Build camera GUI elements for this heli
						local flow, cam = self:buildCam(
							els.camTable,                  -- Parent GUI container
							self.curCamID,
							curHeli.baseEnt.position,
							curHeli.baseEnt.surface_index,
							self:getDefaultZoom(),
							selected,                      -- Selection state (external)
							curHeli.hasRemoteController    -- Remote control flag
						)

						-- Store camera metadata for later access
						table.insert(els.cams,
						{
							flow = flow,
							cam = cam,
							heli = curHeli,
							heliController = controller,
							ID = self.curCamID,
						})

						self.curCamID = self.curCamID + 1

						-- Restore selection if this heli was last selected
						if curHeli == lastSelected then
							selectedSomething = true
							self:setCamStatus(els.cams[self.curCamID], true, els.cams[self.curCamID].heliController)
						end
					end
				end
			end

			-- Fallback: if nothing was selected, select the first visible heli
			if not selectedSomething and #els.cams > 0 then
				self:setCamStatus(els.cams[1], true, els.cams[1].heliController)
			end
		end

		self:setNothingAvailableIfNecessary()
	end,

	-- Rebuild() is responsible for:
	-- destroying the old GUI root / recalculating visible helis / reapplying selection state
	Rebuild = function(self)
		if not self or not self.valid then return end

		-- Determine parent GUI element for rebuilding
		-- Preferred: Reuse previously stored parent so GUI stays in same GUI hierarchy location
		-- Fallback: If guiElems/parent missing (after reload, desync, partial teardown), recreate parent using mod_gui.get_frame_flow(player)
		local parent = nil
		if self.guiElems and self.guiElems.parent then
			parent = self.guiElems.parent
		else
			parent = mod_gui.get_frame_flow(self.player)
		end

		-- Preserve previous visibility state to ensure: an open GUI stays open after rebuild / a hidden GUI stays hidden
		-- Without: rebuilding would always force GUI visible
		local wasVisible = true
		if self.guiElems and self.guiElems.root and self.guiElems.root.valid then
			wasVisible = self.guiElems.root.visible

			-- Rebuild = full teardown + recreation
			self.guiElems.root.destroy()
		end

		-- Reset GUI state
		-- guiElems is recreated from scratch with only the parent known
		-- buildGui() will repopulate: root / camera elements / selection state
		self.guiElems = {parent = parent}

		-- selectedCam will be recalculated based on lastSelectedHeli or defaults
		-- curCamID must start at 0 so camera IDs are stable and predictable
		self.selectedCam = nil
		self.curCamID = 0

		-- buildGui() is responsible for: filtering visible helis / rebuilding camera previews / restoring selection
		self:buildGui()

		-- Restore visibility must be done after buildGui(), because buildGui() recreates the root element
		self:setVisible(wasVisible)
	end
}