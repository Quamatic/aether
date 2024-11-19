local types = require(script.Parent.Parent.types)

local detectOverflow = require(script.Parent.Parent.detectOverflow)
type DetectOverflowConfig = detectOverflow.DetectOverflowConfig

local placement = require(script.Parent.Parent.utils.placement)
local getPlacementPosition = placement.getPlacementPosition

local read = require(script.Parent.Parent.utils.read)

export type Input = {
	--[[
		Optional config for `detectOverflow`.
	]]
	detectOverflowConfig: DetectOverflowConfig?,
	--[[
		Function that is called to perform style mutations to the floating element
   		to change its size.
	]]
	apply: (availableWidth: number, availableHeight: number) -> (),
}

export type Output = {}

--[[
	Provides data that allows you to change the size of the floating element —
	for instance, prevent it from overflowing the clipping boundary or match the
	width of the reference element.
]]
local function size(input: types.Derivable<Input>?): types.Middleware<Output>
	return {
		name = "size",
		run = function(state)
			local config = read(input or {}, state) :: Input
			local detectOverflowConfig = config.detectOverflowConfig or {}
			local apply = config.apply

			local side, alignment = getPlacementPosition(state.placement)
			local isVertical = side == "top" or side == "bottom"
			local width, height = state.rects.target.width, state.rects.target.height

			local widthSide, heightSide
			if side == "top" or side == "bottom" then
				widthSide = if alignment == (if state.rtl then "start" else "end") then "left" else "right"
				heightSide = side
			else
				widthSide = side
				heightSide = if alignment == "end" then "top" else "bottom"
			end

			local overflow = detectOverflow(state, detectOverflowConfig)
			local maximumClippingWidth = width - overflow.left - overflow.right
			local maximumClippingHeight = height - overflow.top - overflow.bottom

			local shift = state.data.shift
			local availableWidth = math.min(width - overflow[widthSide], maximumClippingWidth)
			local availableHeight = math.min(height - overflow[heightSide], maximumClippingHeight)

			if shift then
				if shift.enabled.x then
					availableWidth = maximumClippingWidth
				end

				if shift.enabled.y then
					availableHeight = maximumClippingHeight
				end
			elseif not alignment then
				if isVertical then
					local xMin = math.max(overflow.left, 0)
					local xMax = math.max(overflow.right, 0)

					availableWidth = width
						- 2
							* (if xMin ~= 0 or xMax ~= 0 then xMin + xMax else math.max(overflow.left, overflow.right))
				else
					local yMin = math.max(overflow.top, 0)
					local yMax = math.max(overflow.bottom, 0)

					availableHeight = height
						- 2
							* (if yMin ~= 0 or yMax ~= 0 then yMin + yMax else math.max(overflow.top, overflow.bottom))
				end
			end

			apply(availableWidth, availableHeight)

			return {}
		end,
	}
end

return size
