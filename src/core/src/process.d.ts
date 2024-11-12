import { Middleware, MiddlewareData, Placement, Position, ReferenceElement } from "./types";

export interface ProcessConfig {
	placement?: Placement;
	middleware?: Middleware[];
}

export interface ProcessConfigResult extends Position {
	placement: Placement;
	data: MiddlewareData;
}

declare function process(reference: ReferenceElement, target: GuiObject, config: ProcessConfig): ProcessConfigResult;

export default process;
