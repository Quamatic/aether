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

declare function useFloating<R extends ReferenceElement, T extends GuiObject>(
	reference: Vide.Source<R>,
	target: Vide.Source<T>,
	config: UseFloatingConfig<R, T>,
): UseFloatingReturn;

export default useFloating;
