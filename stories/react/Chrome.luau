local React = require(script.Parent.Parent.Parent.DevPackages.React)

local e = React.createElement

type Props = {
	title: string,
	description: string,
	goal: string,
	children: any,
}

local function Chrome(props: Props)
	return e("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(592, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromHex("#374151"),
	}, {
		UICorner = e("UICorner", {
			CornerRadius = UDim.new(0, 12),
		}),

		UIPadding = e("UIPadding", {
			PaddingLeft = UDim.new(0, 32),
			PaddingRight = UDim.new(0, 32),
			PaddingTop = UDim.new(0, 32),
			PaddingBottom = UDim.new(0, 32),
		}),

		UIListLayout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			VerticalFlex = Enum.UIFlexAlignment.SpaceBetween,
			Padding = UDim.new(0, 12),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),

		Title = e("TextLabel", {
			AutomaticSize = Enum.AutomaticSize.Y,
			Text = props.title,
			TextSize = 24,
			TextColor3 = Color3.fromHex("#ffffff"),
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Font.fromEnum(Enum.Font.GothamBold),
			BackgroundTransparency = 1,
		}),

		Description = e("TextLabel", {
			AutomaticSize = Enum.AutomaticSize.Y,
			Text = props.description,
			TextSize = 18,
			TextWrapped = true,
			TextColor3 = Color3.fromHex("#ffffff"),
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Font.fromEnum(Enum.Font.Gotham),
			BackgroundTransparency = 1,
			LayoutOrder = 1,
		}),

		Spacer = e("Frame", {
			Size = UDim2.fromOffset(0, 8),
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			LayoutOrder = 2,
		}),

		Window = e("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 3,
		}, {
			UIListLayout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			Title = e("Frame", {
				Size = UDim2.fromOffset(0, 44),
				BackgroundColor3 = Color3.fromHex("#4b5563"),
			}, {
				UICorner = e("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),

				Cover = e("Frame", {
					AnchorPoint = Vector2.yAxis,
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.new(1, 0, 0, 24),
					BackgroundColor3 = Color3.fromHex("#4b5563"),
					BorderSizePixel = 0,
					ZIndex = -1,
				}),

				Goal = e("TextLabel", {
					Size = UDim2.fromScale(1, 1),
					Text = props.goal,
					TextSize = 16,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextColor3 = Color3.fromHex("#ffffff"),
					FontFace = Font.fromEnum(Enum.Font.GothamMedium),
					BackgroundTransparency = 1,
				}),
			}),

			Content = e("Frame", {
				Size = UDim2.fromOffset(0, 320),
				BackgroundColor3 = Color3.fromHex("#ffffff"),
			}, {
				Cover = e("Frame", {
					Size = UDim2.new(1, 0, 0, 24),
					BackgroundColor3 = Color3.fromHex("#ffffff"),
					BorderSizePixel = 0,
				}),

				UICorner = e("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
			}, props.children),
		}),
	})
end

return Chrome
