local types = require(script.Parent.types)

local computePosition = require(script.Parent.computePosition)

local platform = require(script.Parent.platform)
local getElementRects = platform.getElementRects

export type ProcessConfig = {
	--[[
        Where to place the floating element relative to the reference element.
    ]]
	placement: types.Placement?,
	--[[
        The middleware used to modify the positioning or provide data for rendering.
    ]]
	middleware: { types.Middleware<any> }?,
	--[[
		If the position should be processed as right-to-left.
	]]
	rtl: boolean?,
}

export type ProcessConfigResult = types.Position & {
	--[[
        The final middleware data from the processing.
    ]]
	data: types.MiddlewareData,
	--[[
		The final chosen placement of the floating element.
	]]
	placement: types.Placement,
}

--[[
    Computes the coordinates that will determined the placement of the target
    element next to a given reference element.
]]
local function process(reference: types.ReferenceElement, target: GuiObject, config: ProcessConfig): ProcessConfigResult
	-- Stateful data
	local initialPlacement = config.placement or "bottom"
	local placement = initialPlacement
	local rtl = not not config.rtl
	local rects = getElementRects(reference, target)
	local x, y = computePosition(rects, placement, rtl)
	local data = {} :: types.MiddlewareData

	-- Middleware
	local middlewares = config.middleware or {}
	local length = #middlewares
	local index = 0

	debug.profilebegin("middleware")

	while index < length do
		index += 1

		local middleware = middlewares[index]
		local name = middleware.name

		debug.profilebegin(name)
		debug.setmemorycategory(name)

		local result = middleware.run({
			x = x,
			y = y,
			initialPlacement = initialPlacement,
			placement = placement,
			data = data,
			elements = { reference = reference, target = target },
			rects = rects,
			rtl = rtl,
		})

		if result == nil then
			-- Skipped
			continue
		end

		x = result.x or x
		y = result.y or y

		-- Store middleware data
		if result.data ~= nil then
			local stored = data[name]
			if stored == nil then
				data[name] = result.data
			else
				local merged = table.clone(stored)
				for key, value in result.data do
					merged[key] = value
				end

				data[name] = merged
			end
		end

		-- Check for resetting
		local reset = result.reset
		if reset then
			if typeof(reset) == "table" then
				if reset.placement then
					placement = reset.placement
				end

				if reset.rects then
					rects = if reset.rects == true then getElementRects(reference, target) else reset.rects
				end

				x, y = computePosition(rects, placement, rtl)
			end

			index = 0
		end

		debug.profileend()
	end

	debug.profileend()
	debug.resetmemorycategory()

	return {
		x = x,
		y = y,
		data = data,
		placement = placement,
	}
end

return process
