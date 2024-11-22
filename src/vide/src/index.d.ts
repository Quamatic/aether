import useFloating, { UseFloatingConfig, UseFloatingReturn } from "./useFloating";

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
	ReferenceElement,
	ContainingElement,
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

// Middleware
import { offset, flip, autoPlacement, shift, size, hide, arrow, inline } from "@rbxts/aether";

export = AetherVide;
export as namespace AetherVide;

declare namespace AetherVide {
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
		ReferenceElement,
		ContainingElement,
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
	};

	// Core
	export { process, detectOverflow, autoUpdate };

	// Middleware
	export { offset, flip, autoPlacement, shift, size, hide, arrow, inline };

	// Composable
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
