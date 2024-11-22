---
title: Utility
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

Aether provides different utility functions to help with usage of the library.

## `getPlacementPosition`

This is useful for when you have a value with a [`Placement`](./types#placement) type and need to extract
the side and/or the alignment.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local side, alignment = Aether.getPlacementPosition("top-start")
    print(side, alignment) -- "top" "start"

    local side, alignment = Aether.getPlacementPosition("bottom")
    print(side, alignment) -- "bottom" "nil"
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { getPlacementPosition } from "@rbxts/aether";

    const [side, alignment] = getPlacementPosition("top-start");
    print(side, alignment); // "top" "start"

    const [side, alignment] = getPlacementPosition("bottom");
    print(side, alignment); // "bottom" "nil"
    ```

  </TabItem>
</Tabs>

## `getOppositePlacement`

Returns the opposite **side** part of a given placement.

The opposite sides are as follows:

-   `"top"` - `"bottom"`
-   `"bottom`" - `"top"`
-   `"left"` - "`"right"`
-   `"right"` - `"left"`

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local placement = Aether.getOppositePlacement("top-start")
    print(placement) -- "bottom-start"
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { getOppositePlacement } from "@rbxts/aether";

    const placement = getOppositePlacement("top-start");
    print(placement); // "bottom-start"
    ```

  </TabItem>
</Tabs>

## `getOppositeAlignmentPlacement`

Returns the opposite **alignment** part of a given placement.

The opposite alignments are as follows:

-   `"start"` - `"end"`
-   `"end"` - `"start"`

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local placement = Aether.getOppositeAlignmentPlacement("top-start")
    print(placement) -- "top-end"
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { getOppositeAlignmentPlacement } from "@rbxts/aether";

    const placement = getOppositeAlignmentPlacement("top-start");
    print(placement); // "top-end"
    ```

  </TabItem>
</Tabs>

## `getExpandedPlacements`

Provides all possible alternative values for a given placement, excluding the initial placement itself.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local placements = Aether.getExpandedPlacements("top-start")
    print(placements) -- "{ "top-end", "bottom-start", "bottom-end" }"
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { getExpandedPlacements } from "@rbxts/aether";

    const placement = getExpandedPlacements("top-start");
    print(placement); // "{ "top-end", "bottom-start", "bottom-end" }"
    ```

  </TabItem>
</Tabs>

## `getOppositeAxisPlacements`

Returns all of the possible placements from the opposite axis of a given placement.

The following parameters can be passed:

### `placement`

The placement to extract from.

### `flipAlignment`

When the given `placement` has an alignment and this is set to `true`, the returned placements will include the opposite
alignment placements as well.

### `direction`

The [alignment](./types#alignment) to start from. This affects the order of placements.

For example, when the [`side`](./types#side) of the placement is set to `top` or `bottom`, and the direction is set to `start`, the opposite side order becomes `[left, right]`. Conversely, a direction of end or none results in `[right, left]`.

:::note
When `rtl` is set to `true`, the resulting value is flipped to the opposite end of its usual direction.
:::

### `rtl`

When set to `true`, right-to-left calculations will be used instead.

### `Example`

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local placements = Aether.getOppositeAxisPlacements("top-start", true, "start")

    -- Since flipAlignment is `true`, we have an extra two values that are both opposite alignments.
    -- The direction is also "start", so the order is [left, right].

    print(placements) -- { "left-start", "bottom-start", "left-end", "bottom-end" }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { getOppositeAxisPlacements } from "@rbxts/aether";

    const placement = getOppositeAxisPlacements("top-start", true, "start");

    // Since flipAlignment is `true`, we have an extra two values that are both opposite alignments.
    // The direction is also "start", so the order is [left, right].

    print(placement); // "{ "left-start", "left-end", "bottom-start", "bottom-end" }"
    ```

  </TabItem>
</Tabs>

## `getAlignmentSides`

Returns the two possible [`sides`](./types#side) of a given placement, listed in order as the main side followed by the cross (opposite) side.

The following parameters can be passed:

### `placement`

The placement to extract from.

### `rects`

The [`element rects`](./types#elementrects) to use. Typically, this will be the [`rects`](./middleware#rects) value provided by middleware.

### `rtl`

Default value: `false`

When set to `true`, right-to-left calculations will be used instead.

### `Example`

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    -- Lets say "rects" is derived from `state.rects` via middleware.
    local main, cross = Aether.getAlignmentSides("top-start", rects)

    print(main, cross) -- - "bottom", "top";
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { getOppositeAxisPlacements } from "@rbxts/aether";

    // Lets say "rects" is derived from `state.rects` via middleware.
    const [main, cross] = getAlignmentSides("top-start", rects);

    print(main, cross); // - "bottom", "top";
    ```

  </TabItem>
</Tabs>

:::note
The length (dimension) of the elements provided via `rects` is considered during the process, based on the axis variant of the given placement's alignment.

If the `reference` element's length exceeds that of the `target` element, the main side is flipped to its opposite direction, making the cross side its counterpart.
:::

## `getElementBoundingRect`

Returns the [BoundingRect](./types#boundingrect) of a given element, with extra calculations to get the precise area.

The following parameters can be passed:

### `element`

The element to calculate the rect for. This can be a [virtual element](./guides/virtual-elements).

### `includeScale`

When set to `true`, the ancestor `UIScale`'s will be accounted for in the calculation. I.e., values will be scaled down based on the final factor.

### `offsetParent`

The element to calculate relative to. When `includeScale` is set to `true`, the ancestor `UIScale`'s of this element will be considered instead of the given `element`. Note that `offsetParent` is typically just the `Parent` property of the element, and it also doesn't have to necessarily be accessed off of `element` itself.

### `cache`

The [lifecycle cache](./guides/processing#cache)

## `getElementRects`

Takes in the `elements` and returns the element [`Rect`](./types#rect) objects.

The following parameters can be passed:

### `reference`

The `x` and `y` values of a `reference` `Rect` should be its coordinates relative to the floating element’s `Parent` element if required rather than the screen.

### `target`

Both `x` and `y` are not relevant initially, so you can set these both of these to `0`.

### `cache`

The [lifecycle cache](./guides/processing#cache)

## `getClippingRect`

Returns the Rect (**relative to the screen**) whose outside bounds will clip the given element. For instance, the screen itself.

The following parameters can be passed:

### `element`

The `GuiObject` to calculate the clipping rect for.

### `boundary`

The [boundary](./guides/collisions.md#boundary) to use.

### `rootBoundary`

The [root boundary](./guides/collisions#rootboundary) to use.

### `cache`

The [lifecycle cache](./guides/processing#cache)

## `getScale`

Returns the scale of the given element.

The scale of an element is the factor of each ancestor `UIScale` that affects it.

### `element`

The element to check

### `cache`

The [lifecycle cache](./guides/processing#cache)

## `getOffsetParent`

Returns the "offset" parent of the given element.

The "offset" parent is the first valid parent of the given element. Most of the time,this is just the `Parent` value, but there are cases where a `Folder` instance may be used. Because of that, this is useful for being safe.

### `element`

The element to get the parent from.

## `getLayerElement`

Returns the contaning `LayerCollector` instance of the given element, if one exists.

### `element`

The element to retrieve from.

## `convertOffsetParentRectToRelativeRect`

Converts the given rect into a rect that is relative to that of the given offset parent.

### `rect`

The rect to go off of.

### `offsetParent`

The offset parent element.

### `cache`

The [lifecycle cache](./guides/processing#cache)

## `isElement`

Determines if the passed value is a `GuiObject`.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local reference = Instance.new("Frame")

    print(Aether.isElement(reference)) -- true
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { isElement } from "@rbxts/aether";

    const reference = new Instance("Frame");

    print(isElement(reference)); // true
    ```

  </TabItem>
</Tabs>

## `unwrapElement`

Used for unwrapping an element into its `GuiObject` form, if viable. For example, extracting the `contextElement` from a [virtual element](./guides/virtual-elements#contextelement) when present.

If the element is already a `GuiObject` then that will be returned.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local reference = Instance.new("Frame")

    print(Aether.unwrapElement(reference)) -- Frame

    local contextElement = Instance.new("TextLabel")
    local reference: Aether.VirtualElement = {
        getBoundingRect = function()
            return ...
        end,

        contextElement = contextElement,
    }

    print(Aether.unwrapElement(reference)) -- TextLabel
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { unwrapElement, type VirtualElement } from "@rbxts/aether";

    const reference = new Instance("Frame");

    print(unwrapElement(reference)); // Frame

    const contextElement = new Instance("TextLabel");
    const reference: VirtualElement = {
        getBoundingRect: () => {
            return ...
        },

        contextElement,
    };

    print(unwrapElement(reference)); // TextLabel
    ```

  </TabItem>
</Tabs>

## `convertRectToBoundingRect`

Converts a [Rect](./types#rect) into its [BoundingRect](./types#boundingrect) form.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local rect: Aether.Rect = {
        x = 5,
        y = 10,
        width = 15,
        height = 20,
    }

    local result = Aether.convertRectToBoundingRect(rect)

    --[[
        Resulting BoundingRect:

        x: 5,
        y: 10,
        width: 15,
        height: 15,
        left: 5,
        top: 10,
        left: 5,
        right: 20,
        bottom: 30,
    ]]
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { convertRectToBoundingRect, type Rect } from "@rbxts/aether";

    const rect: Rect = {
        x: 5,
        y: 10,
        width: 15,
        height: 20,
    }

    const result = convertRectToBoundingRect(rect);

    /**
      * Resulting BoundingRect:
      *
      * x: 5,
      * y: 10,
      * width: 15,
      * height: 15,
      * left: 5,
      * top: 10,
      * left: 5,
      * right: 20,
      * bottom: 30,
      */
    ```

  </TabItem>
</Tabs>

## `isSameRect`

Returns `true` if two [Rect](./types#rect) objects are the same (i.e., the same values).

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local one: Aether.Rect = {
        x = 0,
        y = 0,
        width = 0,
        height = 0,
    }

    local two: Aether.Rect = {
        x = 0,
        y = 0,
        width = 10,
        height = 10,
    }

    print(isSameRect(one, one)) -- "true"
    print(isSameRect(one, two)) -- "false"
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { isSameRect, type Rect } from "@rbxts/aether";

    const one: Rect = {
        x: 0,
        y: 0,
        width: 0,
        height: 0,
    };

    const two: Rect = {
        x: 0,
        y: 0,
        width: 10,
        height: 10,
    };

    print(isSameRect(one, one)); // "true"
    print(isSameRect(one, two)); // "false"
    ```

  </TabItem>
</Tabs>

## `read`

Allows you to evaluate middleware input when it is derivable, being able to take advantage of passing the [lifecycle](./middleware#middleware-state).

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local function middleware(input: Aether.Derivable<number>): Aether.Middleware
        return {
            name = "middleware",
            run = function(state)
                local value = Aether.read(input, state)
                -- ...
            end
        }
    end
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { read, type Middleware, type Derivable } from "@rbxts/aether";

    function middleware(input: Derivable<number>): Middleware {
        return {
            name: "middleware",
            run: (state) => {
                const value = read(input, state);
                // ...
            }
        }
    }
    ```

  </TabItem>
</Tabs>

## `getPaddingObject`

This is used for converting a [Padding](./types#padding) value into a usable [SideObject](./types#sideobject).

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local padding = Aether.getPaddingObject(5)

    --[[
        The padding value will be:

        top: 5,
        bottom: 5,
        left: 5,
        right: 5,
    ]]

    local padding = Aether.getPaddingObject({
        top = 5,
        bottom = 5,
    })

    --[[
        The padding value will be:

        top: 5,
        bottom: 5,
        left: 0,
        right: 0,
    ]]
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { getPaddingObject } from "@rbxts/aether";

    const padding = getPaddingObject(5);

    /**
     * The padding value will be:
     *
     * top: 5,
     * bottom: 5,
     * left: 5,
     * right: 5,
     */

    const padding = getPaddingObject({
        top: 5,
        bottom: 5,
    });

    /**
     * The padding value will be:
     *
     * top: 5,
     * bottom: 5,
     * left: 0,
     * right: 0,
     */
    ```

  </TabItem>
</Tabs>

:::note
When providing a `SideObject` value, any omitted sides are automatically evaluated as `0`.
:::
