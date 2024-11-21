local function merge<A, B>(a: A, b: B): A & B
	local cloned = table.clone(a :: any)

	for key, value in b :: any do
		cloned[key] = value
	end

	return (cloned :: any) :: A & B
end

return merge
