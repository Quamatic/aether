local vide = require(script.Parent.Parent.Parent.DevPackages.vide)
local Aether = require(script.Parent.Parent.Parent.DevPackages.Aether)
local AetherVide = require(script.Parent.Parent.Parent.DevPackages.AetherVide)

local Chrome = require(script.Parent.Chrome)

local create = vide.create
local source = vide.source
local action = vide.action

local function PlacementButton(props: {
	placement: string,
	current: vide.Source<string>,
	order: number,
})
	local hovered = source(false)

	return create "ImageButton" {
		BackgroundColor3 = function()
			return if props.current() == props.placement then Color3.fromHex("#1f2937") else Color3.new(1, 1, 1)
		end,

		Size = vide.spring(function()
			return if hovered() then UDim2.fromOffset(24, 24) else UDim2.fromOffset(20, 20)
		end, 0.2),

		LayoutOrder = props.order,

		MouseEnter = function()
			hovered(true)
		end,

		MouseLeave = function()
			hovered(false)
		end,

		Activated = function()
			props.current(props.placement)
		end,

		create "UICorner" {
			CornerRadius = UDim.new(1, 0),
		},

		create "UIStroke" {
			Color = Color3.fromHex("#1f2937"),
		},
	}
end

local function PlacementLayout(props: {
	origin: Vector2,
	position: UDim2,
	row: boolean,
	side: string,
	current: vide.Source<string>,
})
	return create "Frame" {
		AnchorPoint = props.origin,
		Position = props.position,
		Size = if props.row then UDim2.fromScale(1, 0) else UDim2.fromScale(0, 1),
		AutomaticSize = if props.row then Enum.AutomaticSize.Y else Enum.AutomaticSize.X,
		BackgroundTransparency = 1,

		create "UIListLayout" {
			FillDirection = if props.row then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 36),
			SortOrder = Enum.SortOrder.LayoutOrder,
		},

		PlacementButton {
			placement = `{props.side}-start`,
			current = props.current,
			order = 1,
		},

		PlacementButton {
			placement = props.side,
			current = props.current,
			order = 2,
		},

		PlacementButton {
			placement = `{props.side}-end`,
			current = props.current,
			order = 3,
		},
	}
end

return {
	vide = vide,
	story = function()
		local placement = source("right")
		local reference = source(nil)
		local target = source(nil)

		local floating = AetherVide.useFloating(reference, target, {
			placement = placement,
			middleware = {
				Aether.offset(5),
			},
			whileElementsMounted = Aether.autoUpdate,
		})

		return Chrome {
			title = "Placement",
			description = "Places your element relative to another element.",
			goal = "Click the dots",
			children = {
				create "Frame" {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,

					create "UIPadding" {
						PaddingLeft = UDim.new(0, 18),
						PaddingRight = UDim.new(0, 18),
						PaddingTop = UDim.new(0, 18),
						PaddingBottom = UDim.new(0, 18),
					},

					PlacementLayout {
						origin = Vector2.zero,
						position = UDim2.fromScale(0, 0),
						row = true,
						side = "top",
						current = placement,
					},

					PlacementLayout {
						origin = Vector2.yAxis,
						position = UDim2.fromScale(0, 1),
						row = true,
						side = "bottom",
						current = placement,
					},

					PlacementLayout {
						origin = Vector2.zero,
						position = UDim2.fromScale(0, 0),
						row = false,
						side = "left",
						current = placement,
					},

					PlacementLayout {
						origin = Vector2.xAxis,
						position = UDim2.fromScale(1, 0),
						row = false,
						side = "right",
						current = placement,
					},
				},

				create "TextLabel" {
					Name = "Reference",
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromOffset(96, 96),
					Text = "Reference",
					TextSize = 16,
					TextColor3 = Color3.new(),
					FontFace = Font.fromEnum(Enum.Font.GothamBold),
					BackgroundColor3 = Color3.fromHex("#6b7280"),

					action(reference),
				},

				create "TextLabel" {
					Name = "Target",

					Position = function()
						return UDim2.fromOffset(floating.x(), floating.y())
					end,

					AutomaticSize = Enum.AutomaticSize.XY,
					Text = placement,
					TextSize = 16,
					TextColor3 = Color3.fromHex("#ffffff"),
					FontFace = Font.fromEnum(Enum.Font.GothamBold),
					BackgroundColor3 = Color3.fromHex("#ec4899"),

					create "UIPadding" {
						PaddingLeft = UDim.new(0, 4),
						PaddingRight = UDim.new(0, 4),
						PaddingTop = UDim.new(0, 4),
						PaddingBottom = UDim.new(0, 4),
					},

					action(target),
				},
			},
		}
	end,
}
