---
title: offset
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

Translates the floating element along the specified axes.

This lets you add distance (margin or spacing) between the reference and floating element, slightly alter the placement, or even create [custom placements](#creating-custom-placements)

## Example

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local result = Aether.process(reference, target, {
        middleware = { Aether.offset(5) }
    })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process, offset } from "@rbxts/aether";

    const result = process(reference, target, {
        middleware: [offset(5)],
    });
    ```

  </TabItem>
</Tabs>

In this example, the target element would be offset by 5 pixels from its calculated placement.

## Order

`offset()` should generally be placed at the beginning of your middleware array.

## Input

This is the input you can pass to `offset()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Input = number | {
        mainAxis: number?,
        crossAxis: number?,
        alignmentAxis: number?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    type Input = number | {
        mainAxis?: number;
        crossAxis?: number;
        alignmentAxis?: number;
    }
    ```

  </TabItem>
</Tabs>

A number represents the distance (gutter or margin) between the floating element and the reference element.
This is shorthand for `mainAxis`.

Alternatively, you can pass an object if customization per-axis is needed:

### `mainAxis`

Default value: `0`

The axis that runs along the side of the floating element. Represents the distance (gutter or margin) between the floating element and the reference element.

### `crossAxis`

Default value: `0`

The axis that runs along the alignment of the floating element. Represents the skidding between the floating element and the reference element.

### `alignmentAxis`

Default value: `nil`

The same axis as `crossAxis` but applies only to aligned placements and inverts the `end` alignment. When set to a number, it overrides the `crossAxis` value.

A positive number will move the floating element in the direction of the opposite edge to the one that is aligned, while a negative number the reverse.

## Creating custom placements

While only 12 possible placements exist as part of the package, you can use `offset()` to effectively create _any_ placement you want!

For example, creating a diagonal placement:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local result = Aether.process(reference, target, {
        placement = "top-start",
        middleware = {
            Aether.offset(function(state)
                return {
                    alignmentAxis = -state.rects.target.width
                }
            end),
        },
    })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process, offset } from "@rbxts/aether"

    const result = process(reference, target, {
        placement = "top-start",
        middleware = [
            offset((state) => ({
                alignmentAxis: -state.rects.target.width
            })),
        ],
    })
    ```

  </TabItem>
</Tabs>
