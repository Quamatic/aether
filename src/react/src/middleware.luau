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

local function offset(
	input: Aether.Derivable<Aether.OffsetMiddlewareInput>?,
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

local function flip(
	input: Aether.Derivable<Aether.FlipMiddlewareInput>?,
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

local function autoPlacement(
	input: Aether.Derivable<Aether.AutoPlacementMiddlewareInput>?,
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

local function shift(
	input: Aether.Derivable<Aether.ShiftMiddlewareInput>?,
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

local function size(
	input: Aether.Derivable<Aether.SizeMiddlewareInput>?,
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

local function hide(
	input: Aether.Derivable<Aether.HideMiddlewareInput>?,
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

local function arrow(
	input: Aether.Derivable<Aether.ArrowMiddlewareInput>?,
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

local function inline(
	input: Aether.Derivable<Aether.InlineMiddlewareInput>?,
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
