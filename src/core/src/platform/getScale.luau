local types = require(script.Parent.Parent.types)

local isElement = require(script.Parent.isElement)

--[[
	Returns the scale of the given element.
 
	The scale of an element is the factor of each ancestor `UIScale` that affects it.
]]
local function getScale(element: types.ContainingElement, cache: types.Cache)
	local cached = cache.scales[element]
	if cached then
		return cached
	end

	local scale = 1
	local current = element :: Instance?

	while current ~= nil and isElement(current) do
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
