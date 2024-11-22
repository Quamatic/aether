import {
	ArrowMiddlewareInput,
	AutoPlacementMiddlewareInput,
	DerivableInput,
	FlipMiddlewareInput,
	HideMiddlewareInput,
	InlineMiddlewareInput,
	Middleware,
	OffsetMiddlewareInput,
	ShiftMiddlewareInput,
	SizeMiddlewareInput,
} from "@rbxts/aether";
import { DependencyList } from "@rbxts/react";

export interface ReactiveMiddleware extends Middleware {
	/** im bussin. */
	dependencies?: DependencyList;
}

/**
 * Modifies the placement by translating the floating element along the specified axes.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/offset}
 */
export function offset(input: DerivableInput<OffsetMiddlewareInput>, dependencies?: DependencyList): ReactiveMiddleware;

/**
 * Optimizes the visibility of the floating element by flipping the `placement`
 * in order to keep it in view when the preferred placement(s) will overflow the
 * clipping boundary. Alternative to `autoPlacement`.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/flip}
 */
export function flip(input: DerivableInput<FlipMiddlewareInput>, dependencies?: DependencyList): ReactiveMiddleware;

/**
 * Optimizes the visibility of the floating element by choosing the placement
 * that has the most space available automatically, without needing to specify a
 * preferred placement. Alternative to `flip`.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/auto-placement}
 */
export function autoPlacement(
	input: DerivableInput<AutoPlacementMiddlewareInput>,
	dependencies?: DependencyList,
): ReactiveMiddleware;

/**
 * Optimizes the visibility of the floating element by shifting it in order to
 * keep it in view when it will overflow the clipping boundary.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/shift}
 */
export function shift(input: DerivableInput<ShiftMiddlewareInput>, dependencies?: DependencyList): ReactiveMiddleware;

/**
 * Provides data that allows you to change the size of the floating element —
 * for instance, prevent it from overflowing the clipping boundary or match the
 * width of the reference element.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/size}
 */
export function size(input: DerivableInput<SizeMiddlewareInput>, dependencies?: DependencyList): ReactiveMiddleware;

/**
 * Provides data to hide the floating element in applicable situations, such as
 * when it is not in the same clipping context as the reference element.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/hide}
 */
export function hide(input: DerivableInput<HideMiddlewareInput>, dependencies?: DependencyList): ReactiveMiddleware;

/**
 * Provides data to position an inner element of the floating element so that it
 * appears centered to the reference element.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/arrow}
 */
export function arrow(input: DerivableInput<ArrowMiddlewareInput>, dependencies?: DependencyList): ReactiveMiddleware;

/**
 * Provides improved positioning for inline reference elements that can span
 * over multiple lines, such as range selections.
 *
 * @see {@link https://quamatic.github.io/aether/docs/middleware/inline}
 */
export function inline(input: DerivableInput<InlineMiddlewareInput>, dependencies?: DependencyList): ReactiveMiddleware;
