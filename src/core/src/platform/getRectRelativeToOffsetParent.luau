local types = require(script.Parent.Parent.types)

local getElementBoundingRect = require(script.Parent.getElementBoundingRect)

local function getRectRelativeToOffsetParent(
	element: types.ReferenceElement,
	offsetParent: GuiObject | LayerCollector?
): types.Rect
	local elementRect = getElementBoundingRect(element, true, offsetParent)
	local offsets = { x = 0, y = 0 }
	local scroll = Vector2.zero

	if offsetParent then
		if offsetParent:IsA("ScrollingFrame") then
			scroll = offsetParent.CanvasPosition
		end

		local offsetRect = getElementBoundingRect(offsetParent :: GuiObject, true, offsetParent)
		offsets.x = offsetRect.x
		offsets.y = offsetRect.y
	end

	local x = elementRect.left + scroll.X - offsets.x
	local y = elementRect.top + scroll.Y - offsets.y

	return {
		x = x,
		y = y,
		width = elementRect.width,
		height = elementRect.height,
	}
end

return getRectRelativeToOffsetParent
