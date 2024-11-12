local types = require(script.Parent.Parent.types)

local getOffsetParent = require(script.Parent.getOffsetParent)
local getRectRelativeToOffsetParent = require(script.Parent.getRectRelativeToOffsetParent)

local function getElementRects(reference: types.ReferenceElement, target: GuiObject): types.ElementRects
	local targetOffsetParent = getOffsetParent(target)

	return {
		reference = getRectRelativeToOffsetParent(reference, targetOffsetParent),
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
