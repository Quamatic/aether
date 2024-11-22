import { Alignment, Axis, ElementRects, Placement, Side } from "../types";

/**
 * Returns the {@link Side | side} and {@link Alignment | alignment} of the given placement.
 *
 * Note that the alignment will only exist when the placement actually has an alignment value, such as `"top-start"`.
 *
 * @param placement The placement to extract from.
 */
export function getPlacementPosition(placement: Placement): LuaTuple<[Side, Alignment | undefined]>;

/**
 * Returns the {@link Axis | axis} equivalents of the side and alignment of the given placement.
 *
 * @param placement The placement to extract from.
 */
export function getPlacementAxes(placement: Placement): LuaTuple<[Axis, Axis]>;

/**
 * Returns the opposite _side_ part of the given placement.
 *
 * For example, if the placement is `"top-start"`, then the opposite placement would be `"bottom-start"`.
 * Present alignments stay the same.
 *
 * @param placement The placement to switch.
 */
export function getOppositePlacement(placement: Placement): Placement;

/**
 * Returns the opposite _alignment_ part of the given placement.
 *
 * For example, if the placement is `"top-start"`, then the opposite placement would be `"top-end"`.
 * The side always stays the same.
 *
 * @param placement The placement to switch.
 */
export function getOppositeAlignmentPlacement(placement: Placement): Placement;

/**
 * Returns all possible alternative values for a given placement, excluding the initial placement itself.
 *
 * @param placement The placement to extract from.
 */
export function getExpandedPlacements(placement: Placement): [Placement, Placement, Placement];

/**
 * Returns all of the possible placements from the opposite axis of a given placement.
 *
 * @param placement The placement to extract from.
 * @param flipAlignment If the returned list should include opposite alignment placements as well. This is only used when the provided placement has an alignment.
 * @param direction The direction of the list.
 * @param rtl If right-to-left calculations should be used.
 */
export function getOppositeAxisPlacements(
	placement: Placement,
	flipAlignment: boolean,
	direction: Alignment | "none",
	rtl?: boolean,
): Placement[];

/**
 * Returns the two possible {@link Side | sides} of a given placement, listed in order as the main side followed by the cross (opposite) side.
 *
 * @param placement The placement to extract from.
 * @param rects The element rects. Typically, this will be the `rects` value provided by the middleware lifecycle.
 * @param rtl If right-to-left calculations should be used.
 */
export function getAlignmentSides(placement: Placement, rects: ElementRects, rtl?: boolean): LuaTuple<[Side, Side]>;
