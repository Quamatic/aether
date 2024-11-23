local Aether = require(script.Parent.Parent.Aether)
local vide = if script.Parent.Parent:FindFirstChild("vide")
	then require(script.Parent.Parent.vide) :: never
	else require(script.Parent.Parent.Vide)

local source = vide.source
local effect = vide.effect
local cleanup = vide.cleanup
local read = vide.read
local derive = vide.derive
local batch = vide.batch

type Derivable<T> = T | (() -> T)
type Source<T> = (() -> T) & ((value: T) -> T)

export type UseFloatingConfig = {
	placement: Derivable<Aether.Placement>?,
	middleware: Derivable<{ Aether.Middleware }>?,
	rtl: Derivable<boolean>?,
	whileElementsMounted: (reference: Aether.ReferenceElement, target: GuiObject, update: () -> ()) -> () -> ()?,
}

export type UseFloatingReturn = {
	x: () -> number,
	y: () -> number,
	placement: () -> Aether.Placement,
	data: () -> Aether.MiddlewareData,
	update: () -> (),
}

--[[
	Computes the `x` and `y` coordinates that will place the floating element next to a reference element.

	More information here: https://quamatic.github.io/aether/docs/vide
]]
local function useFloating(
	reference: Source<Aether.ReferenceElement?>,
	target: Source<GuiObject?>,
	config: UseFloatingConfig
): UseFloatingReturn
	local targetPlacement = config.placement or "bottom"
	local middleware = config.middleware or {}
	local rtl = if config.rtl ~= nil then config.rtl else false

	local x = source(0)
	local y = source(0)
	local placement = source(read(targetPlacement))
	local data = source({} :: Aether.MiddlewareData)

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

		local result = Aether.process(currentReference, currentTarget, {
			placement = read(targetPlacement),
			middleware = read(middleware),
			rtl = read(rtl),
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
