local vide = require(script.Parent.Parent.Parent.DevPackages.Vide)

local create = vide.create

export type Props = {
	title: string,
	description: string,
	goal: string,
	children: any,
}

local function Chrome(props: Props)
	return create "Frame" {
		Name = "Content",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(512, 384),
		BackgroundColor3 = Color3.fromHex("#ffffff"),

		props.children,
	}
end

return Chrome
