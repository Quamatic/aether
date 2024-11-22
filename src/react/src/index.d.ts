// Hook
import useFloating, { UseFloatingConfig, UseFloatingReturn } from "./useFloating";

// Types
import type {
	Placement,
	Side,
	Alignment,
	Axis,
	Length,
	SideObject,
	Rect,
	BoundingRect,
	Padding,
	VirtualElement,
	ContainingElement,
	ReferenceElement,
	ElementRects,
	ElementContext,
	ElementRefs,
	MiddlewareData,
	MiddlewareState,
	MiddlewareResult,
	Middleware,
	DerivableInput,
	ProcessConfig,
	ProcessConfigResult,
	DetectOverflowConfig,
	OffsetMiddlewareInput,
	FlipMiddlewareInput,
	AutoPlacementMiddlewareInput,
	ShiftMiddlewareInput,
	SizeMiddlewareInput,
	HideMiddlewareInput,
	ArrowMiddlewareInput,
	InlineMiddlewareInput,
	Cache,
} from "@rbxts/aether";

// Core
import { process, detectOverflow, autoUpdate } from "@rbxts/aether";

// Platform
import {
	getElementBoundingRect,
	getClippingRect,
	getElementRects,
	getScale,
	getOffsetParent,
	getLayerElement,
	convertOffsetParentRectToRelativeRect,
	isElement,
	unwrapElement,
} from "@rbxts/aether";

// Utility
import {
	getPlacementPosition,
	getPlacementAxes,
	getOppositePlacement,
	getOppositeAlignmentPlacement,
	getExpandedPlacements,
	getOppositeAxisPlacements,
	getAlignmentSides,
	convertRectToBoundingRect,
	isSameRect,
	getPaddingObject,
	read,
} from "@rbxts/aether";

// Reactive middleware
import { offset, flip, autoPlacement, shift, size, hide, arrow, inline } from "./middleware";

export = AetherReact;
export as namespace AetherReact;

declare namespace AetherReact {
	// Types
	export type {
		Placement,
		Side,
		Alignment,
		Axis,
		Length,
		SideObject,
		Rect,
		BoundingRect,
		Padding,
		VirtualElement,
		ContainingElement,
		ReferenceElement,
		ElementRects,
		ElementContext,
		ElementRefs,
		MiddlewareData,
		MiddlewareState,
		MiddlewareResult,
		Middleware,
		DerivableInput,
		ProcessConfig,
		ProcessConfigResult,
		DetectOverflowConfig,
		OffsetMiddlewareInput,
		FlipMiddlewareInput,
		AutoPlacementMiddlewareInput,
		ShiftMiddlewareInput,
		SizeMiddlewareInput,
		HideMiddlewareInput,
		ArrowMiddlewareInput,
		InlineMiddlewareInput,
		Cache,
	};

	// Core
	export { process, detectOverflow, autoUpdate };

	// Reactive middleware
	export { offset, flip, autoPlacement, shift, size, hide, arrow, inline };

	// Hook
	export { useFloating, UseFloatingConfig, UseFloatingReturn };

	// Platform
	export {
		getElementBoundingRect,
		getClippingRect,
		getElementRects,
		getScale,
		getOffsetParent,
		getLayerElement,
		convertOffsetParentRectToRelativeRect,
		isElement,
		unwrapElement,
	};

	// Utility
	export {
		getPlacementPosition,
		getPlacementAxes,
		getOppositePlacement,
		getOppositeAlignmentPlacement,
		getExpandedPlacements,
		getOppositeAxisPlacements,
		getAlignmentSides,
		convertRectToBoundingRect,
		isSameRect,
		getPaddingObject,
		read,
	};
}
