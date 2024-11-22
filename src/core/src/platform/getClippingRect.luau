local types = require(script.Parent.Parent.types)

local getLayerElement = require(script.Parent.getLayerElement)
local isElement = require(script.Parent.isElement)

local rects = require(script.Parent.Parent.utils.rects)
local createRectFromGuiObject = rects.createRectFromGuiObject
local convertRectToBoundingRect = rects.convertRectToBoundingRect

local isArray = require(script.Parent.Parent.utils.isArray)

type ClippingAncestor = types.ContainingElement | types.RootBoundary

local EMPTY_RECT: types.Rect = {
	x = 0,
	y = 0,
	width = 0,
	height = 0,
}

local function getBoundingRectFromClippingAncestor(element: GuiObject, clippingAncestor: ClippingAncestor)
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

-- A "clipping ancestor" is an element with ClipsDescendants.
-- This returns all clipping ancestors of the given element up the instance tree, while also caching the result.
local function getClippingElementAncestors(element: GuiObject, cache: types.Cache)
	local cached = cache.elements[element]
	if cached then
		return cached
	end

	-- Get overflow ancestors
	local ancestors = {}
	local current = element.Parent

	while current ~= nil do
		if current:IsA("GuiObject") and current.ClipsDescendants then
			table.insert(ancestors, current :: GuiObject)
		end

		current = current.Parent
	end

	cache.elements[element] = ancestors

	return ancestors
end

--[[
	Returns the maximum area that the element is visible in due to any number of "clippable" ancestors.

	A clippable ancestor is any element ancestor that has `ClipsDescendants` enabled. Instances such as
	`ScrollingFrame`s will always be considered, but you can also make your own clippable boundaries of course.
]]
local function getClippingRect(
	element: GuiObject,
	boundary: types.Boundary,
	rootBoundary: types.RootBoundary,
	cache: types.Cache
): types.Rect
	-- Get initial ancestors
	local clippingAncestors: { ClippingAncestor }
	if boundary == "clipping-ancestors" then
		-- Automatic ancestor detection
		clippingAncestors = getClippingElementAncestors(element, cache)
	elseif isArray(boundary) then
		-- Array of GuiObject's
		clippingAncestors = table.clone(boundary)
	else
		-- GuiObject or Rect
		clippingAncestors = { boundary :: GuiObject | types.Rect }
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
