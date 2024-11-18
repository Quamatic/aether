---
title: arrow
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

Provides positioning data for an arrow element (triangle or caret) inside the floating element, such that it appears to be pointing toward the center of the reference element.

This is useful to add an additional visual cue to the floating element about which element it is referring to.

## Example

The layout box of the arrow element should be a square with equal width and height. Inner or pseudo-elements may have a different aspect ratio.

Pass the `element` to the `arrow()` middleware and assign the dynamic styles using the coordinates data available in `data.arrow`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local arrow = ... -- This should be a gui object.

    local result = Aether.process(reference, target, {
        middleware = {
            Aether.arrow({
                element = arrow,
            })
        }
    })

    local data = result.data.arrow
    arrow.Position = UDim2.fromOffset(data.x or 0, data.y or 0)
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process, arrow } from "@rbxts/aether"

    const arrow = ... // This should be a GuiObject

    const result = process(reference, target, {
        middleware: [
            arrow({ element: arrow })
        ]
    })

    // This is an odd looking example, but could be much better

    // Just note that "arrow" could not exist (the element could possibly be undefined),
    // and the selected axes (x or y) is based on the placement.

    const data = result.data?.arrow
    arrow.Position = UDim2.fromOffset(data?.x ?? 0, data?.y ?? 0)
    ```

  </TabItem>
</Tabs>

:::warning
Unlike the floating element, which has both coordinates defined at all times, the arrow only has one defined. Due to this, either `x` or `y` will be `nil`, depending on the side of placement.
:::

This middleware is designed only to position the arrow on one axis (`x` for `"top"` or `"bottom"` placements). The other axis is considered “static”, which means it does not need to be positioned dynamically.

You may however want to position **both** axes statically in the following scenario:

-   The reference element is either wider or taller than the floating element;
-   The floating element is using an edge alignment (`-start` or `-end` placement).

## Input

This is the input you can pass to `arrow()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Input = {
        element: GuiObject?,
        padding: Padding?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface Input {
        element?: GuiObject;
        padding?: Padding;
    }
    ```

  </TabItem>
</Tabs>

### `element`

Default value: `nil`

This is the arrow element to be positioned, which **must** be a child of the floating element.

### `padding`

Default value: `0`

This describes the [Padding](../types#padding) between the arrow and the edges of the floating element.

## Data

`arrow()` passes the following middleware data:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Data = {
        x: number?,
        y: number?,
        centerOffset: number,
        alignmentOffset: number?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface Data {
        x?: number;
        y?: number;
        centerOffset: number;
        alignmentOffset?: number;
    }
    ```

  </TabItem>
</Tabs>

### `x`

This property exists if the arrow should be offset on the x-axis.

### `y`

This property exists if the arrow should be offset on the y-axis.

### `centerOffset`

This property describes where the arrow actually is relative to where it could be if it were allowed to overflow the floating element in order to stay centered to the reference element.

This enables two useful things:

-   You can hide the arrow if it can’t stay centered to the reference, i.e. `centerOffset ~= 0`
-   You can interpolate the shape of the arrow (e.g. skew it) so it stays centered as best as possible.

### `alignmentOffset`

This property exists if the reference is small enough that the arrow's padding causes it to
to point to nothing for an aligned placement.

## Order

`arrow()` should generally be placed toward the end of your middleware array, after `shift()` or `autoPlacement()` (if used).
