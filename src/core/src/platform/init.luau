return {
	getOffsetParent = require(script.getOffsetParent),
	getElementRects = require(script.getElementRects),
	getClippingRect = require(script.getClippingRect),
	getLayerElement = require(script.getLayerElement),
	getRectRelativeToOffsetParent = require(script.getRectRelativeToOffsetParent),
	getElementBoundingRect = require(script.getElementBoundingRect),
	convertOffsetParentRelativeRectToViewportRelativeRect = require(
		script.convertOffsetParentRelativeRectToViewportRelativeRect
	),
	getScale = require(script.getScale),
	isElement = require(script.isElement),
	unwrapElement = require(script.unwrapElement),
}
