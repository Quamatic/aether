local React = require(script.Parent.Parent.Parent.DevPackages.React)
local ReactRoblox = require(script.Parent.Parent.Parent.DevPackages.ReactRoblox)
local Aether = require(script.Parent.Parent.Parent.DevPackages.Aether)
local AetherReact = require(script.Parent.Parent.Parent.DevPackages.AetherReact)

local Chrome = require(script.Parent.Chrome)

local e = React.createElement

local function PlacementButton(props: {
	placement: string,
	current: string,
	order: number,
	set: (string) -> (),
})
	return e("ImageButton", {
		BackgroundColor3 = if props.current == props.placement then Color3.fromHex("#1f2937") else Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(20, 20),
		LayoutOrder = props.order,

		[React.Event.Activated] = function()
			props.set(props.placement)
		end,
	}, {
		UICorner = e("UICorner", {
			CornerRadius = UDim.new(1, 0),
		}),

		UIStroke = e("UIStroke", {
			Color = Color3.fromHex("#1f2937"),
		}),
	})
end

local function PlacementLayout(props: {
	origin: Vector2,
	position: UDim2,
	row: boolean,
	side: string,
	current: string,
	set: (string) -> (),
})
	return e("Frame", {
		AnchorPoint = props.origin,
		Position = props.position,
		Size = if props.row then UDim2.fromScale(1, 0) else UDim2.fromScale(0, 1),
		AutomaticSize = if props.row then Enum.AutomaticSize.Y else Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
	}, {
		UIListLayout = e("UIListLayout", {
			FillDirection = if props.row then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 36),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),

		Start = e(PlacementButton, {
			placement = `{props.side}-start`,
			current = props.current,
			order = 1,
			set = props.set,
		}),

		Center = e(PlacementButton, {
			placement = props.side,
			current = props.current,
			order = 2,
			set = props.set,
		}),

		End = e(PlacementButton, {
			placement = `{props.side}-end`,
			current = props.current,
			order = 3,
			set = props.set,
		}),
	})
end

local function Demo()
	local placement, setPlacement = React.useState("bottom")

	local floating = AetherReact.useFloating({
		placement = placement,
		middleware = {
			Aether.offset(5),
		},
		whileElementsMounted = Aether.autoUpdate,
	})

	return e(Chrome, {
		title = "Placement",
		description = "Places your element relative to another element",
		goal = "Click the dots",
	}, {
		Layouts = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		}, {
			UIPadding = e("UIPadding", {
				PaddingLeft = UDim.new(0, 18),
				PaddingRight = UDim.new(0, 18),
				PaddingTop = UDim.new(0, 18),
				PaddingBottom = UDim.new(0, 18),
			}),

			Top = e(PlacementLayout, {
				origin = Vector2.zero,
				position = UDim2.fromScale(0, 0),
				row = true,
				side = "top",
				current = placement,
				set = setPlacement,
			}),

			Bottom = e(PlacementLayout, {
				origin = Vector2.yAxis,
				position = UDim2.fromScale(0, 1),
				row = true,
				side = "bottom",
				current = placement,
				set = setPlacement,
			}),

			Left = e(PlacementLayout, {
				origin = Vector2.zero,
				position = UDim2.fromScale(0, 0),
				row = false,
				side = "left",
				current = placement,
				set = setPlacement,
			}),

			Right = e(PlacementLayout, {
				origin = Vector2.xAxis,
				position = UDim2.fromScale(1, 0),
				row = false,
				side = "right",
				current = placement,
				set = setPlacement,
			}),
		}),

		Reference = e("TextLabel", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(96, 96),
			Text = "Reference",
			TextSize = 16,
			TextColor3 = Color3.new(),
			FontFace = Font.fromEnum(Enum.Font.GothamBold),
			BackgroundColor3 = Color3.fromHex("#6b7280"),
			BorderSizePixel = 0,
			ref = floating.refs.setReference,
		}),

		Target = e("TextLabel", {
			Position = UDim2.fromOffset(floating.x, floating.y),
			AutomaticSize = Enum.AutomaticSize.XY,
			Text = placement,
			TextSize = 16,
			TextColor3 = Color3.fromHex("#ffffff"),
			FontFace = Font.fromEnum(Enum.Font.GothamBold),
			BackgroundColor3 = Color3.fromHex("#ec4899"),
			BorderSizePixel = 0,
			ref = floating.refs.setTarget,
		}, {
			UIPadding = e("UIPadding", {
				PaddingLeft = UDim.new(0, 4),
				PaddingRight = UDim.new(0, 4),
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 4),
			}),
		}),
	})
end

return {
	react = React,
	reactRoblox = ReactRoblox,
	story = function()
		return e(Demo)
	end,
}
