import { BoundingRect, Rect } from "../types";

/**
 * Converts a rect into a bounding rect.
 */
export function convertRectToBoundingRect(rect: Rect): BoundingRect;

/**
 * Returns `true` if the given rects are the same.
 *
 * @param left The left rect.
 * @param right The right rect.
 */
export function isSameRect(left: Rect, right: Rect): boolean;
