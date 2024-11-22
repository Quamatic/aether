local types = require(script.Parent.Parent.types)

type Side = types.Side
type Alignment = types.Alignment
type Axis = types.Axis
type Placement = types.Placement

--[[
	Returns the {@link Side | side} and {@link Alignment | alignment} of the given placement.

	Note that the alignment will only exist when the placement actually has an alignment value, such as `"top-start"`.
]]
local function getPlacementPosition(placement: Placement)
	local segments = string.split(placement, "-")

	local side = segments[1]
	local alignment = segments[2]

	return side, alignment :: string?
end

--[[
	Returns the axis equivalents of the side and alignment for the given placement.
]]
local function getPlacementAxes(placement: Placement): (Axis, Axis)
	local side, _ = getPlacementPosition(placement)

	local mainAxis: Axis = if side == "top" or side == "bottom" then "y" else "x"
	local crossAxis: Axis = if mainAxis == "x" then "y" else "x"

	return mainAxis, crossAxis
end

local OPPOSITE_SIDE_MAP = {
	top = "bottom",
	bottom = "top",
	left = "right",
	right = "left",
}

local OPPOSITE_ALIGNMENT_MAP = {
	start = "end",
	["end"] = "start",
}

local function oppsiteSideSubstitution(side: string, rest: string)
	return OPPOSITE_SIDE_MAP[side] .. if rest ~= "" then `-{rest}` else rest
end

local function oppositeAlignmentSubstitution(side: string, alignment: string)
	return side .. if alignment ~= "" then `-{OPPOSITE_ALIGNMENT_MAP[alignment]}` else alignment
end

--[[
	Returns the opposite _side_ part of the given placement.

	For example, if the placement is `"top-start"`, then the opposite placement would be `"bottom-start"`.
	Present alignments stay the same.
]]
local function getOppositePlacement(placement: Placement): Placement
	local result = string.gsub(placement, "^([^-]*)-?(.*)$", oppsiteSideSubstitution :: never)
	return result :: Placement
end

--[[
	Returns the opposite _alignment_ part of the given placement.

	For example, if the placement is `"top-start"`, then the opposite placement would be `"top-end"`.
	The side always stays the same.
]]
local function getOppositeAlignmentPlacement(placement: Placement): Placement
	local result = string.gsub(placement, "(.-)-(.*)", oppositeAlignmentSubstitution :: never)
	return result :: Placement
end

--[[
	Returns all possible alternative values for a given placement, excluding the initial placement itself.
]]
local function getExpandedPlacements(placement: types.Placement): { Placement }
	local oppositePlacement: Placement = getOppositePlacement(placement)

	return {
		getOppositeAlignmentPlacement(placement),
		oppositePlacement,
		getOppositeAlignmentPlacement(oppositePlacement),
	}
end

local function getSideList(side: string, isStart: boolean, rtl: boolean?): { Side }
	if side == "top" or side == "bottom" then
		local lr: { Side } = { "left", "right" }
		local rl: { Side } = { "right", "left" }

		return if rtl then if isStart then rl else lr else if isStart then lr else rl
	else
		local tb: { Side } = { "top", "bottom" }
		local bt: { Side } = { "bottom", "top" }

		return if isStart then tb else bt
	end
end

--[[
	Returns all of the possible placements from the opposite axis of a given placement.
]]
local function getOppositeAxisPlacements(
	placement: Placement,
	flipAlignment: boolean,
	direction: Alignment | "none",
	rtl: boolean?
): { Placement }
	local initialSide, alignment = getPlacementPosition(placement)
	local list = getSideList(initialSide, direction == "start", rtl)

	if alignment then
		-- size = 2 with alignment mapping, with an extra 2 if flipAlignment is enabled.
		local listWithAlignments: { Placement } = table.create(2 + if flipAlignment then 2 else 0)

		for index, side in list do
			local fullPlacement = `{side}-{alignment}`
			listWithAlignments[index] = fullPlacement :: Placement

			if flipAlignment then
				-- index 1 = 3, index 2 = 4
				listWithAlignments[index + 2] = getOppositeAlignmentPlacement(fullPlacement :: Placement)
			end
		end

		return listWithAlignments
	end

	return list
end

--[[
	Returns the two possible sides of a given placement, listed in order as the main side followed by the cross (opposite) side.
]]
local function getAlignmentSides(placement: Placement, rects: types.ElementRects, rtl: boolean?): (Side, Side)
	local side, alignment = getPlacementPosition(placement)
	local alignmentAxis = if side == "top" or side == "bottom" then "x" else "y" -- opposite axis
	local dimension = if alignmentAxis == "x" then "width" else "height"

	local mainAlignmentSide: Placement = if alignmentAxis == "x"
		then if alignment == (if rtl then "end" else "start") then "right" else "left"
		else if alignment == "start" then "bottom" else "top"

	if rects.reference[dimension] > rects.target[dimension] then
		mainAlignmentSide = getOppositePlacement(mainAlignmentSide)
	end

	return mainAlignmentSide :: Side, getOppositePlacement(mainAlignmentSide) :: Side
end

return {
	getPlacementPosition = getPlacementPosition,
	getPlacementAxes = getPlacementAxes,
	getOppositePlacement = getOppositePlacement,
	getOppositeAlignmentPlacement = getOppositeAlignmentPlacement,
	getExpandedPlacements = getExpandedPlacements,
	getOppositeAxisPlacements = getOppositeAxisPlacements,
	getAlignmentSides = getAlignmentSides,
}
