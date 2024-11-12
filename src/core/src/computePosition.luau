local types = require(script.Parent.types)

local placement = require(script.Parent.utils.placement)
local getPlacementPosition = placement.getPlacementPosition

local function computePosition(rects: types.ElementRects, placement: types.Placement, rtl: boolean)
	local reference = rects.reference
	local target = rects.target

	local side, alignment = getPlacementPosition(placement)
	local commonX = reference.x + reference.width / 2 - target.width / 2
	local commonY = reference.y + reference.height / 2 - target.height / 2

	local x: number, y: number
	if side == "top" then
		x = commonX
		y = reference.y - target.height
	elseif side == "bottom" then
		x = commonX
		y = reference.y + reference.height
	elseif side == "left" then
		x = reference.x - target.width
		y = commonY
	else
		x = reference.x + reference.width
		y = commonY
	end

	if alignment then
		local isVertical = side == "top" or side == "bottom"
		local length = if isVertical then "width" else "height"
		local value = (reference[length] / 2 - target[length] / 2)
			* (if alignment == "start" then -1 else 1)
			* (if rtl and isVertical then -1 else 1)

		if isVertical then
			x += value
		else
			y += value
		end
	end

	return x, y
end

return computePosition
