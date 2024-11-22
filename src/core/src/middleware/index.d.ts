import { DetectOverflowConfig } from "../detectOverflow";
import {
	Alignment,
	Axis,
	DerivableInput,
	Middleware,
	MiddlewareState,
	Padding,
	Placement,
	Position,
	SideObject,
} from "../types";

interface DetectOverflowMiddleware {
	/**
	 * Optional config for `detectOverflow`.
	 */
	detectOverflowConfig?: DetectOverflowConfig;
}

interface Overflow {
	placement: Placement;
	values: number[];
}

// ----------------------------------------------

export type OffsetMiddlewareInput =
	| number
	| {
			/**
			 * The axis that runs along the side of the floating element. Represents
			 * the distance (gutter or margin) between the reference and floating
			 * element.
			 */
			mainAxis?: number;
			/**
			 * The axis that runs along the alignment of the floating element.
			 * Represents the skidding between the reference and floating element.
			 */
			crossAxis?: number;
			/**
			 * The same axis as `crossAxis` but applies only to aligned placements
			 * and inverts the `end` alignment. When set to a number, it overrides the
			 * `crossAxis` value.
			 *
			 * A positive number will move the floating element in the direction of
			 * the opposite edge to the one that is aligned, while a negative number
			 * the reverse.
			 */
			alignmentAxis?: number;
	  };

export interface OffsetMiddlewareData extends Position {
	placement: Placement;
}

/**
 * Modifies the placement by translating the floating element along the specified axes.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/offset}
 */
export function offset(input?: DerivableInput<OffsetMiddlewareInput>): Middleware<OffsetMiddlewareData>;

export interface FlipMiddlewareInput extends DetectOverflowMiddleware {
	/**
	 * The axis that runs along the side of the floating element. Determines
	 * whether overflow along this axis is checked to perform a flip.
	 */
	mainAxis?: boolean;
	/**
	 * The axis that runs along the alignment of the floating element. Determines
	 * whether overflow along this axis is checked to perform a flip.
	 */
	crossAxis?: boolean;
	/**
	 * Placements to try sequentially if the preferred `placement` does not fit.
	 */
	fallbackPlacements?: Placement[];
	/**
	 * What strategy to use when no placements fit.
	 */
	fallbackStrategy?: "best-fit" | "initial-placement";
	/**
	 * Whether to allow fallback to the perpendicular axis of the preferred
	 * placement, and if so, which side direction along the axis to prefer.
	 */
	fallbackAxisSideDirection?: Alignment | "none";
	/**
	 * Whether to flip to placements with the opposite alignment if they fit better.
	 */
	flipAlignment?: boolean;
}

export interface FlipMiddlewareData {
	index?: number;
	overflows: Overflow[];
}

/**
 * Optimizes the visibility of the floating element by flipping the `placement`
 * in order to keep it in view when the preferred placement(s) will overflow the
 * clipping boundary. Alternative to `autoPlacement`.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/flip}
 */
export function flip(input?: DerivableInput<FlipMiddlewareInput>): Middleware<FlipMiddlewareData>;

export interface AutoPlacementMiddlewareInput extends DetectOverflowMiddleware {
	/**
	 * The axis that runs along the alignment of the floating element. Determines
	 * whether to check for most space along this axis.
	 */
	crossAxis?: boolean;
	/**
	 * Choose placements with a particular alignment.
	 */
	alignment?: Alignment;
	/**
	 * Whether to choose placements with the opposite alignment if the preferred
	 * alignment does not fit.
	 */
	autoAlignment?: boolean;
	/**
	 * Which placements are allowed to be chosen. Placements must be within the
	 * `alignment` option if explicitly set.
	 */
	allowedPlacements?: Placement[];
}

export interface AutoPlacementMiddlewareData extends FlipMiddlewareData {}

/**
 * Optimizes the visibility of the floating element by choosing the placement
 * that has the most space available automatically, without needing to specify a
 * preferred placement. Alternative to `flip`.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/auto-placement}
 */
export function autoPlacement(
	input?: DerivableInput<AutoPlacementMiddlewareInput>,
): Middleware<AutoPlacementMiddlewareData>;

