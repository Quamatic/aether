import {
	ArrowMiddlewareData,
	AutoPlacementMiddlewareData,
	FlipMiddlewareData,
	HideMiddlewareData,
	OffsetMiddlewareData,
	ShiftMiddlewareData,
} from "./middleware";

export type Side = "top" | "bottom" | "left" | "right";
export type Alignment = "start" | "end";
export type Placement = Side | `${Side}-${Alignment}`;
export type Axis = "x" | "y";
export type Length = "width" | "height";

export type Position = Record<Axis, number>;
export type Dimensions = Record<Length, number>;
export type Rect = Position & Dimensions;
export type BoundingRect = Rect & SideObject;
export type SideObject = Record<Side, number>;
export type Padding = number | Partial<SideObject>;

// Elements

export type ElementContext = "reference" | "target";

export interface VirtualElement {
	contextElement?: GuiObject;
	getNativeRects?: () => BoundingRect[];
	getBoundingRect: () => BoundingRect;
}

export type ReferenceElement = GuiObject | VirtualElement;

export interface ElementRects {
	reference: Rect;
	floating: Rect;
}

export interface ElementRefs {
	reference: ReferenceElement;
	target: GuiObject;
}

// Middleware

export interface Middleware<T = void> {
	name: string;
	run: (state: MiddlewareState) => MiddlewareResult<T>;
}

export interface MiddlewareResult<T> {
	data?: T;
	reset?:
		| boolean
		| {
				placement?: Placement;
				rects?: boolean | ElementRects;
		  };
}

export interface MiddlewareData {
	[key: string]: unknown;
	offset?: OffsetMiddlewareData;
	flip?: FlipMiddlewareData;
	autoPlacement?: AutoPlacementMiddlewareData;
	shift?: ShiftMiddlewareData;
	hide?: HideMiddlewareData;
	arrow?: ArrowMiddlewareData;
}

export interface MiddlewareState extends Position {
	initialPlacement: Placement;
	placement: Placement;
	data: MiddlewareData;
	elements: ElementRefs;
	rects: ElementRects;
	rtl: boolean;
	cache: Cache;
}

// Misc

export type ContainingElement = GuiObject | LayerCollector;

export type Boundary = "clipping-ancestors" | GuiObject | GuiObject[] | Rect;
export type RootBoundary = "layer-collector" | Rect;

export interface Cache {
	elements: Map<ContainingElement, ContainingElement[]>;
	scales: Map<ContainingElement, number>;
}

export type DerivableInput<T> = T | (() => T);
