local types = require(script.Parent.Parent.types)

local getLayerElement = require(script.Parent.getLayerElement)

local rects = require(script.Parent.Parent.utils.rects)
local createRectFromGuiObject = rects.createRectFromGuiObject
local convertRectToBoundingRect = rects.convertRectToBoundingRect

type ClippingAncestor = GuiObject | types.RootBoundary

local function isElement(x: unknown)
	if typeof(x) ~= "Instance" then
		return false
	end

	return x:IsA("GuiObject") or x:IsA("LayerCollector")
end

local function isArray(x: unknown)
	return typeof(x) == "table" and #(x :: {}) > 0
end

local function getBoundingRectFromClippingAncestor(element: GuiObject, clippingAncestor: GuiObject | types.RootBoundary)
	local rect: types.Rect

	if clippingAncestor == "layer-collector" then
		local layer = getLayerElement(element)

		rect = if layer
			-- Forcing it to be recognized as GuiObject because LayerCollector has the required properties.
			then createRectFromGuiObject((layer :: any) :: GuiObject)
			else { x = 0, y = 0, width = 0, height = 0 }
	elseif isElement(clippingAncestor) then
		-- Ancestor is a GuiObject
		rect = createRectFromGuiObject(clippingAncestor :: GuiObject)
	else
		-- Ancestor is a rect
		rect = clippingAncestor :: types.Rect
	end

	return convertRectToBoundingRect(rect)
end

local function isClippingElement(element: Instance)
	return element:IsA("GuiObject") and element.ClipsDescendants
end

local function getOverflowAncestors(element: GuiObject)
	local ancestors = {}
	local current = element.Parent

	while current ~= nil do
		if isClippingElement(current) then
			table.insert(ancestors, current :: GuiObject)
		end

		current = current.Parent
	end

	return ancestors
end

-- Returns the maximum area for a floating element to be visible.
local function getClippingRect(
	element: GuiObject,
	boundary: types.Boundary,
	rootBoundary: types.RootBoundary
): types.Rect
	-- Get initial ancestors
	local clippingAncestors: { ClippingAncestor }
	if boundary == "clipping-ancestors" then
		clippingAncestors = getOverflowAncestors(element)
	elseif isArray(boundary) then
		clippingAncestors = table.clone(boundary)
	else
		clippingAncestors = { boundary :: any }
	end

	-- Insert root boundary
	table.insert(clippingAncestors, rootBoundary)

	-- Get maximum area rect
	local clippingRect = getBoundingRectFromClippingAncestor(element, clippingAncestors[1])

	for _, clippingAncestor: ClippingAncestor in clippingAncestors do
		local rect = getBoundingRectFromClippingAncestor(element, clippingAncestor)

		clippingRect.top = math.max(rect.top, clippingRect.top)
		clippingRect.bottom = math.min(rect.bottom, clippingRect.bottom)
		clippingRect.left = math.max(rect.left, clippingRect.left)
		clippingRect.right = math.min(rect.right, clippingRect.right)
	end

	return {
		x = clippingRect.left,
		y = clippingRect.top,
		width = clippingRect.right - clippingRect.left,
		height = clippingRect.bottom - clippingRect.top,
	}
end

return getClippingRect
