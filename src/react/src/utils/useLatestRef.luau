local React = require(script.Parent.Parent.Parent.React)

local function useLatestRef<T>(value: T): { current: T }
	local ref = React.useRef(value)

	React.useLayoutEffect(function()
		ref.current = value
	end)

	return ref
end

return useLatestRef
