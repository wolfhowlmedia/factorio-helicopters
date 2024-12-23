mod_gui = require("mod-gui")

markerSelectionGui =
{
    prefix = "heli_markerSelectionGui_",
    refreshCooldown = 20,

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

            curRefreshCooldown = markerSelectionGui.refreshCooldown,
            prefix = "heli_markerSelectionGui_",
        }

        setmetatable(obj, {__index = markerSelectionGui})

        obj:buildGui()

        if p.mod_settings["heli-auto-focus-searchfields"].value then 
            obj.guiElems.searchField.focus()
        end

        return obj
    end,

    destroy = function(self)
        self.valid = false

        if self.guiElems.root and self.guiElems.root.valid then
            self.guiElems.root.destroy()
        end
    end,

    OnTick = function(self)
        self.curRefreshCooldown = self.curRefreshCooldown - 1

        if self.curRefreshCooldown == 0 then
            self.curRefreshCooldown = self.refreshCooldown
            self:refreshBtnList()
        end
    end,

    OnPlayerChangedForce = function(self, player)
        if player == self.player then
            self.guiElems.root.destroy()
            self.guiElems = {parent = self.guiElems.parent}
            self:buildGui()
        end
    end,

    OnGuiClick = function(self, e)
        local name = e.element.name

        if name:match("^" .. self.prefix .. "btn_%d+$") then
            local ID = tonumber(e.element.name:match("%d+"))

            for _, curBtn in pairs(self.guiElems.btns) do
                if curBtn.tag.tag_number == ID then
                    if curBtn.tag.valid then
                        self.manager:OnChildEvent(self, "selectedPosition", curBtn.tag.position)
                    end
                    break
                end
            end

        elseif name == self.prefix .. "rootFrame" and e.button == defines.mouse_button_type.right then
            self.manager:OnChildEvent(self, "cancel")

        elseif name == self.prefix .. "searchFieldClearBtn" then
            self.guiElems.searchField.text = ""
            self:OnGuiTextChanged({element = self.guiElems.searchField})
        end
    end,

    OnGuiTextChanged = function(self, e)
        local name = e.element.name
        local newText = e.element.text

        if name == self.prefix .. "searchField" then
            if newText:contains(self.lastSearchFieldText) then
                self:filterBtnList(newText)
            else
                self:buildBtnList()
            end

            self.lastSearchFieldText = newText
        end
    end,

    removeBtnIndex = function(self, index)
        self.guiElems.btns[index].btn.destroy()
        table.remove(self.guiElems.btns, index)
    end,

    filterBtnList = function(self, filterStr)
        for i = #self.guiElems.btns, 1, -1 do
            local curBtn = self.guiElems.btns[i]
            if not curBtn.text:contains(filterStr) then
                self:removeBtnIndex(i)
            end
        end
        self:setNothingAvailableIfNecessary()
    end,

    refreshBtnList = function(self)
        local allTags = self:getFilteredChartTags()

        local numNewTags = #allTags
        local newTags = {}
        for _, v in pairs(allTags) do
            newTags[v.tag_number] = v
        end

        for i = #self.guiElems.btns, 1, -1 do
            local curBtn = self.guiElems.btns[i]

            if not curBtn.tag.valid then
                self:removeBtnIndex(i)

            else
                if newTags[curBtn.tag.tag_number] then
                    newTags[curBtn.tag.tag_number] = nil
                    numNewTags = numNewTags - 1
                end

                if curBtn.text ~= curBtn.tag.text then
                    curBtn.text = curBtn.tag.text
                    curBtn.btn.caption = "                " .. curBtn.tag.text
                end

                if not curBtn.icon and curBtn.tag.icon then
                    curBtn.icon, curBtn.iconType, curBtn.iconName = self:buildIconFromTag(curBtn.btn, curBtn.tag)

                elseif curBtn.icon and not curBtn.tag.icon then
                    curBtn.icon.destroy()
                    curBtn.icon, curBtn.iconType, curBtn.iconName = nil, nil, nil

                elseif curBtn.icon and (curBtn.iconType ~= curBtn.tag.icon.type or curBtn.iconName ~= curBtn.tag.icon.name) then
                    curBtn.icon.destroy()
                    curBtn.icon, curBtn.iconType, curBtn.iconName = self:buildIconFromTag(curBtn.btn, curBtn.tag)
                end
            end
        end

        if numNewTags > 0 then
            for _, curTag in pairs(newTags) do
                table.insert(self.guiElems.btns, self:buildBtnFromTag(self.guiElems.table, curTag))
            end
        end

        self:setNothingAvailableIfNecessary()
    end,

    setNothingAvailableIfNecessary = function(self)
        local els = self.guiElems
        local listIsEmpty = #els.btns == 0

        if listIsEmpty and not els.nothingAvailable then
            els.nothingAvailable = els.scroller.add
            {
                type = "label",
                name = self.prefix .. "nothingAvailable",
                caption = {"heli-gui-markerSelection-noMarkersAvailable"},
            }
            els.nothingAvailable.style.font = "default-bold"
            els.nothingAvailable.style.font_color = {r = 1, g = 0, b = 0}

        elseif not listIsEmpty and els.nothingAvailable then
            els.nothingAvailable.destroy()
            els.nothingAvailable = nil
        end
    end,

    getFilteredChartTags = function(self)
        local tagList = self.player.force.find_chart_tags(self.player.surface)

        for i = #tagList, 1, -1 do
            if not tagList[i].text:contains(self.guiElems.searchField.text) then
                table.remove(tagList, i)
            end
        end

        return tagList
    end,

    buildIconFromTag = function(self, parent, tag)
        local sprite
        if tag.icon.type == "virtual" then
            sprite = "virtual-signal/" .. tag.icon.name
        else
            sprite = tag.icon.type .. "/" .. tag.icon.name
        end

        local icon = parent.add
        {
            type = "sprite",
            name = self.prefix .. "icon",
            sprite = sprite,
        }

        return icon, tag.icon.type, tag.icon.name
    end,

    buildBtnFromTag = function(self, parent, tag)
        local btn = parent.add
        {
            type = "button",
            name = self.prefix .. "btn_" .. tostring(tag.tag_number),
            caption = "                " .. tag.text,
        }
        btn.style.minimal_height = 38
        btn.style.minimal_width = 290

        local icon, iconType, iconName = nil, nil, nil
        if tag.icon then
            icon, iconType, iconName = self:buildIconFromTag(btn, tag)
        end

        return {
            btn = btn,
            icon = icon,
            tag = tag,
            text = tag.text,
            iconType = iconType,
            iconName = iconName,
        }
    end,

    buildBtnList = function(self, _tagList)
        local tagList = _tagList or self:getFilteredChartTags()

        table.sort(tagList, self.tagCompareCB)

        self.guiElems.btns = {}
        self.guiElems.table.clear()
        for _, curTag in pairs(tagList) do
            table.insert(self.guiElems.btns, self:buildBtnFromTag(self.guiElems.table, curTag))
        end

        self:setNothingAvailableIfNecessary()
    end,

    tagCompareCB = function(a, b)
        if a.text ~= "" and b.text ~= "" then
            if a.text == b.text then
                return a.icon and not b.icon
            end
            return a.text < b.text
        elseif a.text ~= "" then
            return true
        elseif b.text ~= "" then
            return false
        else
            return a.icon and not b.icon
        end
    end,

    buildGui = function(self)
        self.guiElems.root = self.guiElems.parent.add
        {
            type = "frame",
            name = self.prefix .. "rootFrame",
            caption = {"heli-gui-markerSelection-frame-caption"},
            direction = "vertical",
            style = "frame",
            tooltip = {"heli-gui-frame-tt"},
        }

        self.guiElems.searchFieldFlow = self.guiElems.root.add
        {
            type = "flow",
            name = self.prefix .. "searchFieldFlow",
            direction = "horizontal",
        }

        self.guiElems.searchField = self.guiElems.searchFieldFlow.add
        {
            type = "textfield",
            name = self.prefix .. "searchField",
        }
        self.guiElems.searchField.style.width = 290

        self.guiElems.searchFieldClearBtn = self.guiElems.searchFieldFlow.add
        {
            type = "button",
            name = self.prefix .. "searchFieldClearBtn",
        }

        self.guiElems.scroller = self.guiElems.root.add
        {
            type = "scroll-pane",
            name = self.prefix .. "scroller",
        }

        self.guiElems.scroller.style.maximal_width = 1000
        self.guiElems.scroller.style.maximal_height = 600

        self.guiElems.table = self.guiElems.scroller.add
        {
            type = "table",
            name = self.prefix .. "table",
            column_count = 1,
        }

        self:buildBtnList()
    end,
}
