--- Tools for working with entities.
-- @module Entity.Entity
-- @usage local Entity = require('stdlib/entity/entity')

local Entity = {
    __class = 'Entity',
    --__index = require('stdlib/core')
}
setmetatable(Entity, Entity)

--- Tests whether an entity has access to a given field.
-- @tparam LuaEntity entity the entity to test the access to a field
-- @tparam string field_name the field name
-- @treturn boolean true if the entity has access to the field, false if the entity threw an exception when trying to access the field
function Entity.has(entity, field_name)
    assert(entity, 'missing entity argument')
    assert(field_name, 'missing field name argument')

    local status =
    pcall(
        function()
            return entity[field_name]
        end
    )
    return status
end

--- Gets the user data that is associated with an entity.
-- The user data is stored in the storage object and it persists between loads.
--> The user data will be removed from an entity when the entity becomes invalid.
-- @tparam LuaEntity entity the entity to look up
-- @treturn ?|nil|Mixed the user data, or nil if no data exists for the entity
function Entity.get_data(entity)
    assert(entity, 'missing entity argument')
    if not storage._entity_data then
        return nil
    end

    local code, unit_number = pcall(function() return entity.unit_number end)
    if unit_number then
        return storage._entity_data[unit_number]
    else
        local entity_name = entity.name
        if not storage._entity_data[entity_name] then
            return nil
        end

        local entity_category = storage._entity_data[entity_name]
        for _, entity_data in pairs(entity_category) do
            if Entity._are_equal(entity_data.entity, entity) then
                return entity_data.data
            end
        end
        return nil
    end
end

--- Associates the user data to an entity.
-- The user data will be stored in the storage object and it will persist between loads.
--> The user data will be removed from an entity when the entity becomes invalid.
-- @tparam LuaEntity entity the entity with which to associate the user data
-- @tparam ?|nil|Mixed data the data to set, or nil to delete the data associated with the entity
-- @treturn ?|nil|Mixed the previous data associated with the entity, or nil if the entity had no previous data
function Entity.set_data(entity, data)
    assert(entity, 'missing entity argument')

    if not storage._entity_data then
        storage._entity_data = {}
    end

    -- local unit_number = entity.unit_number
    local code, unit_number = pcall(function() return entity.unit_number end)
    if unit_number then
        local prev = storage._entity_data[unit_number]
        storage._entity_data[unit_number] = data
        return prev
    else
        local entity_name = entity.name
        if not storage._entity_data[entity_name] then
            storage._entity_data[entity_name] = {}
        end

        local entity_category = storage._entity_data[entity_name]

        for i = #entity_category, 1, -1 do
            local entity_data = entity_category[i]
            if not entity_data.entity.valid then
                table.remove(entity_category, i)
            end
            if Entity._are_equal(entity_data.entity, entity) then
                local prev = entity_data.data
                if data then
                    entity_data.data = data
                else
                    table.remove(entity_category, i)
                end
                return prev
            end
        end
        table.insert(entity_category, { entity = entity, data = data })
    end
    return nil
end

--- Tests if two entities are equal.
-- If they don't have a reference equality and ***entity\_a*** has ***equals*** function, it will be called with ***entity\_b*** as its first argument.
-- @tparam LuaEntity entity_a
-- @tparam LuaEntity entity_b
-- @treturn boolean
function Entity._are_equal(entity_a, entity_b)
    if entity_a == nil then
        return entity_a == entity_b
    elseif entity_a == entity_b then
        return true
    elseif Entity.has(entity_a, 'equals') and entity_a.equals ~= nil then
        return entity_a.equals(entity_b)
    else
        return false
    end
end

return Entity
