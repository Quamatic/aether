local middleware = require(script.Parent.Parent.middleware)
type ReactiveMiddleware = middleware.ReactiveMiddleware

local function shadowEqualDependencies(middlewareA: { ReactiveMiddleware }, middlewareB: { ReactiveMiddleware })
	if middlewareA == middlewareB then
		return true
	end

	if #middlewareA ~= #middlewareB then
		-- Doesn't have the same amount of middleware
		return false
	end

	for index, a in middlewareA do
		local b = middlewareB[index]
		if b == nil then
			return false
		end

		local dependenciesA = a.dependencies
		local dependenciesB = b.dependencies

		if dependenciesA and dependenciesB then
			if #dependenciesA ~= #dependenciesB then
				-- Dependency count isnt the same
				return false
			end

			for i, value in dependenciesA do
				if dependenciesB[i] ~= value then
					-- Dependency value is different
					return false
				end
			end
		elseif dependenciesA or dependenciesB then
			-- One has dependencies but the other doesn't
			return false
		end
	end

	return true
end

return shadowEqualDependencies
