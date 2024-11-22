// Core
import process, { ProcessConfig, ProcessConfigResult } from "./process";
import detectOverflow, { DetectOverflowConfig } from "./detectOverflow";
import autoUpdate from "./autoUpdate";

// Middleware
import { offset, flip, autoPlacement, shift, limitShift, size, hide, arrow, inline } from "./middleware";

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
} from "./platform";

// Utility
import {
	getPlacementPosition,
	getPlacementAxes,
	getOppositePlacement,
	getOppositeAlignmentPlacement,
	getExpandedPlacements,
	getOppositeAxisPlacements,
	getAlignmentSides,
} from "./utils/placement";
import { convertRectToBoundingRect, isSameRect } from "./utils/rects";
import getPaddingObject from "./utils/getPaddingObject";
import read from "./utils/read";

import type {
	OffsetMiddlewareInput,
	FlipMiddlewareInput,
	AutoPlacementMiddlewareInput,
	ShiftMiddlewareInput,
	LimitShiftMiddlewareInput,
	SizeMiddlewareInput,
	HideMiddlewareInput,
	ArrowMiddlewareInput,
	InlineMiddlewareInput,
} from "./middleware";

import type {
	Side,
	Alignment,
	Placement,
	Axis,
	Length,
	Position,
	Dimensions,
	Rect,
	BoundingRect,
	SideObject,
	Padding,
	VirtualElement,
	ContainingElement,
	ElementRects,
	ElementRefs,
	ElementContext,
	ReferenceElement,
	Middleware,
	MiddlewareData,
	MiddlewareResult,
	MiddlewareState,
	DerivableInput,
	Boundary,
	RootBoundary,
	Cache,
} from "./types";

export = Aether;
export as namespace Aether;

declare namespace Aether {
	// Processing
	export { process, ProcessConfig, ProcessConfigResult };
	export { detectOverflow, DetectOverflowConfig };
	export { autoUpdate };

	// Middleware
	export { offset, OffsetMiddlewareInput };
	export { flip, FlipMiddlewareInput };
	export { autoPlacement, AutoPlacementMiddlewareInput };
	export { shift, ShiftMiddlewareInput };
	export { limitShift, LimitShiftMiddlewareInput };
	export { size, SizeMiddlewareInput };
	export { hide, HideMiddlewareInput };
	export { arrow, ArrowMiddlewareInput };
	export { inline, InlineMiddlewareInput };

	// Types
	export {
		Side,
		Alignment,
		Placement,
		Axis,
		Length,
		Position,
		Dimensions,
		Rect,
		BoundingRect,
		SideObject,
		Padding,
		VirtualElement,
		ContainingElement,
		ElementRects,
		ElementRefs,
		ElementContext,
		ReferenceElement,
		Middleware,
		MiddlewareData,
		MiddlewareResult,
		MiddlewareState,
		DerivableInput,
		Boundary,
		RootBoundary,
		Cache,
	};

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
