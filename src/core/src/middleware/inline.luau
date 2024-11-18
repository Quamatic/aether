local types = require(script.Parent.Parent.types)

local rects = require(script.Parent.Parent.utils.rects)
local convertRectToBoundingRect = rects.convertRectToBoundingRect
local isSameRect = rects.isSameRect

local placement = require(script.Parent.Parent.utils.placement)
local getPlacementPosition = placement.getPlacementPosition

local platform = require(script.Parent.Parent.platform)
local getElementRects = platform.getElementRects

local getPaddingObject = require(script.Parent.Parent.utils.getPaddingObject)
local read = require(script.Parent.Parent.utils.read)

export type Input = {
	x: number?,
	y: number?,
	--[[
		Represents the padding around a disjoined rect when choosing it.
	]]
	padding: types.Padding?,
}

export type Output = {}

local function sortRectsByHeight(a: types.BoundingRect, b: types.BoundingRect)
	return a.y < b.y
end

local function max(rects: { types.BoundingRect }, side: string)
	local highest = 0

	for _, rect in rects do
		if rect[side] > highest then
			highest = rect[side]
		end
	end

	return highest
end

local function min(rects: { types.BoundingRect }, side: string)
	local lowest = math.huge

	for _, rect in rects do
		if rect[side] < lowest then
			lowest = rect[side]
		end
	end

	return lowest
end

local function getRectFromBoundingRects(rects: { types.BoundingRect }): types.Rect
	local minX = min(rects, "left")
	local minY = min(rects, "top")
	local maxX = max(rects, "right")
	local maxY = max(rects, "bottom")

	return {
		x = minX,
		y = minY,
		width = maxX - minX,
		height = maxY - minY,
	}
end

local function getRectsByLine(rects: { types.BoundingRect })
	local sortedRects = table.clone(rects)
	table.sort(sortedRects, sortRectsByHeight)

	local groups = {}
	local length = 0
	local currentGroup: { types.BoundingRect }

	for index, rect in sortedRects do
		local previousRect = sortedRects[index - 1]
		if not previousRect or rect.y - previousRect.y > previousRect.height / 2 then
			currentGroup = { rect }
			table.insert(groups, currentGroup)
			length += 1
		else
			table.insert(currentGroup, rect)
		end
	end

	local mapped = table.create(length)
	for index, rects in groups do
		mapped[index] = convertRectToBoundingRect(getRectFromBoundingRects(rects))
	end

	return mapped
end

local function isPointFullyInside(x: number, y: number, rect: types.BoundingRect, padding: types.SideObject)
	return x > rect.left - padding.left
		and x < rect.right + padding.right
		and y > rect.top - padding.top
		and y < rect.bottom + padding.bottom
end

--[[
	Provides improved positioning for inline reference elements that can span
	over multiple lines, such as range selections.
]]
local function inline(input: types.Derivable<Input>): types.Middleware<Output>
	return {
		name = "inline",
		run = function(state)
			local config = read(input, state) :: Input

			local x = config.x
			local y = config.y
			local padding = getPaddingObject(config.padding or 0)

			local nativeRects = {}
			local boundingRects = getRectsByLine(nativeRects)
			local fallback = convertRectToBoundingRect(getRectFromBoundingRects(nativeRects))

			local function getBoundingRect()
				local length = #boundingRects
				if length == 2 and boundingRects[1].left > boundingRects[2].right and x ~= nil and y ~= nil then
					local first = boundingRects[1]
					local second = boundingRects[2]

					if isPointFullyInside(x, y, first, padding) then
						return first
					elseif isPointFullyInside(x, y, second, padding) then
						return second
					else
						return fallback
					end
				elseif length >= 2 then
					local side = getPlacementPosition(state.placement)
					if side == "top" or side == "bottom" then
						local firstRect = boundingRects[1]
						local lastRect = boundingRects[#boundingRects]
						local isTop = side == "top"

						local top = firstRect.top
						local bottom = lastRect.bottom
						local left = if isTop then firstRect.left else lastRect.left
						local right = if isTop then firstRect.right else lastRect.right
						local width = right - left
						local height = bottom - top

						return {
							top = top,
							bottom = bottom,
							left = left,
							right = right,
							width = width,
							height = height,
							x = top,
							y = bottom,
						}
					end

					local isLeftSide = side == "left"
					local maxRight = max(boundingRects, "right")
					local minLeft = min(boundingRects, "left")
					local measureRects = {}

					for _, rect in boundingRects do
						if (isLeftSide and rect.left == minLeft) or rect.right == maxRight then
							table.insert(measureRects, rect)
						end
					end

					local top = measureRects[1].top
					local bottom = measureRects[#measureRects].bottom
					local left = minLeft
					local right = maxRight
					local width = right - left
					local height = bottom - top

					return {
						top = top,
						bottom = bottom,
						left = left,
						right = right,
						width = width,
						height = height,
						x = left,
						y = top,
					}
				else
					return fallback
				end
			end

			local resetRects = getElementRects({
				getBoundingRect = getBoundingRect,
			}, state.elements.target)

			if not isSameRect(state.rects.reference, resetRects.reference) then
				return {
					reset = {
						rects = resetRects,
					},
				}
			end

			return nil
		end,
	}
end

return inline
