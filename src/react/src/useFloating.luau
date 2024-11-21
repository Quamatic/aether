local Aether = require(script.Parent.Parent.Aether)
local React = if script.Parent.Parent:FindFirstChild("react")
	then require(script.Parent.Parent.react) :: never
	else require(script.Parent.Parent.React)

-- Reactive middleware
local middleware = require(script.Parent.middleware)
type ReactiveMiddleware = middleware.ReactiveMiddleware

local useLatestRef = require(script.Parent.utils.useLatestRef)
local merge = require(script.Parent.utils.merge)
local shallowEqualDependencies = require(script.Parent.utils.shallowEqualDependencies)

local useState = React.useState
local useCallback = React.useCallback
local useMemo = React.useMemo
local useRef = React.useRef
local useLayoutEffect = React.useLayoutEffect

type UseFloatingData = Aether.ProcessConfigResult & {
	isPositioned: boolean,
}

export type UseFloatingConfig = {
	placement: Aether.Placement?,
	middleware: { ReactiveMiddleware }?,
	rtl: boolean?,
	whileElementsMounted: (reference: Aether.ReferenceElement, target: GuiObject, update: () -> ()) -> () -> ()?,
	elements: Aether.ElementRefs?,
}

export type UseFloatingReturn = UseFloatingData & {
	update: () -> (),
	elements: Aether.ElementRefs,
	refs: {
		reference: { current: Aether.ReferenceElement? },
		target: { current: GuiObject? },
		setReference: (node: Aether.ReferenceElement) -> (),
		setTarget: (node: GuiObject) -> (),
	},
}

local function useFloating(config: UseFloatingConfig): UseFloatingReturn
	local placement: Aether.Placement = config.placement or "bottom"
	local middleware = config.middleware or {}
	local sourceElements = config.elements or {} :: Aether.ElementRefs
	local whileElementsMounted = config.whileElementsMounted

	local data, setData = React.useState({
		x = 0,
		y = 0,
		placement = placement,
		data = {},
		isPositioned = false,
	} :: UseFloatingData)

	-- Middleware
	local latestMiddleware, setLatestMiddleware = React.useState(middleware)

	if not shallowEqualDependencies(latestMiddleware, middleware) then
		setLatestMiddleware(middleware)
	end

	-- Elements
	local reference, _setReference = useState(nil :: Aether.ReferenceElement?)
	local target, _setTarget = useState(nil :: GuiObject?)
	local referenceRef = useRef(nil :: Aether.ReferenceElement?)
	local targetRef = useRef(nil :: GuiObject?)

	-- These are the actual references.
	local referenceElement = sourceElements.reference or reference
	local targetElement = sourceElements.target or target

	local setReference = useCallback(function(node: Aether.ReferenceElement)
		if node ~= referenceRef.current then
			referenceRef.current = node
			_setReference(node)
		end
	end, {})

	local setTarget = useCallback(function(node: GuiObject)
		if node ~= targetRef.current then
			targetRef.current = node
			_setTarget(node)
		end
	end, {})

	-- Misc
	local whileElementsMountedRef = useLatestRef(whileElementsMounted)
	local isMountedRef = useRef(false)

	-- Update function
	local update = useCallback(function()
		if not referenceRef.current or not targetRef.current then
			return
		end

		local result = Aether.process(referenceRef.current, targetRef.current, {
			placement = placement,
			middleware = middleware,
		})

		local fullData = merge(result, {
			isPositioned = true,
		})

		if isMountedRef.current then
			setData(fullData)
		end
	end, { latestMiddleware, placement } :: { any })

	-- Mount ref
	useLayoutEffect(function()
		isMountedRef.current = true

		return function()
			isMountedRef.current = false
		end
	end, {})

	-- Updating
	useLayoutEffect(
		function(): ()
			if referenceElement then
				referenceRef.current = referenceElement
			end

			if targetElement then
				targetRef.current = targetElement
			end

			if referenceElement and targetElement then
				if whileElementsMountedRef.current then
					return whileElementsMountedRef.current(referenceElement, targetElement, update)
				end

				update()
			end
		end,
		{
			referenceElement,
			targetElement,
			update,
			whileElementsMountedRef,
		} :: { any }
	)

	local refs = useMemo(function()
		return {
			reference = referenceRef,
			target = targetRef,
			setReference = setReference,
			setTarget = setTarget,
		}
	end, { setReference, setTarget } :: { any })

	local elements: Aether.ElementRefs = useMemo(function()
		return {
			reference = referenceElement,
			target = targetElement,
		}
	end, { referenceElement, targetElement })

	return useMemo(function()
		return merge(data, {
			update = update,
			elements = elements,
			refs = refs,
		})
	end, { data, update, elements } :: { any })
end

return useFloating