export interface ShiftMiddlewareInput extends DetectOverflowMiddleware {
	/**
	 * The axis that runs along the alignment of the floating element. Determines
	 * whether overflow along this axis is checked to perform shifting.
	 */
	mainAxis?: boolean;
	/**
	 * The axis that runs along the side of the floating element. Determines
	 * whether overflow along this axis is checked to perform shifting.
	 */
	crossAxis?: boolean;
	/**
	 * Accepts a function that limits the shifting done in order to prevent
	 * detachment.
	 */
	limiter?: (state: MiddlewareState) => Position;
}

export interface ShiftMiddlewareData extends Position {
	enabled: Record<Axis, boolean>;
}

/**
 * Optimizes the visibility of the floating element by shifting it in order to
 * keep it in view when it will overflow the clipping boundary.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/shift}
 */
export function shift(input?: DerivableInput<ShiftMiddlewareInput>): Middleware<ShiftMiddlewareData>;

export interface LimitShiftMiddlewareInput {
	/**
	 * Offset when limiting starts. `0` will limit when the opposite edges of the
	 * reference and floating elements are aligned.
	 */
	offset?:
		| number
		| {
				/**
				 * Offset the limiting of the axis that runs along the alignment of the
				 * floating element.
				 */
				mainAxis?: number;
				/**
				 * Offset the limiting of the axis that runs along the side of the
				 * floating element.
				 */
				crossAxis?: number;
		  };
	/**
	 * Whether to limit the axis that runs along the alignment of the floating
	 * element.
	 */
	mainAxis?: boolean;
	/**
	 * Whether to limit the axis that runs along the side of the floating element.
	 */
	crossAxis?: boolean;
}

/**
 * Built-in `limiter` that will stop `shift()` at a certain point.
 */
export function limitShift(input?: LimitShiftMiddlewareInput): Middleware;

export interface SizeMiddlewareInput extends DetectOverflowConfig {
	/**
	 * Function that is called to perform style mutations to the floating element
	 * to change its size.
	 */
	apply: (availableWidth: number, availableHeight: number) => void;
}

/**
 * Provides data that allows you to change the size of the floating element —
 * for instance, prevent it from overflowing the clipping boundary or match the
 * width of the reference element.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/size}
 */
export function size(input?: DerivableInput<SizeMiddlewareInput>): Middleware;

export interface HideMiddlewareInput extends DetectOverflowConfig {
	/**
	 * The strategy used to determine when to hide the floating element.
	 */
	strategy?: "reference-hidden" | "escaped";
}

export interface HideMiddlewareData {
	referenceHidden?: boolean;
	referenceHiddenOffsets?: SideObject;
	escaped?: boolean;
	escapedOffsets?: SideObject;
}

/**
 * Provides data to hide the floating element in applicable situations, such as
 * when it is not in the same clipping context as the reference element.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/hide}
 */
export function hide(input?: DerivableInput<HideMiddlewareInput>): Middleware<HideMiddlewareData>;

export interface ArrowMiddlewareInput {
	/**
	 * The arrow element to be positioned.
	 */
	element?: GuiObject;
	/**
	 * The padding between the arrow element and the floating element edges.
	 * Useful when the floating element has rounded corners.
	 */
	padding?: Padding;
}

export interface ArrowMiddlewareData extends Partial<Position> {
	centerOffset: number;
	alignmentOffset?: number;
}

/**
 * Provides data to position an inner element of the floating element so that it
 * appears centered to the reference element.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/arrow}
 */
export function arrow(input?: DerivableInput<ArrowMiddlewareInput>): Middleware<ArrowMiddlewareData>;

export interface InlineMiddlewareInput {
	/**
	 * Viewport-relative `x` coordinate to choose a `BoundingRect`.
	 */
	x?: number;
	/**
	 * Viewport-relative `y` coordinate to choose a `BoundingRect`
	 */
	y?: number;
	/**
	 * Represents the padding around a disjoined rect when choosing it.
	 */
	padding?: Padding;
}

/**
 * Provides improved positioning for inline reference elements that can span
 * over multiple lines, such as range selections.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/inline}
 */
export function inline(input?: DerivableInput<InlineMiddlewareInput>): Middleware;
