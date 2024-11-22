local types = require(script.Parent.Parent.types)

local getElementBoundingRect = require(script.Parent.getElementBoundingRect)

local function getRectRelativeToOffsetParent(
	element: types.ReferenceElement,
	offsetParent: types.ContainingElement | nil,
	cache: types.Cache
): types.Rect
	local elementRect = getElementBoundingRect(element, true, offsetParent, cache)
	local offsets = { x = 0, y = 0 }
	local scrollOffset = Vector2.zero

	if offsetParent then
		if offsetParent:IsA("ScrollingFrame") then
			scrollOffset = offsetParent.CanvasPosition
		end

		local offsetRect = getElementBoundingRect(offsetParent, true, offsetParent, cache)
		offsets.x = offsetRect.x
		offsets.y = offsetRect.y
	end

	local x = elementRect.left + scrollOffset.X - offsets.x
	local y = elementRect.top + scrollOffset.Y - offsets.y

	return {
		x = x,
		y = y,
		width = elementRect.width,
		height = elementRect.height,
	}
end

return getRectRelativeToOffsetParent
