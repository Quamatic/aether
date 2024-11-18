local types = require(script.Parent.Parent.types)

local function read<T>(value: types.Derivable<T>, state: types.MiddlewareState)
	return if typeof(value) == "function" then value(state) else value
end

return read
