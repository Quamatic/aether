local vide = require(script.Parent.Parent.Parent.DevPackages.vide)

local create = vide.create

export type Props = {
	title: string,
	description: string,
	goal: string,
	children: any,
}

local function Chrome(props: Props)
	return create "Frame" {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(592, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromHex("#374151"),

		create "UICorner" {
			CornerRadius = UDim.new(0, 12),
		},

		create "UIPadding" {
			PaddingLeft = UDim.new(0, 32),
			PaddingRight = UDim.new(0, 32),
			PaddingTop = UDim.new(0, 32),
			PaddingBottom = UDim.new(0, 32),
		},

		create "UIListLayout" {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			VerticalFlex = Enum.UIFlexAlignment.SpaceBetween,
			Padding = UDim.new(0, 12),
		},

		create "TextLabel" {
			Name = "Title",
			AutomaticSize = Enum.AutomaticSize.Y,
			Text = props.title,
			TextSize = 24,
			TextColor3 = Color3.fromHex("#ffffff"),
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Font.fromEnum(Enum.Font.GothamBold),
			BackgroundTransparency = 1,
		},

		create "TextLabel" {
			Name = "Description",
			AutomaticSize = Enum.AutomaticSize.Y,
			Text = props.description,
			TextSize = 18,
			TextWrapped = true,
			TextColor3 = Color3.fromHex("#ffffff"),
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Font.fromEnum(Enum.Font.Gotham),
			BackgroundTransparency = 1,
		},

		create "Frame" {
			Name = "Spacer",
			Size = UDim2.fromOffset(0, 8),
			BackgroundTransparency = 1,
		},

		create "Frame" {
			Name = "Window",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,

			create "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
			},

			create "Frame" {
				Name = "Title",
				Size = UDim2.fromOffset(0, 44),
				BackgroundColor3 = Color3.fromHex("#4b5563"),

				create "UICorner" {
					CornerRadius = UDim.new(0, 8),
				},

				create "Frame" {
					Name = "Cover",
					AnchorPoint = Vector2.yAxis,
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.new(1, 0, 0, 24),
					BackgroundColor3 = Color3.fromHex("#4b5563"),
				},

				create "TextLabel" {
					Name = "Goal",
					Size = UDim2.fromScale(1, 1),
					Text = props.goal,
					TextSize = 16,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextColor3 = Color3.fromHex("#ffffff"),
					FontFace = Font.fromEnum(Enum.Font.GothamMedium),
					BackgroundTransparency = 1,
				},
			},

			create "Frame" {
				Name = "Content",
				Size = UDim2.fromOffset(0, 320),
				BackgroundColor3 = Color3.fromHex("#ffffff"),

				create "Frame" {
					Name = "Cover",
					Size = UDim2.new(1, 0, 0, 24),
					BackgroundColor3 = Color3.fromHex("#ffffff"),
				},

				create "UICorner" {
					CornerRadius = UDim.new(0, 8),
				},

				props.children,
			},
		},
	}
end

return Chrome
