local types = require(script.Parent.Parent.types)

local detectOverflow = require(script.Parent.Parent.detectOverflow)
type DetectOverflowConfig = detectOverflow.DetectOverflowConfig

local placement = require(script.Parent.Parent.utils.placement)
local getPlacementAxes = placement.getPlacementAxes
local getPlacementPosition = placement.getPlacementPosition

local read = require(script.Parent.Parent.utils.read)

type LimiterFn = (state: types.MiddlewareState) -> types.Position

export type Input = {
	--[[
		Optional config for `detectOverflow`.
	]]
	detectOverflowConfig: DetectOverflowConfig?,
	--[[
		The axis that runs along the alignment of the floating element. Determines
		whether overflow along this axis is checked to perform shifting.
	]]
	mainAxis: boolean?,
	--[[
		The axis that runs along the side of the floating element. Determines
		whether overflow along this axis is checked to perform shifting.
	]]
	crossAxis: boolean?,
	--[[
		Accepts a function that limits the shifting done in order to prevent
		detachment.
	]]
	limiter: LimiterFn?,
}

export type Output = types.Position & {
	enabled: {
		x: boolean,
		y: boolean,
	},
}

local defaultLimiterFn: LimiterFn = function(state)
	return {
		x = state.x,
		y = state.y,
	}
end

--[[
    Optimizes the visibility of the floating element by shifting it in order to
	keep it in view when it will overflow the clipping boundary.
]]
local function shift(input: types.Derivable<Input>): types.Middleware<Output>
	return {
		name = "offset",
		run = function(state)
			local config = read(input, state) :: Input

			local detectOverflowConfig = config.detectOverflowConfig or {}
			local checkMainAxis = if config.mainAxis ~= nil then config.mainAxis else true
			local checkCrossAxis = if config.crossAxis ~= nil then config.crossAxis else false
			local limiter = config.limiter or defaultLimiterFn

			local position: types.Position = { x = state.x, y = state.y }
			local mainAxis, crossAxis = getPlacementAxes(state.placement)

			local overflow = detectOverflow(state, detectOverflowConfig)
			local mainAxisValue = position[mainAxis]
			local crossAxisValue = position[crossAxis]

			if checkMainAxis then
				local minSide = if mainAxis == "y" then "top" else "left"
				local maxSide = if mainAxis == "y" then "bottom" else "right"

				mainAxisValue = math.max(
					mainAxisValue + overflow[minSide],
					math.min(mainAxisValue, mainAxisValue - overflow[maxSide])
				)
			end

			if checkCrossAxis then
				local minSide = if crossAxis == "y" then "top" else "left"
				local maxSide = if crossAxis == "y" then "bottom" else "right"

				crossAxisValue = math.max(
					crossAxisValue + overflow[minSide],
					math.min(crossAxisValue, crossAxisValue - overflow[maxSide])
				)
			end

			-- dont really want to clone here but it's fine.
			local cloned = table.clone(state) :: types.MiddlewareState
			cloned[mainAxis] = mainAxisValue
			cloned[crossAxis] = crossAxisValue

			local limitedPosition = limiter(cloned)

			return {
				x = limitedPosition.x,
				y = limitedPosition.y,
				data = {
					x = limitedPosition.x - state.x,
					y = limitedPosition.y - state.y,
					enabled = {
						[mainAxis] = checkMainAxis,
						[crossAxis] = checkCrossAxis,
					},
				},
			}
		end,
	}
end

type LimitShiftInput = {
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

--[[
    Built-in `limiter` that will stop `shift()` at a certain point.
]]
local function limitShift(input: types.Derivable<LimitShiftInput>)
	return function(state)
		local config = read(input, state) :: LimitShiftInput

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
	end
end

return {
	shift = shift,
	limitShift = limitShift,
}
