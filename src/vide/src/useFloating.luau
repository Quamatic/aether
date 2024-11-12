local aether = require(script.Parent.Parent.Aether)
local vide = require(script.Parent.Parent.vide)

local source = vide.source
local effect = vide.effect
local cleanup = vide.cleanup
local read = vide.read
local derive = vide.derive
local batch = vide.batch

type Derivable<T> = T | (() -> T)

export type UseFloatingConfig = {
	placement: Derivable<aether.Placement>?,
	middleware: Derivable<{ aether.Middleware<any> }>?,
	whileElementsMounted: (reference: aether.ReferenceElement, target: GuiObject, update: () -> ()) -> () -> ()?,
	elements: aether.ElementRefs?,
	enabled: boolean | (() -> boolean)?,
}

export type UseFloatingReturn = {
	x: () -> number,
	y: () -> number,
	placement: () -> aether.Placement,
	data: () -> aether.MiddlewareData,
	update: () -> (),
}

local function useFloating(
	reference: vide.Source<aether.ReferenceElement?>,
	target: vide.Source<GuiObject?>,
	config: UseFloatingConfig
): UseFloatingReturn
	local targetPlacement = config.placement or "bottom"
	local middleware = config.middleware or {}

	local x = source(0)
	local y = source(0)
	local placement = source(read(targetPlacement))
	local data = source({} :: aether.MiddlewareData)

	local version = derive(function()
		reference()
		target()
		return {}
	end)

	local function update()
		local currentReference = reference()
		local currentTarget = target()

		if not currentReference or not currentTarget then
			return
		end

		local capturedVersion = version()

		local result = aether.process(currentReference, currentTarget, {
			placement = read(targetPlacement),
			middleware = read(middleware),
		})

		if capturedVersion == version() then
			batch(function()
				x(result.x)
				y(result.y)
				placement(result.placement)
				data(result.data)
			end)
		end
	end

	effect(function()
		local currentReference = reference()
		local currentTarget = target()

		if not currentReference or not currentTarget then
			return
		end

		if config.whileElementsMounted then
			local destructor = config.whileElementsMounted(currentReference, currentTarget, update)
			cleanup(destructor)
		else
			update()
		end
	end)

	return {
		x = x,
		y = y,
		placement = placement,
		data = data,
		update = update,
	}
end

return useFloating
