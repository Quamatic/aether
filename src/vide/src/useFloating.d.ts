import Vide from "@rbxts/vide";
import { Middleware, MiddlewareData, Placement, ReferenceElement } from "@rbxts/aether";

export interface UseFloatingConfig<R extends ReferenceElement, T extends GuiObject> {
	placement?: Vide.Derivable<Placement>;
	middleware?: Vide.Derivable<Middleware[]>;
	whileElementsMounted?: (reference: R, target: T, update: () => void) => Vide.Disposable;
	open?: Vide.Derivable<boolean>;
}

export interface UseFloatingReturn {
	x: () => number;
	y: () => number;
	placement: () => Placement;
	data: () => MiddlewareData;
	update: () => void;
}

/**
 * Computes the `x` and `y` coordinates that will place the floating element next to a reference element.
 *
 * @reference The reference element source.
 * @target The target (floating) element source.
 * @config The floating config.
 * @see {@link https://quamatic.github.io/aether/docs/vide}
 */
declare function useFloating<R extends ReferenceElement, T extends GuiObject>(
	reference: Vide.Source<R>,
	target: Vide.Source<T>,
	config: UseFloatingConfig<R, T>,
): UseFloatingReturn;

export default useFloating;
