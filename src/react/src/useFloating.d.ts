import { ProcessConfig, ProcessConfigResult, ReferenceElement } from "@rbxts/aether";
import { MutableRefObject } from "@rbxts/react";

export interface UseFloatingData extends ProcessConfigResult {
	isPositioned: boolean;
}

export interface UseFloatingConfig<R extends ReferenceElement, T extends GuiObject = GuiObject> extends ProcessConfig {
	whileElementsMounted?: (reference: R, target: T, update: () => void) => () => void;
	elements?: {
		reference?: R;
		target?: T;
	};
}

export interface UseFloatingReturn<R extends ReferenceElement, T extends GuiObject = GuiObject>
	extends UseFloatingData {
	/**
	 * Updates the position of the target element, re-rendering the component
	 * if required.
	 */
	update: () => void;
	/**
	 * Object containing the reference and target refs and reactive setters.
	 */
	refs: {
		reference: MutableRefObject<R | undefined>;
		target: MutableRefObject<R | undefined>;
		setReference: (node: R | undefined) => void;
		setTarget: (node: T | undefined) => void;
	};
	/**
	 * Object containing the reference and target element.
	 */
	elements: {
		reference?: R;
		target?: T;
	};
}

declare function useFloating<R extends ReferenceElement, T extends GuiObject = GuiObject>(
	config: UseFloatingConfig<R, T>,
): UseFloatingReturn<R, T>;

export default useFloating;
