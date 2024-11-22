local types = require(script.Parent.Parent.types)

local getLayerElement = require(script.Parent.getLayerElement)
local getElementBoundingRect = require(script.Parent.getElementBoundingRect)
local getScale = require(script.Parent.getScale)

--[[
	Converts the given rect into a rect that is relative to that of the given offset parent.
]]
local function convertOffsetParentRectToRelativeRect(
	rect: types.Rect,
	offsetParent: types.ContainingElement,
	cache: types.Cache
): types.Rect
	local layerElement = getLayerElement(offsetParent)
	if layerElement == (offsetParent :: LayerCollector) then
		return rect
	end

	local scrollOffset = Vector2.zero
	if offsetParent:IsA("ScrollingFrame") then
		scrollOffset = offsetParent.CanvasPosition
	end

	local offsetRect = getElementBoundingRect(offsetParent, false, nil, cache)
	local scale = getScale(offsetParent, cache)

	return {
		x = rect.x * scale - scrollOffset.X * scale + offsetRect.x,
		y = rect.y * scale - scrollOffset.Y * scale + offsetRect.y,
		width = rect.width * scale,
		height = rect.height * scale,
	}
end

return convertOffsetParentRectToRelativeRect
