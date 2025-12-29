mod_gui = require("mod-gui")

heliPadSelectionGui =
{
	prefix = "heli_heliPadSelectionGui_",

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
			prefix = "heli_heliPadSelectionGui_",
		}

		setmetatable(obj, {__index = heliPadSelectionGui})
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

	OnGuiClick = function(self, e)
		local name = e.element.name

		if name:match("^" .. self.prefix .. "cam_%d+$") then
			self:OnCamClicked(e)

		elseif name == self.prefix .. "close" and e.button == defines.mouse_button_type.left then
			self.manager:OnChildEvent(self, "cancel")

		elseif name == self.prefix.."rename_confirm" then
			renameEntity(self, e, "pad")

		elseif name == self.prefix.."rename_close" then
			e.element.parent.parent.destroy()
		end
	end,

	OnGuiTextConfirmed = function(self, e)
		if e.element.name == self.prefix.."rename_field" then
			renameEntity(self, e, "pad")
		end
	end,

	OnCamClicked = function(self, e)
		if e.button == defines.mouse_button_type.left then
			local camID = tonumber(e.element.name:match("%d+"))
			local cam = searchInTable(self.guiElems.cams, camID, "ID")
			local heliSurface = self.manager.guis.heliSelection.selectedCam.heli.surface.index --heli
			local padSurface = cam.heliPad.surface.index --pad

			if heliSurface == padSurface then --if case made here so that pad UI doesn't close
				self.manager:OnChildEvent(self, "selectedPosition", cam.heliPad.baseEnt.position)
			else
				local player = game.players[e.player_index]
				player.create_local_flying_text{
					text = {"heli-gui-heliSelection-missmatch"},
					create_at_cursor = true,
					color = {1,0,0,1},
					time_to_live = 120,
				}
				player.play_sound{path = "heli-cant-do"}
			end
		elseif e.button == defines.mouse_button_type.right then
			local zoomMax = 1.0125
			local zoomMin = 0.025
			local zoomDelta = 0.5

			if e.shift then
				e.element.zoom = e.element.zoom * (1 + zoomDelta)
				if e.element.zoom > zoomMax then
					e.element.zoom = zoomMin
				end
			elseif e.alt then
				local camID = tonumber(e.element.name:match("%d+"))
				local cam = searchInTable(self.guiElems.cams, camID, "ID")

				if guiHasChild(cam.cam, self.prefix.."rename_root") then return end

				local root = cam.cam.add{
					type = "frame",
					name = self.prefix.."rename_root",
					direction = "vertical",
				}
				root.style.natural_width = 195

				local flow = root.add{
					type = "flow",
					name = self.prefix.."flow",
					direction = "horizontal",
				}

				flow.add{
					type = "label",
					name = self.prefix.."rename_label",
					caption = {"heli-gui-padSelection-rename-caption"},
					style = "frame_title"
				}
				local ew = flow.add{
					type = "empty-widget",
					name = self.prefix.."rename_ew",
				}
				ew.style.horizontally_stretchable = true

				flow.add{
					type = "sprite-button",
					name = self.prefix.."rename_close",
					sprite = "utility/close",
					style = "close_button",
				}

				local renameFlow = root.add
				{
					type = "flow",
					name = self.prefix.."rename_flow",
					direction = "horizontal",
				}

				renameFlow.add{
					type = "sprite-button",
					name = self.prefix.."rename_confirm",
					sprite = "utility/check_mark",
					style = "item_and_count_select_confirm",
				}

				local searchField = renameFlow.add{
					type = "textfield",
					name = self.prefix.."rename_field",
					text = cam.heliPad.name or "Default",
					style = "stretchable_textfield"
				}
				searchField.style.minimal_height = 26
				searchField.style.minimal_width = 75
				searchField.focus()
			else
				e.element.zoom = e.element.zoom * (1 - zoomDelta)
				if e.element.zoom < zoomMin then
					e.element.zoom = zoomMax
				end
			end
		end
	end,

	OnHeliPadBuilt = function(self, heliPad)
		if heliPad.baseEnt.force == self.player.force then
			table.insert(self.guiElems.cams,
			{
				cam = self:buildCam(self.guiElems.camTable, self.curCamID, heliPad, self:getDefaultZoom()),
				heliPad = heliPad,
				ID = self.curCamID,
			})

			self.curCamID = self.curCamID + 1
			self:setNothingAvailable(false)
		end
	end,

	OnHeliPadRemoved = function(self, heliPad)
		local i = searchIndexInTable(self.guiElems.cams, heliPad, "heliPad")
		if i then
			self.guiElems.cams[i].cam.destroy()
			table.remove(self.guiElems.cams, i)

			if #self.guiElems.cams == 0 then
				self:setNothingAvailable(true)
			end
		end
	end,

	OnPlayerChangedForce = function(self, player)
		if player == self.player then
			self.guiElems.root.destroy()
			self.guiElems = {parent = self.guiElems.parent}
			self:buildGui()
		end
	end,

	getDefaultZoom = function(self)
		return self.player.mod_settings["heli-gui-heliPadSelection-defaultZoom"].value
	end,

	buildCam = function(self, parent, ID, heliPad, zoom)
		local padding = 8
		local size = 210
		local camSize = size - padding
		local position = heliPad.baseEnt.position
		local surfaceIndex = heliPad.baseEnt.surface_index

		local cam = parent.add
		{
			type = "camera",
			name = self.prefix .. "cam_" .. tostring(ID),
			position = position,
			surface_index = surfaceIndex,
			zoom = zoom,
			tooltip = {"helipad-gui-cam-tt"},
		}
		cam.style.top_padding = padding
		cam.style.left_padding = padding

		cam.style.size = camSize

		local name = cam.add
		{
			type = "label",
			caption = titleCase(heliPad.name or "Default"),
		}
		name.style.font = "pixelated_normal"
		name.style.left_padding = 3
		name.style.font_color = {r = 1, g = 1, b = 1}

		local surface = cam.add
		{
			type = "label",
			caption = titleCase(game.surfaces[surfaceIndex].name),
		}
		surface.style.font = "pixelated_small"
		surface.style.left_padding = 3
		surface.style.top_padding = 20
		surface.style.font_color = {r = 1, g = 1, b = 1}

		return cam
	end,

	setNothingAvailable = function(self, val)
		local els = self.guiElems

		if val and not els.nothingAvailable then
			els.nothingAvailable = els.camTable.add
			{
				type = "label",
				name = self.prefix .. "nothingAvailable",
				caption = {"heli-gui-padSelection-noPadsAvailable"},
			}
			els.nothingAvailable.style.font = "default-bold"
			els.nothingAvailable.style.font_color = {r = 1, g = 0, b = 0}

		elseif not val and els.nothingAvailable then
			els.nothingAvailable.destroy()
			els.nothingAvailable = nil
		end
	end,

	buildGui = function(self)
		local els = self.guiElems

		buildBaseGUI(self, els, "heli-gui-padSelection-frame-caption")

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
			--tooltip = {"heli-gui-frame-tt"},
		}
		els.camTable.style.horizontal_spacing = 10
		els.camTable.style.vertical_spacing = 10

		self.curCamID = 0
		els.cams = {}

		local hasCams = false
		if storage.heliPads then
			for k, curPad in pairs(storage.heliPads) do
				if curPad.baseEnt.force == self.player.force then
					hasCams = true
					table.insert(els.cams,
					{
						cam = self:buildCam(els.camTable, self.curCamID, curPad, self:getDefaultZoom()),
						ID = self.curCamID,
						heliPad = curPad,
					})

					self.curCamID = self.curCamID + 1
				end
			end
		end

		if not hasCams then
			self:setNothingAvailable(true)
		end
	end,

	-- Rebuild() is responsible for:
	-- reapplying new pad name
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

		-- buildGui() is responsible for: filtering visible helis / rebuilding camera previews / restoring selection
		self:buildGui()

		-- Restore visibility must be done after buildGui(), because buildGui() recreates the root element
		self:setVisible(wasVisible)
	end
}
