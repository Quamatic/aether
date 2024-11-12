local types = require(script.Parent.Parent.types)

local placement = require(script.Parent.Parent.utils.placement)
local getPlacementPosition = placement.getPlacementPosition
local getPlacementAxes = placement.getPlacementAxes

local read = require(script.Parent.Parent.utils.read)

export type Input = {
	--[[
		Offset when limiting starts. `0` will limit when the opposite edges of the
   		reference and floating elements are aligned.
	]]
	offset: number | {
		--[[
			Offset the limiting of the axis that runs along the alignment of the
			floating element.
		]]
		mainAxis: number?,
		--[[
			Offset the limiting of the axis that runs along the side of the
       		floating element.
		]]
		crossAxis: number?,
	}?,
	--[[
		Whether to limit the axis that runs along the alignment of the floating
		element.
	]]
	mainAxis: boolean?,
	--[[
		Whether to limit the axis that runs along the side of the floating element.
	]]
	crossAxis: boolean?,
}

export type Output = {}

--[[
    Built-in `limiter` that will stop `shift()` at a certain point.
]]
local function limitShift(input: types.Derivable<Input>): types.Middleware<Output>
	return {
		name = "offset",
		run = function(state)
			local config = read(input) :: Input

			local offset = config.offset or 0
			local checkMainAxis = if config.mainAxis ~= nil then config.mainAxis else true
			local checkCrossAxis = if config.crossAxis ~= nil then config.crossAxis else true

			local rects = state.rects
			local crossAxis, mainAxis = getPlacementAxes(state.placement)
			local position: types.Position = { x = state.x, y = state.y }
			local mainAxisValue = position[mainAxis]
			local crossAxisValue = position[crossAxis]

			local mainAxisOffset: number, crossAxisOffset: number
			if typeof(offset) == "number" then
				mainAxisOffset, crossAxisOffset = offset, 0
			else
				mainAxisOffset, crossAxisOffset = offset.mainAxis or 0, offset.crossAxis or 0
			end

			if checkMainAxis then
				local dimension = if mainAxis == "x" then "width" else "height"
				local min = rects.reference[mainAxis] - rects.target[dimension] + mainAxisOffset
				local max = rects.reference[mainAxis] + rects.reference[dimension] - mainAxisOffset

				mainAxisValue = math.clamp(mainAxisValue, min, max)
			end

			if checkCrossAxis then
				local dimension = if crossAxis == "x" then "height" else "width"
				local side = getPlacementPosition(state.placement)
				local isOriginSide = side == "top" or side == "left"
				local crossOffset: number = if state.data.offset then state.data.offset[crossAxis] else 0

				local min = rects.reference[crossAxis]
					- rects.target[dimension]
					+ (if isOriginSide then crossOffset else 0)
					- (if isOriginSide then 0 else crossAxisOffset)

				local max = rects.reference[mainAxis]
					+ rects.reference[dimension]
					+ (if isOriginSide then 0 else crossOffset)
					- (if isOriginSide then crossAxisOffset else 0)

				crossAxisValue = math.clamp(mainAxisValue, min, max)
			end

			return {
				[mainAxis] = mainAxisValue,
				[crossAxis] = crossAxisValue,
			}
		end,
	}
end

return limitShift
