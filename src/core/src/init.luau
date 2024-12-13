local types = require(script.types)

-- Positioning
export type Placement = types.Placement
export type Side = types.Side
export type Alignment = types.Alignment
export type Axis = types.Axis
export type Length = types.Length
export type Position = types.Position
export type Dimensions = types.Dimensions

-- Shapes
export type SideObject = types.SideObject
export type Rect = types.Rect
export type BoundingRect = types.BoundingRect
export type Padding = types.Padding

-- Elements
export type VirtualElement = types.VirtualElement
export type ReferenceElement = types.ReferenceElement
export type ContainingElement = types.ContainingElement
export type ElementRects = types.ElementRects
export type ElementRefs = types.ElementRefs

-- Middleware
export type MiddlewareData = types.MiddlewareData
export type MiddlewareState = types.MiddlewareState
export type MiddlewareResult<T> = types.MiddlewareResult<T>
export type Middleware<T = {}> = types.Middleware<T>

-- Misc
export type Boundary = types.Boundary
export type RootBoundary = types.RootBoundary
export type Cache = types.Cache
export type DerivableInput<T> = types.DerivableInput<T>

-- Core
local process = require(script.process)
export type ProcessConfig = process.ProcessConfig
export type ProcessConfigResult = process.ProcessConfigResult

local detectOverflow = require(script.detectOverflow)
export type DetectOverflowConfig = detectOverflow.DetectOverflowConfig

local autoUpdate = require(script.autoUpdate)

-- Middleware
local middleware = require(script.middleware)
export type OffsetMiddlewareInput = middleware.OffsetMiddlewareInput
export type ShiftMiddlewareInput = middleware.ShiftMiddlewareInput
export type HideMiddlewareInput = middleware.HideMiddlewareInput
export type SizeMiddlewareInput = middleware.SizeMiddlewareInput
export type FlipMiddlewareInput = middleware.FlipMiddlewareInput
export type AutoPlacementMiddlewareInput = middleware.AutoPlacementMiddlewareInput
export type ArrowMiddlewareInput = middleware.ArrowMiddlewareInput
export type InlineMiddlewareInput = middleware.InlineMiddlewareInput

-- Utility
local placement = require(script.utils.placement)
local rects = require(script.utils.rects)
local platform = require(script.platform)

return table.freeze({
	-- Core
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

	-- Platform
	getElementBoundingRect = platform.getElementBoundingRect,
	getClippingRect = platform.getClippingRect,
	getElementRects = platform.getElementRects,
	getScale = platform.getScale,
	getOffsetParent = platform.getOffsetParent,
	getLayerElement = platform.getLayerElement,
	convertOffsetParentRectToRelativeRect = platform.convertOffsetParentRectToRelativeRect,
	isElement = platform.isElement,
	unwrapElement = platform.unwrapElement,

	-- Placement
	getPlacementPosition = placement.getPlacementPosition,
	getOppositePlacement = placement.getOppositePlacement,
	getOppositeAlignmentPlacement = placement.getOppositeAlignmentPlacement,
	getExpandedPlacements = placement.getExpandedPlacements,
	getOppositeAxisPlacements = placement.getOppositeAxisPlacements,
	getAlignmentSides = placement.getAlignmentSides,

	-- Rects
	convertRectToBoundingRect = rects.convertRectToBoundingRect,
	isSameRect = rects.isSameRect,

	-- Misc
	getPaddingObject = require(script.utils.getPaddingObject),
	read = require(script.utils.read),
})
