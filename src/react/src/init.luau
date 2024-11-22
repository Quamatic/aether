local Aether = require(script.Parent.Aether)

-- Type re-exports
export type Placement = Aether.Placement
export type Side = Aether.Side
export type Alignment = Aether.Alignment
export type Axis = Aether.Axis
export type Length = Aether.Length
export type Position = Aether.Position
export type Dimensions = Aether.Dimensions

export type SideObject = Aether.SideObject
export type Rect = Aether.Rect
export type BoundingRect = Aether.BoundingRect
export type Padding = Aether.Padding

export type VirtualElement = Aether.VirtualElement
export type ReferenceElement = Aether.ReferenceElement
export type ContainingElement = Aether.ContainingElement
export type ElementRects = Aether.ElementRects
export type ElementRefs = Aether.ElementRefs

export type MiddlewareData = Aether.MiddlewareData
export type MiddlewareState = Aether.MiddlewareState
export type MiddlewareResult<T> = Aether.MiddlewareResult<T>
export type Middleware<T> = Aether.Middleware<T>

export type Boundary = Aether.Boundary
export type RootBoundary = Aether.RootBoundary
export type Cache = Aether.Cache
export type DerivableInput<T> = Aether.DerivableInput<T>

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

-- Hook
local useFloating = require(script.useFloating)
export type UseFloatingConfig = useFloating.UseFloatingConfig
export type UseFloatingReturn = useFloating.UseFloatingReturn

-- Reactive middleware
local middleware = require(script.middleware)
export type ReactiveMiddleware = middleware.ReactiveMiddleware

return {
	-- Core
	process = Aether.process,
	detectOverflow = Aether.detectOverflow,
	autoUpdate = Aether.autoUpdate,

	-- Hook
	useFloating = useFloating,

	-- Reactive middleware
	offset = middleware.offset,
	flip = middleware.flip,
	autoPlacement = middleware.autoPlacement,
	shift = middleware.shift,
	limitShift = Aether.limitShift,
	size = middleware.size,
	hide = middleware.hide,
	arrow = middleware.arrow,
	inline = middleware.inline,

	-- Utility
	getElementBoundingRect = Aether.getElementBoundingRect,
	getClippingRect = Aether.getClippingRect,
	getElementRects = Aether.getElementRects,
	getScale = Aether.getScale,
	getOffsetParent = Aether.getOffsetParent,
	getLayerElement = Aether.getLayerElement,
	convertOffsetParentRectToRelativeRect = Aether.convertOffsetParentRectToRelativeRect,
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
