local types = require(script.Parent.Parent.types)

local detectOverflow = require(script.Parent.Parent.detectOverflow)
type DetectOverflowConfig = detectOverflow.DetectOverflowConfig

local placement = require(script.Parent.Parent.utils.placement)
local getPlacementPosition = placement.getPlacementPosition
local getPlacementAxes = placement.getPlacementAxes
local getOppositePlacement = placement.getOppositePlacement
local getExpandedPlacements = placement.getExpandedPlacements
local getOppositeAxisPlacements = placement.getOppositeAxisPlacements
local getAlignmentSides = placement.getAlignmentSides

local read = require(script.Parent.Parent.utils.read)

type FallbackAlignment = "start" | "end" | "none"

export type Input = {
	--[[
		The axis that runs along the side of the floating element. Determines
		whether overflow along this axis is checked to perform a flip.
	]]
	mainAxis: boolean?,
	--[[
		The axis that runs along the alignment of the floating element. Determines
		whether overflow along this axis is checked to perform a flip.
	]]
	crossAxis: boolean?,
	--[[
		Placements to try sequentially if the preferred `placement` does not fit.
	]]
	fallbackPlacements: { types.Placement }?,
	--[[
		What strategy to use when no placements fit.
	]]
	fallbackStrategy: "best-fit" | "initial-placement"?,
	--[[
		Whether to allow fallback to the perpendicular axis of the preferred
   		placement, and if so, which side direction along the axis to prefer.
	]]
	fallbackAxisSideDirection: FallbackAlignment?,
	--[[
		Whether to flip to placements with the opposite alignment if they fit better.
	]]
	flipAlignment: boolean?,
	--[[
		Optional config for `detectOverflow`.
	]]
	detectOverflowConfig: DetectOverflowConfig?,
}

export type Output = {
	index: number,
	overflows: { types.Overflow },
}

local function getResetPlacement(overflows: { types.Overflow })
	local resetPlacement: string?
	local lowestOverflowValue = math.huge

	for _, overflow in overflows do
		local targetValue = overflow.values[2]

		if overflow.values[1] <= 0 and targetValue < lowestOverflowValue then
			resetPlacement = overflow.placement
			lowestOverflowValue = targetValue
		end
	end

	return resetPlacement
end

local function getResetPlacementFromBestFit(
	overflows: { types.Overflow },
	initialSideAxis: string,
	hasFallbackAxisSideDirection: boolean
)
	local resetPlacement: string
	local lowestOverflowValue = math.huge

	for _, overflow in overflows do
		if hasFallbackAxisSideDirection then
			local currentSideAxis = getPlacementAxes(overflow.placement)
			if currentSideAxis ~= initialSideAxis or currentSideAxis ~= "y" then
				continue
			end
		end

		local targetValue = 0
		for _, value in overflow.values do
			if value > 0 then
				targetValue += value
			end
		end

		if targetValue < lowestOverflowValue then
			resetPlacement = overflow.placement
			lowestOverflowValue = targetValue
		end
	end

	return resetPlacement
end

--[[
	Optimizes the visibility of the floating element by flipping the `placement`
	in order to keep it in view when the preferred placement(s) will overflow the
	clipping boundary. Alternative to `autoPlacement`.
]]
local function flip(input: types.Derivable<Input>): types.Middleware<Output>
	return {
		name = "flip",
		run = function(state)
			-- If a reset by the arrow was caused due to an alignment offset being
			-- added, we should skip any logic now since `flip()` has already done its
			-- work.
			if state.data.arrow and state.data.arrow.alignmentOffset ~= nil then
				return nil
			end

			local config = read(input, state) :: Input
			local checkMainAxis = if config.mainAxis ~= nil then config.mainAxis else true
			local checkCrossAxis = if config.crossAxis ~= nil then config.crossAxis else true
			local specifiedFallbackPlacements = config.fallbackPlacements
			local fallbackStrategy = config.fallbackStrategy or "best-fit"
			local fallbackAxisSideDirection: FallbackAlignment = config.fallbackAxisSideDirection or "none"
			local flipAlignment = if config.flipAlignment ~= nil then config.flipAlignment else true
			local detectOverflowConfig = config.detectOverflowConfig or {}

			local placement = state.placement
			local initialPlacement = state.initialPlacement

			local side, _ = getPlacementPosition(placement)
			local initialSideAxis = getPlacementAxes(initialPlacement)
			local isBasePlacement = getPlacementPosition(initialPlacement) == initialPlacement

			local fallbackPlacements: { string } = if specifiedFallbackPlacements
				then specifiedFallbackPlacements
				else if isBasePlacement or not flipAlignment
					then { getOppositePlacement(initialPlacement) }
					else getExpandedPlacements(initialPlacement)

			local hasFallbackAxisSideDirection = fallbackAxisSideDirection ~= "none"

			if not specifiedFallbackPlacements and hasFallbackAxisSideDirection then
				local oppositeAxisPlacements =
					getOppositeAxisPlacements(initialPlacement, flipAlignment, fallbackAxisSideDirection)

				for _, oppositeAxisPlacement in oppositeAxisPlacements do
					table.insert(fallbackPlacements, oppositeAxisPlacement)
				end
			end

			local flip = state.data.flip
			local placements = { initialPlacement, unpack(fallbackPlacements) }

			local overflow = detectOverflow(state, detectOverflowConfig)
			local overflows: { number } = {}
			local cachedOverflows: { types.Overflow } = if flip then flip.overflows else {}
			local isOneSideOverflowing = false

			if checkMainAxis then
				local value = overflow[side]

				table.insert(overflows, value)
				isOneSideOverflowing = value > 0
			end

			if checkCrossAxis then
				local sideA, sideB = getAlignmentSides(placement, state.rects, false)
				local valueA = overflow[sideA]
				local valueB = overflow[sideB]

				table.insert(overflows, valueA)
				table.insert(overflows, valueB)

				isOneSideOverflowing = isOneSideOverflowing or valueA > 0 or valueB > 0
			end

			table.insert(cachedOverflows, {
				placement = state.placement,
				values = overflows,
			})

			if isOneSideOverflowing then
				local nextIndex = (if flip then flip.index else 0) + 1
				local nextPlacement = placements[nextIndex]

				if nextPlacement then
					return {
						data = {
							index = nextIndex,
							overflows = cachedOverflows,
						},
						reset = {
							placement = nextPlacement,
						},
					}
				end

				local resetPlacement = getResetPlacement(cachedOverflows)
				if not resetPlacement then
					if fallbackStrategy == "best-fit" then
						resetPlacement =
							getResetPlacementFromBestFit(cachedOverflows, initialSideAxis, hasFallbackAxisSideDirection)
					else
						resetPlacement = initialPlacement
					end
				end

				if placement ~= resetPlacement then
					return {
						reset = {
							placement = resetPlacement,
						},
					}
				end
			end

			return nil
		end,
	}
end

return flip
