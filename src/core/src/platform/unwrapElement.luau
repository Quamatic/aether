local types = require(script.Parent.Parent.types)

--[[
	Attempts to unwrap an element into its `GuiObject` form, if one exists.
 
	If the given element is virtual and has a `contextElement` value then that is what is returned.
]]
local function unwrapElement(element: types.ReferenceElement)
	return if typeof(element) == "Instance" then element else element.contextElement
end

return unwrapElement
