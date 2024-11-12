local types = require(script.Parent.Parent.types)

local function createRectFromGuiObject(element: GuiObject | LayerCollector)
	local position = element.AbsolutePosition
	local size = element.AbsoluteSize

	return {
		x = position.X,
		y = position.Y,
		width = size.X,
		height = size.Y,
	}
end

local function convertRectToBoundingRect(rect: types.Rect): types.BoundingRect
	return {
		x = rect.x,
		y = rect.y,
		width = rect.width,
		height = rect.height,
		top = rect.y,
		bottom = rect.y + rect.height,
		left = rect.x,
		right = rect.x + rect.width,
	}
end

local function areRectsEqual(left: types.Rect, right: types.Rect)
	return left.x == right.x and left.y == right.y and left.width == right.width and left.height == right.height
end

return {
	createRectFromGuiObject = createRectFromGuiObject,
	convertRectToBoundingRect = convertRectToBoundingRect,
	areRectsEqual = areRectsEqual,
}
