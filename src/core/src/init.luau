local types = require(script.types)

-- Positioning
export type Placement = types.Placement
export type Position = types.Position

-- Elements
export type VirtualElement = types.VirtualElement
export type ReferenceElement = types.ReferenceElement
export type ElementRects = types.ElementRects
export type ElementRefs = types.ElementRefs

-- Middleware
export type MiddlewareData = types.MiddlewareData
export type MiddlewareState = types.MiddlewareState
export type MiddlewareResult<T> = types.MiddlewareResult<T>
export type Middleware<T> = types.Middleware<T>

local process = require(script.process)
export type ProcessConfig = process.ProcessConfig
export type ProcessConfigResult = process.ProcessConfigResult

local detectOverflow = require(script.detectOverflow)
export type DetectOverflowConfig = detectOverflow.DetectOverflowConfig

local autoUpdate = require(script.autoUpdate)
local middleware = require(script.middleware)

return table.freeze({
	process = process,
	detectOverflow = detectOverflow,
	autoUpdate = autoUpdate,

	-- Middleware
	offset = middleware.offset,
	shift = middleware.shift,
	limitShift = middleware.limitShift,
	size = middleware.size,
	flip = middleware.flip,
	autoPlacement = middleware.autoPlacement,
	hide = middleware.hide,
	arrow = middleware.arrow,
	inline = middleware.inline,
})
