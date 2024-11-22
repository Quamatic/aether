import { Boundary, ElementContext, MiddlewareState, Padding, Rect, RootBoundary, SideObject } from "./types";

export interface DetectOverflowConfig {
	boundary?: Boundary;
	rootBoundary?: RootBoundary;
	elementContext?: ElementContext;
	altBoundary?: boolean;
	padding?: Padding;
}

/**
 * Resolves with an object of overflow side offsets that determine how much the
 * element is overflowing a given clipping boundary on each side.
 *
 * - positive = overflowing the boundary by that number of pixels
 * - negative = how many pixels left before it will overflow
 * - 0 = lies flush with the boundary
 *
 * @see {@link https://quamatic.github.io/aether/docs/guides/collisions}
 */
declare function detectOverflow(state: MiddlewareState, config: DetectOverflowConfig): SideObject;

export default detectOverflow;
