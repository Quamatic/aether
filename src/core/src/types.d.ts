import {
	ArrowMiddlewareData,
	AutoPlacementMiddlewareData,
	FlipMiddlewareData,
	HideMiddlewareData,
	OffsetMiddlewareData,
	ShiftMiddlewareData,
	SizeMiddlewareData,
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
	getLineRects?: () => BoundingRect[];
	getBoundingRect: () => BoundingRect;
}

export type ReferenceElement = GuiObject | VirtualElement;

export interface ElementRects {
	reference: Rect;
	floating: Rect;
}

export interface Elements {
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
	size?: SizeMiddlewareData;
	hide?: HideMiddlewareData;
	arrow?: ArrowMiddlewareData;
}

export interface MiddlewareState extends Position {
	initialPlacement: Placement;
	placement: Placement;
	data: MiddlewareData;
	elements: Elements;
	rects: ElementRects;
	rtl: boolean;
}

// Misc

export type Derivable<T> = T | (() => T);
