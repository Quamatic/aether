local types = require(script.Parent.types)

local platform = require(script.Parent.platform)
local unwrapElement = platform.unwrapElement

--[[
	Automatically updates the position of the floating element when necessary.
	Should only be called when the floating element is mounted or visible on the screen.
]]
local function autoUpdate(reference: types.ReferenceElement, target: GuiObject, update: () -> ())
	local connections = {
		target:GetPropertyChangedSignal("AbsoluteSize"):Connect(update),
	}

	local referenceEl = unwrapElement(reference)
	if referenceEl then
		table.insert(connections, referenceEl:GetPropertyChangedSignal("AbsoluteSize"):Connect(update))
		table.insert(connections, referenceEl:GetPropertyChangedSignal("AbsolutePosition"):Connect(update))
	end

	update()

	return function()
		for _, connection in connections do
			connection:Disconnect()
		end
	end
end

return autoUpdate
