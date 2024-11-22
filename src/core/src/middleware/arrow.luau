local types = require(script.Parent.Parent.types)
type Side = types.Side
type Axis = types.Axis
type Length = types.Length

local placement = require(script.Parent.Parent.utils.placement)
local getPlacementPosition = placement.getPlacementPosition
local getPlacementAxes = placement.getPlacementAxes

local platform = require(script.Parent.Parent.platform)
local getOffsetParent = platform.getOffsetParent

local getPaddingObject = require(script.Parent.Parent.utils.getPaddingObject)
local read = require(script.Parent.Parent.utils.read)

export type Input = {
	--[[
		The arrow element to be positioned.
	]]
	element: GuiObject?,
	--[[
		The padding between the arrow element and the floating element edges.
   		Useful when the floating element has rounded corners.
	]]
	padding: types.Padding?,
}

export type Output = {
	[Axis]: number,
	centerOffset: number,
	alignmentOffset: number?,
}

local function getElementAxisLength(element: GuiObject, length: Length)
	return if length == "width" then element.AbsoluteSize.X else element.AbsoluteSize.Y
end

--[[
	Provides data to position an inner element of the floating element so that it
	appears centered to the reference element.

	More information: https://quamatic.github.io/aether/docs/middleware/arrow
]]
local function arrow(input: types.DerivableInput<Input>?): types.Middleware<Output>
	return {
		name = "arrow",
		run = function(state)
			local config = read(input or {}, state) :: Input

			local element = config.element
			if element == nil then
				return nil -- cant work without an element, so just skip.
			end

			local rects = state.rects

			local _, axis: Axis = getPlacementAxes(state.placement)
			local isVertical = axis == "y"
			local minSide: Side = if isVertical then "top" else "left"
			local maxSide: Side = if isVertical then "bottom" else "right"
			local length: Length = if isVertical then "height" else "width"

			local axisValue = if axis == "x" then state.x else state.y
			local startDifference: number = axisValue - rects.reference[axis]
			local endDifference: number = rects.reference[length]
				+ rects.reference[axis]
				- axisValue
				- rects.target[length]

			-- Get dimension length
			local arrowOffsetParent = getOffsetParent(element)
			local arrowAxisLength = getElementAxisLength(element, length)
			local clientSize = if arrowOffsetParent
				then getElementAxisLength(arrowOffsetParent, length) -- Parent length
				else rects.target[length] -- Target length

			-- Stored here due to usage
			local halfArrowAxisLength = arrowAxisLength / 2
			local relativeDiff = clientSize / 2 - halfArrowAxisLength

			-- If the padding is large enough that it causes the arrow to no longer be
			-- centered, modify the padding so that it is centered.
			local largestPossiblePadding = relativeDiff - 1
			local padding = getPaddingObject(config.padding or 0)
			local minPadding = math.min(padding[minSide], largestPossiblePadding)
			local maxPadding = math.min(padding[maxSide], largestPossiblePadding)

			-- Make sure the arrow doesn't overflow the floating element if the center
			-- point is outside the floating element's bounds.
			local min = minPadding
			local max = clientSize - arrowAxisLength - maxPadding
			local centerToReference = endDifference / 2 - startDifference / 2
			local center = relativeDiff + centerToReference
			local offset = math.clamp(center, min, max)

			-- If the reference is small enough that the arrow's padding causes it to
			-- to point to nothing for an aligned placement, adjust the offset of the
			-- floating element itself. To ensure `shift()` continues to take action,
			-- a single reset is performed when this is true.
			local _, alignment = getPlacementPosition(state.placement)
			local shouldAddOffset = state.data.arrow == nil
				and alignment ~= nil
				and center ~= offset
				and rects.reference[length] / 2
						- (if center < min then minPadding else maxPadding)
						- halfArrowAxisLength
					< 0

			local alignmentOffset = if shouldAddOffset then if center < min then center - min else center - max else 0

			return {
				[axis] = axisValue + alignmentOffset,
				data = {
					[axis] = offset,
					centerOffset = center - offset - alignmentOffset,
					alignmentOffset = if shouldAddOffset then alignmentOffset else nil,
				},
				reset = shouldAddOffset,
			}
		end,
	}
end

return arrow
