import {
	Boundary,
	BoundingRect,
	Cache,
	ContainingElement,
	ElementRects,
	ReferenceElement,
	RootBoundary,
	VirtualElement,
} from "../types";

/**
 * Returns the bounding rect of the given element.
 *
 * @param element The element to use. Can be virtual.
 * @param includeScale If `UIScale` should be factored into the final result. This will scale down the result if needed.
 * @param offsetParent The offset parent to calculate relative to.
 * @param cache The lifecycle cache.
 */
export function getElementBoundingRect(
	element: ContainingElement | VirtualElement,
	includeScale: boolean,
	offsetParent: ContainingElement | undefined,
	cache: Cache,
): BoundingRect;

/**
 * Returns the maximum area that the element is visible in due to any number of "clippable" ancestors.
 *
 * A "clippable" ancestor is any element ancestor that has `ClipsDescendants` enabled. Instances such as
 * `ScrollingFrame`s will always be considered, but you can also make your own clippable boundaries of course.
 *
 * @param element The element to check.
 * @param boundary The main boundary to check around.
 * @param rootBoundary The root boundary that encapsulates the main boundary (mainly the screen area). This can also be seen as a fallback boundary.
 * @param cache The lifecycle cache.
 */
export function getClippingRect(element: GuiObject, boundary: Boundary, rootBoundary: RootBoundary, cache: Cache): Rect;

/**
 * Returns the rects of the reference and target element.
 *
 * Two things to note:
 *
 * - The reference element is relative to the target elements offset parent.
 * - The target elements `x` and `y` values are always `0`, but contains the actual `width` and `height`.
 *
 * @param reference The reference element.
 * @param target The target element.
 * @param cache The lifecycle cache.
 */
export function getElementRects(reference: ReferenceElement, target: GuiObject, cache: Cache): ElementRects;

/**
 * Returns the scale of the given element.
 *
 * The scale of an element is the factor of each ancestor `UIScale` that affects it.
 *
 * @param element The element to check.
 * @param cache The lifecyle cache.
 */
export function getScale(element: ContainingElement, cache: Cache): number;

/**
 * Returns the "offset" parent of the given element.
 *
 * The "offset" parent is the first valid parent of the given element. Most of the time,
 * this is just the `Parent` value, but there are cases where a `Folder` instance may be used.
 * Because of that, this is useful for being safe.
 *
 * @param element The element to get the parent from.
 */
export function getOffsetParent(element: GuiObject): GuiObject | undefined;

/**
 * Returns the contaning `LayerCollector` instance of the given element, if one exists.
 *
 * @param element The element to retrieve from.
 */
export function getLayerElement(element: ContainingElement): LayerCollector | undefined;

/**
 * Converts the given rect into a rect that is relative to that of the given offset parent.
 *
 * @param rect The relative rect.
 * @param offsetParent The offset parent element.
 * @param cache The lifecyle cache.
 */
export function convertOffsetParentRectToRelativeRect(rect: Rect, offsetParent: ContainingElement, cache: Cache): Rect;

/**
 * Returns `true` if the provided value is a `GuiObject` or a `LayerCollector`.
 *
 * @param x
 */
export function isElement(x: unknown): x is ContainingElement;

/**
 * Attempts to unwrap an element into its `GuiObject` form, if one exists.
 *
 * If the given element is virtual and has a `contextElement` value then that is what is returned.
 *
 * @param element The element to unwrap.
 */
export function unwrapElement(element: ReferenceElement): GuiObject | undefined;
