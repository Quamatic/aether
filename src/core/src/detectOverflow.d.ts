import { ElementContext, MiddlewareState, Padding, Rect, SideObject } from "./types";

export type Boundary = "clipping-ancestors" | GuiObject | Rect;
export type RootBoundary = "layer-collector" | "viewport" | Rect;

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
 */
declare function detectOverflow(state: MiddlewareState, config: DetectOverflowConfig): SideObject;

export default detectOverflow;
