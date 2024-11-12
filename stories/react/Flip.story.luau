local React = require(script.Parent.Parent.Parent.DevPackages.React)
local ReactRoblox = require(script.Parent.Parent.Parent.DevPackages.ReactRoblox)
local Aether = require(script.Parent.Parent.Parent.DevPackages.Aether)
local AetherReact = require(script.Parent.Parent.Parent.DevPackages.AetherReact)

local Chrome = require(script.Parent.Chrome)

local e = React.createElement

local function Demo()
	local floating = AetherReact.useFloating({
		placement = "bottom",
		middleware = {
			Aether.offset(5),
			Aether.flip({}),
		},
		whileElementsMounted = Aether.autoUpdate,
	})

	return e(Chrome, {
		title = "Flip",
		description = "Changes the placement of the element to keep it in view",
		goal = "Scroll the container",
	}, {
		ScrollContent = e("ScrollingFrame", {
			Size = UDim2.fromScale(1, 1),
			CanvasSize = UDim2.fromOffset(0, 812),
			CanvasPosition = Vector2.new(0, 812 / 4),
			ScrollBarImageColor3 = Color3.new(0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		}, {
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
				Text = "Popover",
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
