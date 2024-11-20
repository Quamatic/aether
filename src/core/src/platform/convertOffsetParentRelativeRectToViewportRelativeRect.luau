local types = require(script.Parent.Parent.types)

local getLayerElement = require(script.Parent.getLayerElement)
local getElementBoundingRect = require(script.Parent.getElementBoundingRect)
local getScale = require(script.Parent.getScale)

local function convertOffsetParentRelativeRectToViewportRelativeRect(
	rect: types.Rect,
	offsetParent: types.ContainingElement,
	cache: types.Cache
): types.Rect
	local layerElement = getLayerElement(offsetParent)
	if layerElement == (offsetParent :: LayerCollector) then
		return rect
	end

	local scroll = Vector2.zero
	if offsetParent:IsA("ScrollingFrame") then
		scroll = offsetParent.CanvasPosition
	end

	local offsetRect = getElementBoundingRect(offsetParent, false, nil, cache)
	local scale = getScale(offsetParent, cache)

	return {
		x = rect.x * scale - scroll.X * scale + offsetRect.x,
		y = rect.y * scale - scroll.Y * scale + offsetRect.y,
		width = rect.width * scale,
		height = rect.height * scale,
	}
end

return convertOffsetParentRelativeRectToViewportRelativeRect
