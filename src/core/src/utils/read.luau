local types = require(script.Parent.Parent.types)

local function read<T>(value: types.Derivable<T>)
	return if typeof(value) == "function" then value() else value
end

return read
