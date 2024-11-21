local types = require(script.Parent.Parent.types)

type Side = types.Side
type Axis = types.Axis
type Placement = types.Placement

local function getPlacementPosition(placement: types.Placement)
	local segments = string.split(placement, "-")

	local side = segments[1]
	local alignment = segments[2]

	return side, alignment :: string?
end

local function getPlacementAxes(placement: types.Placement): (Axis, Axis)
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

local function getOppositePlacement(placement: types.Placement): Placement
	local result = string.gsub(placement, "^([^-]*)-?(.*)$", oppsiteSideSubstitution :: never)
	return result :: Placement
end

local function getOppositeAlignmentPlacement(placement: types.Placement): Placement
	local result = string.gsub(placement, "(.-)-(.*)", oppositeAlignmentSubstitution :: never)
	return result :: Placement
end

local function getExpandedPlacements(placement: types.Placement): { Placement }
	local oppositePlacement: Placement = getOppositePlacement(placement)

	return {
		getOppositeAlignmentPlacement(placement),
		oppositePlacement,
		getOppositeAlignmentPlacement(oppositePlacement),
	}
end

local function getSideList(side: string, isStart: boolean, rtl: boolean?): { Side }
	local lr: { Side } = { "left", "right" }
	local rl: { Side } = { "right", "left" }
	local tb: { Side } = { "top", "bottom" }
	local bt: { Side } = { "bottom", "top" }

	if side == "top" or side == "bottom" then
		return if rtl then if isStart then rl else lr else if isStart then lr else rl
	else
		return if isStart then tb else bt
	end
end

local function getOppositeAxisPlacements(
	placement: types.Placement,
	flipAlignment: boolean,
	direction: types.Alignment | "none",
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
