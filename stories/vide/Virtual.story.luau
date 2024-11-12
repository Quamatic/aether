local vide = require(script.Parent.Parent.Parent.DevPackages.vide)
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
		local target = source(nil)
		local cursor = source({ x = 0, y = 0 })
		local open = source(false)
		local reference = source({
			getBoundingRect = function()
				local current = cursor()

				return {
					width = 0,
					height = 0,
					x = current.x,
					y = current.y,
					left = current.x,
					top = current.y,
					right = current.x,
					bottom = current.y,
				}
			end,
		})

		local floating = AetherVide.useFloating(reference, target, {
			placement = "top",
			middleware = {
				Aether.offset(5),
				Aether.shift(function()
					return {
						detectOverflowConfig = {
							boundary = boundary(),
							padding = 5,
						},
						crossAxis = true,
					}
				end),
			},
			whileElementsMounted = Aether.autoUpdate,
		})

		return Chrome {
			title = "Virtual",
			description = "Anchor relative to any coordinates, such as your mouse cursor.",
			goal = "Move your mouse around",
			children = {
				create "Frame" {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,

					MouseEnter = function(x: number, y: number)
						cursor({ x = x, y = y })
						open(true)
					end,

					MouseMoved = function(x: number, y: number)
						cursor({ x = x, y = y })
					end,

					MouseLeave = function()
						open(false)
					end,

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
					FontFace = Font.fromEnum(Enum.Font.GothamBold),
					BackgroundColor3 = Color3.fromHex("#ec4899"),
					Visible = open,

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
