local useFloating = require(script.useFloating)
export type UseFloatingConfig = useFloating.UseFloatingConfig
export type UseFloatingReturn = useFloating.UseFloatingReturn

local middleware = require(script.middleware)
export type ReactiveMiddleware = middleware.ReactiveMiddleware

return {
	useFloating = useFloating,

	-- Reactive middleware
	offset = middleware.offset,
	flip = middleware.flip,
	autoPlacement = middleware.autoPlacement,
	shift = middleware.shift,
	size = middleware.size,
	hide = middleware.hide,
	arrow = middleware.arrow,
	inline = middleware.inline,
}
