local types = require(script.Parent.Parent.types)

local detectOverflow = require(script.Parent.Parent.detectOverflow)
type DetectOverflowConfig = detectOverflow.DetectOverflowConfig

local placement = require(script.Parent.Parent.utils.placement)
local getPlacementAxes = placement.getPlacementAxes

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
			local config = read(input) :: Input

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

return shift
