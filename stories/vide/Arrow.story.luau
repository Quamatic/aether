local vide = require(script.Parent.Parent.Parent.DevPackages.vide)
local Aether = require(script.Parent.Parent.Parent.DevPackages.Aether)
local AetherVide = require(script.Parent.Parent.Parent.DevPackages.AetherVide)

local Chrome = require(script.Parent.Chrome)

local create = vide.create
local source = vide.source
local action = vide.action

local function Arrow(props: {
	placement: () -> string,
	position: () -> UDim2,
	visible: () -> boolean,
	ref: vide.Source<GuiObject>,
})
	local sides = {
		top = {
			origin = Vector2.yAxis,
			position = UDim2.fromScale(0, 1),
		},
		bottom = {
			origin = Vector2.zero,
			position = UDim2.fromScale(0, 0),
		},
		left = {
			origin = Vector2.xAxis,
			position = UDim2.fromScale(1, 0),
		},
		right = {
			origin = Vector2.zero,
			position = UDim2.fromScale(0, 0),
		},
	}

	local anchor = vide.derive(function()
		return sides[props.placement()]
	end)

	return create {
		Name = "Arrow",

		AnchorPoint = function()
			return anchor().origin
		end,

		Position = function()
			return anchor().position + props.position()
		end,

		Size = UDim2.fromOffset(16, 16),
		BackgroundColor3 = Color3.fromHex("#ec4899"),
		Visible = props.visible,

		action(props.ref),
	}
end

return {
	vide = vide,
	story = function()
		local boundary = source(nil)
		local reference = source(nil)
		local target = source(nil)
		local arrow = source(nil)

		local floating = AetherVide.useFloating(reference, target, {
			placement = "bottom",
			middleware = {
				Aether.offset(5),
				Aether.autoPlacement(function()
					return {
						detectOverflowConfig = {
							boundary = boundary(),
						},
					}
				end),
				Aether.arrow(function()
					return {
						element = arrow(),
					}
				end),
			},
			whileElementsMounted = Aether.autoUpdate,
		})

		return Chrome {
			title = "Arrow",
			description = "Provides positioning data for an arrow element inside the target element, such that it appears to be pointing towards the center of the reference element.",
			goal = "Scroll the container",
			children = {
				create "ScrollingFrame" {
					Size = UDim2.fromScale(1, 1),
					CanvasSize = UDim2.fromOffset(1024, 812),
					CanvasPosition = Vector2.new(0, 812 / 4),
					BackgroundTransparency = 1,

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

					action(boundary),
				},

				create "TextLabel" {
					Name = "Target",

					Position = function()
						return UDim2.fromOffset(floating.x(), floating.y())
					end,

					AutomaticSize = Enum.AutomaticSize.XY,
					Text = "The arrow is positioned dynamically",
					TextSize = 16,
					TextColor3 = Color3.fromHex("#ffffff"),
					FontFace = Font.fromEnum(Enum.Font.GothamBold),
					BackgroundColor3 = Color3.fromHex("#ec4899"),

					create "UIPadding" {
						PaddingLeft = UDim.new(0, 8),
						PaddingRight = UDim.new(0, 8),
						PaddingTop = UDim.new(0, 8),
						PaddingBottom = UDim.new(0, 8),
					},

					Arrow {
						placement = function()
							return "bottom"
						end,

						position = function()
							local arrow = floating.data().arrow

							local x = if arrow and arrow.x then arrow.x else 0
							local y = if arrow and arrow.y then arrow.y else 0

							return UDim2.fromOffset(x, y)
						end,

						visible = function()
							local arrow = floating.data().arrow
							return arrow and arrow.centerOffset ~= 0
						end,

						ref = arrow,
					},

					action(target),
				},
			},
		}
	end,
}
