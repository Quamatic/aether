--[[
    Returns the "scale" of an element, which is based on its UIScale.
    This is needed because UIScale invalidates the position.
]]
local function getScale(element: GuiObject | LayerCollector)
	local scale = 1
	local current = element :: Instance?

	-- Multiple UIScale's can exist upstream, so it has to be done this way.
	while current ~= nil and current:IsA("GuiObject") do
		local scalar = current:FindFirstChildWhichIsA("UIScale")
		if scalar ~= nil then
			scale *= scalar.Scale
		end

		current = current.Parent
	end

	return scale
end

return getScale
