local types = require(script.Parent.Parent.types)

local placement = require(script.Parent.Parent.utils.placement)
local getPlacementPosition = placement.getPlacementPosition

local read = require(script.Parent.Parent.utils.read)

export type Input = number | {
	--[[
		The axis that runs along the side of the floating element. Represents
		the distance (gutter or margin) between the reference and floating
		element.
	]]
	mainAxis: number?,
	--[[
		The axis that runs along the alignment of the floating element.
		Represents the skidding between the reference and floating element.
	]]
	crossAxis: number?,
	--[[
		The same axis as `crossAxis` but applies only to aligned placements
		and inverts the `end` alignment. When set to a number, it overrides the
		`crossAxis` value.
		
		A positive number will move the floating element in the direction of
		the opposite edge to the one that is aligned, while a negative number
		the reverse.
	]]
	alignmentAxis: number?,
}

export type Output = types.Position & {
	placement: types.Placement,
}

--[[
    Modifies the placement by translating the floating element along the specified axes.
]]
local function offset(input: types.Derivable<Input>): types.Middleware<Output>
	return {
		name = "offset",
		run = function(state)
			local config = read(input, state) :: Input

			local placement = state.placement

			-- If the placement is the same and the arrow caused an alignment offset
			-- then we don't need to change the positioning coordinates.
			local data = state.data
			if
				data.offset
				and data.arrow
				and placement == data.offset.placement
				and data.arrow.alignmentOffset ~= nil
			then
				return nil
			end

			local side, alignment = getPlacementPosition(placement)
			local isVertical = side == "top" or side == "bottom"
			local rtl = false
			local mainAxisMultiplier = if side == "left" or side == "top" then -1 else 1
			local crossAxisMultiplier = if rtl and isVertical then -1 else 1

			local mainAxis: number, crossAxis: number, alignmentAxis: number?
			if typeof(config) == "number" then
				mainAxis = config
				crossAxis = 0
				alignmentAxis = nil
			else
				mainAxis = config.mainAxis or 0
				crossAxis = config.crossAxis or 0
				alignmentAxis = config.alignmentAxis
			end

			if alignment and alignmentAxis then
				crossAxis = if alignment == "end" then alignmentAxis * -1 else alignmentAxis
			end

			local x: number, y: number
			if isVertical then
				x, y = crossAxis * crossAxisMultiplier, mainAxis * mainAxisMultiplier
			else
				x, y = mainAxis * mainAxisMultiplier, crossAxis * crossAxisMultiplier
			end

			return {
				x = state.x + x,
				y = state.y + y,
				data = {
					x = x,
					y = y,
					placement = placement,
				},
			}
		end,
	}
end

return offset
