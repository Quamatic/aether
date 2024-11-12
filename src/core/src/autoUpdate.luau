local RunService = game:GetService("RunService")

local types = require(script.Parent.types)

local platform = require(script.Parent.platform)
local getElementBoundingRect = platform.getElementBoundingRect
local unwrapElement = platform.unwrapElement

local rects = require(script.Parent.utils.rects)
local areRectsEqual = rects.areRectsEqual

type AutoUpdateEvent = "elements" | "render"

--[[
	Automatically updates the position of the floating element when necessary.
	Should only be called when the floating element is mounted or visible on the screen.
]]
local function autoUpdate(
	reference: types.ReferenceElement,
	target: GuiObject,
	update: () -> (),
	event: AutoUpdateEvent?
)
	local eventType: AutoUpdateEvent = event or "elements"

	update()

	if eventType == "elements" then
		local connections = {
			target:GetPropertyChangedSignal("AbsoluteSize"):Connect(update),
		}

		local referenceEl = unwrapElement(reference)
		if referenceEl then
			table.insert(connections, referenceEl:GetPropertyChangedSignal("AbsoluteSize"):Connect(update))
			table.insert(connections, referenceEl:GetPropertyChangedSignal("AbsolutePosition"):Connect(update))
		end

		return function()
			for _, connection in connections do
				connection:Disconnect()
			end
		end
	else
		local previousReferenceRect = getElementBoundingRect(reference)

		local connection = RunService.PreRender:Connect(function()
			local currentReferenceRect = getElementBoundingRect(reference)
			if not areRectsEqual(previousReferenceRect, currentReferenceRect) then
				update()
			end

			previousReferenceRect = currentReferenceRect
		end)

		return function()
			connection:Disconnect()
		end
	end
end

return autoUpdate
