-- The equivalent of the offsetParent in Roblox is literally just the containing parent element of another.
-- However, this is mainly used in the case of a user having "special" instances that aren't technically
-- the parent of a gui element, such as a Folder.
local function getOffsetParent(element: GuiObject)
	return element:FindFirstAncestorWhichIsA("GuiObject")
end

return getOffsetParent
