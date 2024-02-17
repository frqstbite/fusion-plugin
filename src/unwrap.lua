--!strict

--[[
	A common interface for accessing the values of state objects or constants.
]]


local function unwrap<T>(item, useDependency: boolean?): T
	return if (type(item) == "table" and item.type == "State") then item:get(useDependency) else item
end

return unwrap