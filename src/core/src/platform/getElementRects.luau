local types = require(script.Parent.Parent.types)

local getOffsetParent = require(script.Parent.getOffsetParent)
local getRectRelativeToOffsetParent = require(script.Parent.getRectRelativeToOffsetParent)

--[[
	Returns the rects of the reference and target element.
 
	Two things to note:

	- The reference element is relative to the target elements offset parent.
	- The target elements `x` and `y` values are always `0`, but contains the actual `width` and `height`.
]]
local function getElementRects(
	reference: types.ReferenceElement,
	target: GuiObject,
	cache: types.Cache
): types.ElementRects
	local targetOffsetParent = getOffsetParent(target)

	return {
		reference = getRectRelativeToOffsetParent(reference, targetOffsetParent, cache),
		target = {
			x = 0,
			y = 0,
			-- ^ position is authoritated
			width = target.AbsoluteSize.X,
			height = target.AbsoluteSize.Y,
		},
	}
end

return getElementRects
