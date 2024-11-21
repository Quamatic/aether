local Aether = require(script.Parent.Aether)

-- Type re-exports
export type Placement = Aether.Placement
export type Side = Aether.Side
export type Alignment = Aether.Alignment
export type Axis = Aether.Axis
export type Length = Aether.Length

export type SideObject = Aether.SideObject
export type Rect = Aether.Rect
export type BoundingRect = Aether.BoundingRect
export type Padding = Aether.Padding

export type VirtualElement = Aether.VirtualElement
export type ReferenceElement = Aether.ReferenceElement
export type ElementRects = Aether.ElementRects
export type ElementRefs = Aether.ElementRefs

export type MiddlewareData = Aether.MiddlewareData
export type MiddlewareState = Aether.MiddlewareState
export type MiddlewareResult<T> = Aether.MiddlewareResult<T>
export type Middleware<T> = Aether.Middleware<T>
export type Derivable<T> = Aether.Derivable<T>

-- process
export type ProcessConfig = Aether.ProcessConfig
export type ProcessConfigResult = Aether.ProcessConfigResult

-- detectOverflow
export type DetectOverflowConfig = Aether.DetectOverflowConfig

-- Middleware input
export type OffsetMiddlewareInput = Aether.OffsetMiddlewareInput
export type ShiftMiddlewareInput = Aether.ShiftMiddlewareInput
export type HideMiddlewareInput = Aether.HideMiddlewareInput
export type SizeMiddlewareInput = Aether.SizeMiddlewareInput
export type FlipMiddlewareInput = Aether.FlipMiddlewareInput
export type AutoPlacementMiddlewareInput = Aether.AutoPlacementMiddlewareInput
export type ArrowMiddlewareInput = Aether.ArrowMiddlewareInput
export type InlineMiddlewareInput = Aether.InlineMiddlewareInput

-- Composable
local useFloating = require(script.useFloating)
export type UseFloatingConfig = useFloating.UseFloatingConfig
export type UseFloatingReturn = useFloating.UseFloatingReturn

return {
	-- Core
	process = Aether.process,
	detectOverflow = Aether.detectOverflow,
	autoUpdate = Aether.autoUpdate,

	-- Composable
	useFloating = useFloating,

	-- Middleware
	offset = Aether.offset,
	flip = Aether.flip,
	autoPlacement = Aether.autoPlacement,
	shift = Aether.shift,
	size = Aether.size,
	hide = Aether.hide,
	arrow = Aether.arrow,
	inline = Aether.inline,

	-- Utility
	getElementBoundingRect = Aether.getElementBoundingRect,
	getElementRects = Aether.getElementRects,
	isElement = Aether.isElement,
	unwrapElement = Aether.unwrapElement,
	getPlacementPosition = Aether.getPlacementPosition,
	getOppositePlacement = Aether.getOppositePlacement,
	getOppositeAlignmentPlacement = Aether.getOppositeAlignmentPlacement,
	getExpandedPlacements = Aether.getExpandedPlacements,
	getOppositeAxisPlacements = Aether.getOppositeAxisPlacements,
	getAlignmentSides = Aether.getAlignmentSides,
	convertRectToBoundingRect = Aether.convertRectToBoundingRect,
	isSameRect = Aether.isSameRect,
	getPaddingObject = Aether.getPaddingObject,
	read = Aether.read,
}
