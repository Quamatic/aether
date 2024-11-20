local types = require(script.Parent.types)

local getPaddingObject = require(script.Parent.utils.getPaddingObject)

local rects = require(script.Parent.utils.rects)
local convertRectToBoundingRect = rects.convertRectToBoundingRect

local platform = require(script.Parent.platform)
local getOffsetParent = platform.getOffsetParent
local getClippingRect = platform.getClippingRect
local getLayerElement = platform.getLayerElement
local convertOffsetParentRelativeRectToViewportRelativeRect =
	platform.convertOffsetParentRelativeRectToViewportRelativeRect
local getScale = platform.getScale
local isElement = platform.isElement

export type DetectOverflowContext = "reference" | "target"

export type DetectOverflowConfig = {
	boundary: types.Boundary?,
	rootBoundary: types.RootBoundary?,
	elementContext: DetectOverflowContext?,
	altBoundary: boolean?,
	padding: types.Padding?,
}

--[[
    Resolves with an object of overflow side offsets that determine how much the
    element is overflowing a given clipping boundary on each side.

    - positive = overflowing the boundary by that number of pixels
    - negative = how many pixels left before it will overflow
    - 0 = lies flush with the boundary
]]
local function detectOverflow(state: types.MiddlewareState, config: DetectOverflowConfig): types.SideObject
	local rects = state.rects
	local elements = state.elements
	local cache = state.cache

	-- Config
	local boundary: types.Boundary = config.boundary or "clipping-ancestors"
	local rootBoundary: types.RootBoundary = config.rootBoundary or "layer-collector"
	local elementContext: DetectOverflowContext = config.elementContext or "target"
	local altBoundary = not not config.altBoundary
	local padding = getPaddingObject(config.padding or 0)

	-- State
	local altContext: DetectOverflowContext = if elementContext == "target" then "reference" else "target"
	local element = elements[if altBoundary then altContext else elementContext]

	-- Clipping boundary
	local rawElement: GuiObject = if isElement(element)
		then element
		-- Check if it's a reference element with a given context element.
		else if element.contextElement
			then element.contextElement
			-- If not, then we default to the containing layer.
			else getLayerElement(elements.target)

	-- Here we calculate the "clipping" rect, which is the maximum area
	-- the target element can safely be in.
	local clippingRect = convertRectToBoundingRect(getClippingRect(rawElement, boundary, rootBoundary, cache))

	-- The rect based on the element context
	local targetRect = if elementContext == "target"
		then {
			x = state.x,
			y = state.y,
			-- ^ target position is authoritated by state
			width = rects.target.width,
			height = rects.target.height,
		}
		else rects.reference

	local offsetParent = getOffsetParent(elements.target)
	local offsetScale = if offsetParent then getScale(offsetParent, cache) else 1

	local elementRect = convertRectToBoundingRect(
		if offsetParent
			then convertOffsetParentRelativeRectToViewportRelativeRect(targetRect, offsetParent, cache)
			else targetRect
	)

	-- And finally, return the side values.
	return {
		top = (clippingRect.top - elementRect.top + padding.top) / offsetScale,
		bottom = (elementRect.bottom - clippingRect.bottom + padding.bottom) / offsetScale,
		left = (clippingRect.left - elementRect.left + padding.left) / offsetScale,
		right = (elementRect.right - clippingRect.right + padding.right) / offsetScale,
	}
end

return detectOverflow
