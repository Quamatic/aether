import process, { ProcessConfig, ProcessConfigResult } from "./process";
import detectOverflow, { DetectOverflowConfig, Boundary, RootBoundary } from "./detectOverflow";
import autoUpdate from "./autoUpdate";

import { offset, flip, autoPlacement, shift, limitShift, size, hide, arrow, inline } from "./middleware";
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
	ElementRects,
	Elements,
	ElementContext,
	ReferenceElement,
	Middleware,
	MiddlewareData,
	MiddlewareResult,
	MiddlewareState,
} from "./types";

export = Aether;
export as namespace Aether;

declare namespace Aether {
	// Processing
	export { process, ProcessConfig, ProcessConfigResult };
	export { detectOverflow, DetectOverflowConfig, Boundary, RootBoundary };
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
		ElementRects,
		Elements,
		ElementContext,
		ReferenceElement,
		Middleware,
		MiddlewareData,
		MiddlewareResult,
		MiddlewareState,
	};
}
