import { ReferenceElement } from "./types";

/**
 * Automatically updates the position of the floating element when necessary.
 * Should only be called when the floating element is mounted or visible on the screen.
 *
 * @see {@link https://quamatic.github.io/aether/docs/guides/updating}
 */
declare function autoUpdate(reference: ReferenceElement, target: GuiObject, update: () => void): () => void;

export default autoUpdate;
