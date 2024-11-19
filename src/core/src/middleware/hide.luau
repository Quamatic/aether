local types = require(script.Parent.Parent.types)

local detectOverflow = require(script.Parent.Parent.detectOverflow)
type DetectOverflowConfig = detectOverflow.DetectOverflowConfig

local read = require(script.Parent.Parent.utils.read)

export type Input = {
	--[[
		Optional config for `detectOverflow`.
	]]
	detectOverflowConfig: DetectOverflowConfig?,
	--[[
		The strategy used to determine when to hide the floating element.
	]]
	strategy: "reference-hidden" | "escaped"?,
}

export type Output = {
	referenceHidden: boolean?,
	referenceHiddenOffsets: types.SideObject?,
	escaped: boolean?,
	escapedOffsets: types.SideObject?,
}

--[[
    Provides data to hide the floating element in applicable situations, such as
    when it is not in the same clipping context as the reference element.
]]
local function hide(input: types.Derivable<Input>?): types.Middleware<Output>
	return {
		name = "hide",
		run = function(state)
			local config = read(input or {}, state) :: Input

			local strategy = config.strategy or "reference-hidden"
			local detectOverflowConfig = config.detectOverflowConfig or {}

			local overflow = detectOverflow(state, detectOverflowConfig)
			local rect = if strategy == "reference-hidden" then state.rects.reference else state.rects.target

			-- Storing these here to check if any side is overflowed inside of `data`.
			local top = overflow.top
			local bottom = overflow.bottom
			local left = overflow.left
			local right = overflow.right

			local offsets = {
				top = top - rect.height,
				bottom = bottom - rect.height,
				left = left - rect.width,
				right = right - rect.width,
			}

			local hidden = top >= 0 or bottom >= 0 or left >= 0 or right >= 0

			return {
				data = if strategy == "reference-hidden"
					then {
						referenceHidden = hidden,
						referenceHiddenOffsets = offsets,
					}
					else {
						escaped = hidden,
						escapedOffsets = offsets,
					},
			}
		end,
	}
end

return hide
