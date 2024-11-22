local Aether = require(script.Parent.Parent.Aether)

-- This file contains reactive versions of middleware.

type DependencyList = { any }

export type ReactiveMiddleware = Aether.Middleware<any> & {
	dependencies: DependencyList?,
}

-- This exists because of the way shallow equals works.
-- Having a function in the dependency list causes an infinite re-render unless a non-function value exists.
local function insert<T>(dependencies: DependencyList, input: T)
	if typeof(input) ~= "function" then
		table.insert(dependencies, input)
	end
end

--[[
    Modifies the placement by translating the floating element along the specified axes.

	More information: https://quamatic.github.io/aether/docs/middleware/offset
]]
local function offset(
	input: Aether.DerivableInput<Aether.OffsetMiddlewareInput>?,
	dependencies: DependencyList?
): ReactiveMiddleware
	local base = Aether.offset(input)

	local list = dependencies or {}
	insert(list, input)

	return {
		name = base.name,
		run = base.run,
		dependencies = list,
	}
end

--[[
	Optimizes the visibility of the floating element by flipping the `placement`
	in order to keep it in view when the preferred placement(s) will overflow the
	clipping boundary. Alternative to `autoPlacement`.

	More information: https://quamatic.github.io/aether/docs/middleware/flip
]]
local function flip(
	input: Aether.DerivableInput<Aether.FlipMiddlewareInput>?,
	dependencies: DependencyList?
): ReactiveMiddleware
	local base = Aether.flip(input)

	local list = dependencies or {}
	insert(list, input)

	return {
		name = base.name,
		run = base.run,
		dependencies = list,
	}
end

--[[
	Optimizes the visibility of the floating element by choosing the placement
	that has the most space available automatically, without needing to specify a
	preferred placement. Alternative to `flip`.

	More information: https://quamatic.github.io/aether/docs/middleware/auto-placement
]]
local function autoPlacement(
	input: Aether.DerivableInput<Aether.AutoPlacementMiddlewareInput>?,
	dependencies: DependencyList?
): ReactiveMiddleware
	local base = Aether.autoPlacement(input)

	local list = dependencies or {}
	insert(list, input)

	return {
		name = base.name,
		run = base.run,
		dependencies = list,
	}
end

--[[
    Optimizes the visibility of the floating element by shifting it in order to
	keep it in view when it will overflow the clipping boundary.

	More information: https://quamatic.github.io/aether/docs/middleware/shift
]]
local function shift(
	input: Aether.DerivableInput<Aether.ShiftMiddlewareInput>?,
	dependencies: DependencyList?
): ReactiveMiddleware
	local base = Aether.shift(input)

	local list = dependencies or {}
	insert(list, input)

	return {
		name = base.name,
		run = base.run,
		dependencies = list,
	}
end

--[[
	Provides data that allows you to change the size of the floating element —
	for instance, prevent it from overflowing the clipping boundary or match the
	width of the reference element.

	More information: https://quamatic.github.io/aether/docs/middleware/size
]]
local function size(
	input: Aether.DerivableInput<Aether.SizeMiddlewareInput>?,
	dependencies: DependencyList?
): ReactiveMiddleware
	local base = Aether.size(input)

	local list = dependencies or {}
	insert(list, input)

	return {
		name = base.name,
		run = base.run,
		dependencies = list,
	}
end

--[[
    Provides data to hide the floating element in applicable situations, such as
    when it is not in the same clipping context as the reference element.

	More information: https://quamatic.github.io/aether/docs/middleware/hide
]]
local function hide(
	input: Aether.DerivableInput<Aether.HideMiddlewareInput>?,
	dependencies: DependencyList?
): ReactiveMiddleware
	local base = Aether.hide(input)

	local list = dependencies or {}
	insert(list, input)

	return {
		name = base.name,
		run = base.run,
		dependencies = list,
	}
end

--[[
	Provides data to position an inner element of the floating element so that it
	appears centered to the reference element.

	More information: https://quamatic.github.io/aether/docs/middleware/arrow
]]
local function arrow(
	input: Aether.DerivableInput<Aether.ArrowMiddlewareInput>?,
	dependencies: DependencyList?
): ReactiveMiddleware
	local base = Aether.arrow(input)

	local list = dependencies or {}
	insert(list, input)

	return {
		name = base.name,
		run = base.run,
		dependencies = list,
	}
end

--[[
	Provides improved positioning for inline reference elements that can span
	over multiple lines, such as range selections.

	More information: https://quamatic.github.io/aether/docs/middleware/inline
]]
local function inline(
	input: Aether.DerivableInput<Aether.InlineMiddlewareInput>?,
	dependencies: DependencyList?
): ReactiveMiddleware
	local base = Aether.inline(input)

	local list = dependencies or {}
	insert(list, input)

	return {
		name = base.name,
		run = base.run,
		dependencies = list,
	}
end

return {
	offset = offset,
	flip = flip,
	autoPlacement = autoPlacement,
	shift = shift,
	size = size,
	hide = hide,
	arrow = arrow,
	inline = inline,
}
