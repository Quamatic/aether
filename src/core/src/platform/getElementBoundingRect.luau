local types = require(script.Parent.Parent.types)

local getScale = require(script.Parent.getScale)

local function createBoundingRectFromElement(element: types.ContainingElement): types.BoundingRect
	local position = element.AbsolutePosition
	local size = element.AbsoluteSize

	return {
		x = position.X,
		y = position.Y,
		width = size.X,
		height = size.Y,
		top = position.Y,
		left = position.X,
		right = position.X + size.X,
		bottom = position.Y + size.Y,
	}
end

local function getElementBoundingRect(
	element: types.ReferenceElement | LayerCollector,
	includeScale: boolean?,
	offsetParent: types.ContainingElement?,
	cache: types.Cache
): types.BoundingRect
	local rect: types.BoundingRect
	local relevantElement: types.ContainingElement? = nil

	if typeof(element) == "Instance" then
		rect = createBoundingRectFromElement(element)
		relevantElement = element
	elseif element.contextElement ~= nil then
		rect = createBoundingRectFromElement(element.contextElement)
		relevantElement = element.contextElement
	else
		rect = element.getBoundingRect()
	end

	local scale = 1
	if includeScale then
		if offsetParent then
			scale = getScale(offsetParent, cache)
		elseif relevantElement then
			scale = getScale(relevantElement, cache)
		end
	end

	local x = rect.left / scale
	local y = rect.top / scale
	local width = rect.width / scale
	local height = rect.height / scale

	return {
		x = x,
		y = y,
		width = width,
		height = height,
		top = y,
		left = x,
		right = x + width,
		bottom = y + height,
	}
end

return getElementBoundingRect
