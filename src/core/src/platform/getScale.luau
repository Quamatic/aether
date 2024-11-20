local types = require(script.Parent.Parent.types)

--[[
    Returns the "scale" of an element, which is based on ancestor UIScale's.
    This is needed because UIScale invalidates the position.
]]
local function getScale(element: types.ContainingElement, cache: types.Cache)
	local cached = cache.scales[element]
	if cached then
		return cached
	end

	local scale = 1
	local current = element :: Instance?

	while current ~= nil and current:IsA("GuiObject") do
		local scalar = current:FindFirstChildWhichIsA("UIScale")
		if scalar ~= nil then
			scale *= scalar.Scale
		end

		current = current.Parent
	end

	cache.scales[element] = scale

	return scale
end

return getScale
