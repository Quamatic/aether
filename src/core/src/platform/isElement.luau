--[[
	Returns `true` if the provided value is a `GuiObject` or a `LayerCollector`.
]]
local function isElement(x: unknown)
	if typeof(x) ~= "Instance" then
		return false
	end

	return x:IsA("GuiObject") or x:IsA("LayerCollector")
end

return isElement
