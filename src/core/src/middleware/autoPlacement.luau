local types = require(script.Parent.Parent.types)

local detectOverflow = require(script.Parent.Parent.detectOverflow)
type DetectOverflowConfig = detectOverflow.DetectOverflowConfig

local placement = require(script.Parent.Parent.utils.placement)
local getPlacementPosition = placement.getPlacementPosition
local getAlignmentSides = placement.getAlignmentSides
local getOppositeAlignmentPlacement = placement.getOppositeAlignmentPlacement

local read = require(script.Parent.Parent.utils.read)

-- List that contains all of the possible placements
-- Here because this is the only place it is used.
local ALL_PLACEMENTS = {}

for _, side in { "top", "bottom", "left", "right" } do
	table.insert(ALL_PLACEMENTS, side)
	table.insert(ALL_PLACEMENTS, `{side}-start`)
	table.insert(ALL_PLACEMENTS, `{side}-end`)
end

export type Input = {
	--[[
		Optional config used for `detectOverflow`.
	]]
	detectOverflowConfig: DetectOverflowConfig?,
	--[[
		The axis that runs along the alignment of the floating element. Determines
		whether to check for most space along this axis.
	]]
	crossAxis: boolean?,
	--[[
		Choose placements with a particular alignment.
	]]
	alignment: string?,
	--[[
		Whether to choose placements with the opposite alignment if the preferred
   		alignment does not fit.
	]]
	autoAlignment: boolean?,
	--[[
		Which placements are allowed to be chosen. Placements must be within the
   		`alignment` option if explicitly set.
	]]
	allowedPlacements: { types.Placement }?,
}

export type Output = {
	index: number,
	overflows: { types.Overflow },
}

local function getPlacementList(
	autoAlignment: boolean,
	allowedPlacements: { types.Placement },
	targetAlignment: string?
)
	local allowedPlacementsSortedByAlignment = {}

	for _, placement in allowedPlacements do
		local side, alignment = getPlacementPosition(placement)

		if targetAlignment then
			if
				alignment == targetAlignment
				or (if autoAlignment then getOppositeAlignmentPlacement(placement) ~= placement else false)
			then
				table.insert(allowedPlacementsSortedByAlignment, placement)
			end
		elseif side == placement then
			table.insert(allowedPlacementsSortedByAlignment, placement)
		end
	end

	return allowedPlacementsSortedByAlignment
end

local function getMostSpaciousPlacement(overflows: { types.Overflow }, crossAxis: boolean)
	local lowestPlacement: types.Placement
	local lowestSpace = math.huge

	for _, overflow in overflows do
		local _, alignment = getPlacementPosition(overflow.placement)
		local axisSum = overflow.values[1] + overflow.values[2]
		local targetValue = if alignment and crossAxis then axisSum else overflow.values[1]

		if targetValue < lowestSpace then
			lowestPlacement = overflow.placement
			lowestSpace = targetValue
		end
	end

	return lowestPlacement
end

--[[
	Optimizes the visibility of the floating element by choosing the placement
	that has the most space available automatically, without needing to specify a
	preferred placement. Alternative to `flip`.
]]
local function autoPlacement(input: types.Derivable<Input>): types.Middleware<Output>
	return {
		name = "autoPlacement",
		run = function(state)
			local config = read(input) :: Input

			local crossAxis = not not config.crossAxis
			local alignment = config.alignment
			local autoAlignment = if config.autoAlignment ~= nil then config.autoAlignment else true
			local allowedPlacements = config.allowedPlacements or ALL_PLACEMENTS
			local detectOverflowConfig = config.detectOverflowConfig or {}

			local placement = state.placement
			local placements = if alignment ~= nil or allowedPlacements == ALL_PLACEMENTS
				then getPlacementList(autoAlignment, allowedPlacements, alignment)
				else allowedPlacements

			local autoPlacementData = state.data.autoPlacement
			local currentIndex = if autoPlacementData then autoPlacementData.index else 1
			local currentPlacement = placements[currentIndex]

			if currentPlacement == nil then
				return nil
			end

			if placement ~= currentPlacement then
				return {
					reset = {
						placement = placements[1],
					},
				}
			end

			local overflow = detectOverflow(state, detectOverflowConfig)
			local currentOverflows: { number }
			do
				local sideA, sideB = getAlignmentSides(currentPlacement, state.rects, state.rtl)
				currentOverflows = {
					overflow[getPlacementPosition(currentPlacement)],
					overflow[sideA],
					overflow[sideB],
				}
			end

			local cachedOverflows = if autoPlacementData then autoPlacementData.overflows else {}
			table.insert(cachedOverflows, {
				placement = currentPlacement,
				values = currentOverflows,
			})

			local nextIndex = currentIndex + 1
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

			local resetPlacement = getMostSpaciousPlacement(cachedOverflows, crossAxis)
			if resetPlacement ~= placement then
				return {
					data = {
						index = nextIndex,
						overflows = cachedOverflows,
					},
					reset = {
						placement = resetPlacement,
					},
				}
			end

			return nil
		end,
	}
end

return autoPlacement
