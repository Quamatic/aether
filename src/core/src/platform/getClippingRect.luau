local types = require(script.Parent.Parent.types)

local getLayerElement = require(script.Parent.getLayerElement)
local isElement = require(script.Parent.isElement)

local rects = require(script.Parent.Parent.utils.rects)
local createRectFromGuiObject = rects.createRectFromGuiObject
local convertRectToBoundingRect = rects.convertRectToBoundingRect

type ClippingAncestor = GuiObject | types.RootBoundary

local EMPTY_RECT: types.Rect = {
	x = 0,
	y = 0,
	width = 0,
	height = 0,
}

local function getBoundingRectFromClippingAncestor(element: GuiObject, clippingAncestor: GuiObject | types.RootBoundary)
	local rect = EMPTY_RECT

	if clippingAncestor == "layer-collector" then
		-- Ancestor is targeting the LayerCollector
		local layer = getLayerElement(element)

		-- TODO: maybe try to fix this case? React won't have this issue but Vide does, which I believe is due to deferring.
		if layer ~= nil then
			rect = createRectFromGuiObject(layer)
		end
	elseif isElement(clippingAncestor) then
		-- Ancestor is a GuiObject
		rect = createRectFromGuiObject(clippingAncestor :: GuiObject)
	else
		-- Ancestor is a rect
		rect = clippingAncestor :: types.Rect
	end

	return convertRectToBoundingRect(rect)
end

local function getOverflowAncestors(element: GuiObject)
	local ancestors = {}
	local current = element.Parent

	while current ~= nil do
		if element:IsA("GuiObject") and element.ClipsDescendants then
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
	else
		-- GuiObject or Rect
		clippingAncestors = { boundary }
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
