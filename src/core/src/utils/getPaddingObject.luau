local types = require(script.Parent.Parent.types)

local function getPaddingObject(padding: types.Padding): types.SideObject
	return if typeof(padding) == "number"
		then {
			top = padding,
			bottom = padding,
			left = padding,
			right = padding,
		}
		else {
			top = padding.top or 0,
			bottom = padding.bottom or 0,
			left = padding.left or 0,
			right = padding.right or 0,
		}
end

return getPaddingObject
