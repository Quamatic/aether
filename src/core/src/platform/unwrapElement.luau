local types = require(script.Parent.Parent.types)

local function unwrapElement(element: types.ReferenceElement)
	return if typeof(element) == "Instance" then element else element.contextElement
end

return unwrapElement
