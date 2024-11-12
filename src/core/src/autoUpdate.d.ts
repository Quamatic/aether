import { ReferenceElement } from "./types";

/**
 * Automatically updates the position of the floating element when necessary.
 * Should only be called when the floating element is mounted or visible on the screen.
 */
declare function autoUpdate(
	reference: ReferenceElement,
	target: GuiObject,
	event: "elements" | "render",
	update: () => void,
): () => void;

export default autoUpdate;
