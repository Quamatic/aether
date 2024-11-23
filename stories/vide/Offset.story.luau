local vide = require(script.Parent.Parent.Parent.DevPackages.Vide)
local Aether = require(script.Parent.Parent.Parent.DevPackages.Aether)
local AetherVide = require(script.Parent.Parent.Parent.DevPackages.AetherVide)

local Chrome = require(script.Parent.Chrome)

local create = vide.create
local source = vide.source
local action = vide.action

local function Example(props: { offset: number, x: number })
	local reference = source(nil)
	local target = source(nil)

	local floating = AetherVide.useFloating(reference, target, {
		placement = "bottom",
		middleware = {
			Aether.offset(props.offset),
		},
		whileElementsMounted = Aether.autoUpdate,
	})

	return {
		create "TextLabel" {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, props.x, 0.5, 0),
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
			Text = `{props.offset}px`,
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
	}
end

return {
	vide = vide,
	story = function()
		return Chrome {
			title = "Placement",
			description = "Places your element relative to another element.",
			goal = "Click the dots",
			children = {

				Example {
					offset = 0,
					x = -64,
				},

				Example {
					offset = 10,
					x = 64,
				},
			},
		}
	end,
}
