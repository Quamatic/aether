-- Placement

export type Placement = string

export type Axis = "x" | "y"
export type Length = "width" | "height"

-- Shapes

export type Position = {
	x: number,
	y: number,
}

export type Dimensions = {
	width: number,
	height: number,
}

export type Sides = {
	top: number,
	bottom: number,
	left: number,
	right: number,
}

export type PartialSides = {
	top: number?,
	bottom: number?,
	left: number?,
	right: number?,
}

export type Padding = number | PartialSides

export type Rect = Position & Dimensions
export type BoundingRect = Rect & Sides

-- Elements

export type VirtualElement = {
	contextElement: GuiObject?,
	getRects: () -> ()?,
	getBoundingRect: () -> BoundingRect,
}

export type ReferenceElement = GuiObject | VirtualElement

export type ElementRefs = {
	reference: ReferenceElement,
	target: GuiObject,
}

export type ElementRects = {
	reference: Rect,
	target: Rect,
}

-- Middleware

-- Technically not a middleware type, but it's used in two seperate middleware.
export type Overflow = {
	values: { number },
	placement: Placement,
}

export type MiddlewareData = {
	[string]: any & {},
	offset: (Position & {
		placement: Placement,
	})?,
	flip: {
		index: number,
		overflows: { Overflow },
	}?,
	autoPlacement: {
		index: number,
		overflows: { Overflow },
	}?,
	shift: (Position & {
		enabled: {
			x: boolean,
			y: boolean,
		},
	})?,
	arrow: {
		[Axis]: number,
		centerOffset: number,
		alignmentOffset: number?,
	}?,
	hide: {
		offsets: Sides,
		hidden: boolean,
	}?,
}

export type MiddlewareState = Position & {
	initialPlacement: string,
	placement: string,
	data: MiddlewareData,
	elements: ElementRefs,
	rects: ElementRects,
	rtl: boolean,
}

export type MiddlewareResult<T> = {
	x: number?,
	y: number?,
	data: T?,
	reset: boolean | {
		placement: Placement?,
		rects: boolean | ElementRects?,
	}?,
}

export type Middleware<T> = {
	name: string,
	run: (state: MiddlewareState) -> MiddlewareResult<T>?,
}

-- Misc

export type Boundary = "clipping-ancestors" | GuiObject | Rect
export type RootBoundary = "layer-collector" | Rect

export type Derivable<T> = T | (() -> T)

return nil
