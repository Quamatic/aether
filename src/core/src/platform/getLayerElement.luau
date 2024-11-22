local types = require(script.Parent.Parent.types)

--[[
	Returns the contaning `LayerCollector` instance of the given element, if one exists.
]]
local function getLayerElement(element: types.ContainingElement): LayerCollector?
	return if element:IsA("LayerCollector") then element else element:FindFirstAncestorWhichIsA("LayerCollector")
end

return getLayerElement
