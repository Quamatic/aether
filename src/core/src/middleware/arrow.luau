local types = require(script.Parent.Parent.types)

local placement = require(script.Parent.Parent.utils.placement)
local getPlacementPosition = placement.getPlacementPosition
local getPlacementAxes = placement.getPlacementAxes

local _padding = require(script.Parent.Parent.utils.padding)
local getPaddingObject = _padding.getPaddingObject

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
	[types.Axis]: number,
	centerOffset: number,
	alignmentOffset: number?,
}

--[[
	Provides data to position an inner element of the floating element so that it
	appears centered to the reference element.
]]
local function arrow(input: types.Derivable<Input>): types.Middleware<Output>
	return {
		name = "arrow",
		run = function(state)
			local config = read(input) :: Input

			local element = config.element
			if element == nil then
				return nil -- cant work with anything without an element, so just skip.
			end

			local rects = state.rects

			local _, axis = getPlacementAxes(state.placement)
			local isVertical = axis == "y"
			local minSide = if isVertical then "top" else "left"
			local maxSide = if isVertical then "bottom" else "right"
			local length = if isVertical then "height" else "width"

			local position: types.Position = { x = state.x, y = state.y }
			local startDifference = position[axis] - rects.reference[axis]
			local endDifference = rects.reference[length]
				+ rects.reference[axis]
				- position[axis]
				- rects.target[length]

			-- TODO: Temporary until correct solution
			local clientSize = 0
			local arrowDimensions = {
				width = element.AbsoluteSize.X,
				height = element.AbsoluteSize.Y,
			}

			-- If the padding is large enough that it causes the arrow to no longer be
			-- centered, modify the padding so that it is centered.
			local largestPossiblePadding = clientSize / 2 - arrowDimensions[length] / 2 - 1
			local padding = getPaddingObject(config.padding or 0)
			local minPadding = math.min(padding[minSide], largestPossiblePadding)
			local maxPadding = math.min(padding[maxSide], largestPossiblePadding)

			-- Make sure the arrow doesn't overflow the floating element if the center
			-- point is outside the floating element's bounds.
			local min = minPadding
			local max = clientSize - arrowDimensions[length] - maxPadding
			local center = clientSize / 2 - arrowDimensions[length] / 2 + (endDifference / 2 - startDifference / 2)
			local offset = math.clamp(center, min, max)

			-- If the reference is small enough that the arrow's padding causes it to
			-- to point to nothing for an aligned placement, adjust the offset of the
			-- floating element itself. To ensure `shift()` continues to take action,
			-- a single reset is performed when this is true.
			local _, alignment = getPlacementPosition(state.placement)
			local shouldAddOffset = not state.data.arrow
				and alignment ~= nil
				and center ~= offset
				and rects.reference[length] / 2
						- (if center < min then minPadding else maxPadding)
						- arrowDimensions[length] / 2
					< 0
			local alignmentOffset = if shouldAddOffset then center < min else if center - min then center - max else 0

			return {
				[axis] = position[axis] + alignmentOffset,
				data = {
					[axis :: types.Axis] = offset,
					centerOffset = center - offset - alignmentOffset,
					alignmentOffset = if shouldAddOffset then alignmentOffset else nil,
				},
				reset = shouldAddOffset,
			}
		end,
	}
end

return arrow
