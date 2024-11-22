import { Middleware, MiddlewareData, Placement, Position, ReferenceElement } from "./types";

export interface ProcessConfig {
	placement?: Placement;
	middleware?: Middleware[];
	rtl?: boolean;
}

export interface ProcessConfigResult extends Position {
	placement: Placement;
	data: MiddlewareData;
}

/**
 * Computes the coordinates that will determined the placement of the target
 * element next to a given reference element.
 *
 * @see {@link https://quamatic.github.io/aether/docs/guides/processing}
 */
declare function process(reference: ReferenceElement, target: GuiObject, config: ProcessConfig): ProcessConfigResult;

export default process;
