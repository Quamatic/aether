local types = require(script.Parent.Parent.types)

local detectOverflow = require(script.Parent.Parent.detectOverflow)
type DetectOverflowConfig = detectOverflow.DetectOverflowConfig

local read = require(script.Parent.Parent.utils.read)
local merge = require(script.Parent.Parent.utils.merge)

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

	More information: https://quamatic.github.io/aether/docs/middleware/hide
]]
local function hide(input: types.DerivableInput<Input>?): types.Middleware<Output>
	return {
		name = "hide",
		run = function(state)
			local config = read(input or {}, state) :: Input

			local strategy = config.strategy or "reference-hidden"
			local detectOverflowConfig: DetectOverflowConfig = merge(config.detectOverflowConfig or {}, {
				elementContext = if strategy == "reference-hidden" then "reference" else "target",
				altBoundary = strategy == "escaped",
			})

			local overflow = detectOverflow(state, detectOverflowConfig)
			local rect = if strategy == "reference-hidden" then state.rects.reference else state.rects.target

			-- Storing these here to check if any side is overflowed inside of `data`.
			local top = overflow.top - rect.height
			local bottom = overflow.bottom - rect.height
			local left = overflow.left - rect.width
			local right = overflow.right - rect.width

			local offsets = {
				top = top,
				bottom = bottom,
				left = left,
				right = right,
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
