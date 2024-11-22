--[[
	Returns the "offset" parent of the given element.
 
	The "offset" parent is the first valid parent of the given element. Most of the time,
	this is just the `Parent` value, but there are cases where a `Folder` instance may be used.
	Because of that, this is useful for being safe.
]]
local function getOffsetParent(element: GuiObject)
	return element:FindFirstAncestorWhichIsA("GuiObject")
end

return getOffsetParent
