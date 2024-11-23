local vide = require(script.Parent.Parent.Parent.DevPackages.Vide)
local Aether = require(script.Parent.Parent.Parent.DevPackages.Aether)
local AetherVide = require(script.Parent.Parent.Parent.DevPackages.AetherVide)

local Chrome = require(script.Parent.Chrome)

local create = vide.create
local source = vide.source
local action = vide.action

return {
	vide = vide,
	story = function()
		local boundary = source(nil)
		local reference = source(nil)
		local target = source(nil)

		local floating = AetherVide.useFloating(reference, target, {
			placement = "bottom",
			middleware = {
				Aether.offset(5),
				Aether.hide({ strategy = "reference-hidden" }),
				Aether.hide({ strategy = "escaped" }),
			},
			whileElementsMounted = Aether.autoUpdate,
		})

		local function transparency()
			local hide = floating.data().hide
			return if hide ~= nil and hide.escaped then 0.5 else 0
		end

		return Chrome {
			title = "Hide",
			description = "Hides the element when the reference or target element escapes.",
			goal = "Scroll the container",
			children = {
				create "ScrollingFrame" {
					Size = UDim2.fromScale(1, 1),
					CanvasSize = UDim2.fromOffset(0, 1024),
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
					Text = "Tooltip",
					TextSize = 16,
					TextColor3 = Color3.fromHex("#ffffff"),
					TextTransparency = transparency,
					FontFace = Font.fromEnum(Enum.Font.GothamBold),
					BackgroundColor3 = Color3.fromHex("#ec4899"),
					BackgroundTransparency = transparency,

					Visible = function()
						local hide = floating.data().hide
						return if hide ~= nil then not hide.referenceHidden else true
					end,

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
