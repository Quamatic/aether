local function getLayerElement(element: GuiObject | LayerCollector): LayerCollector?
	return if element:IsA("LayerCollector") then element else element:FindFirstAncestorWhichIsA("LayerCollector")
end

return getLayerElement
