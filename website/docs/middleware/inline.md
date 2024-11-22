---
title: inline
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

Improves positioning for inline reference elements that span over multiple lines.

This is useful for reference elements such as highlighted text or range selections, as the default positioning using `getBoundingRect()` may appear “detached” when measuring over the bounding box.

:::note
The concept of [ranges](https://developer.mozilla.org/en-US/docs/Web/API/Range) don't exist in Roblox, but since this is a port, the inline feature is still included.

Typically, inline is used for elements like `<span>` in HTML, allowing for inline text behavior. To achieve similar functionality in Roblox, you would need to implement your own solution for this.
:::

## Input

This is the input you can pass to `inline()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Input = {
        x: number?,
        y: number?,
        padding: Padding?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface Input {
        x?: number;
        y?: number;
        padding?: Padding;
    }
    ```

  </TabItem>
</Tabs>

### `x`

Default value: `nil`

This is the screen-relative x-axis coordinate which can be passed in to choose a rect.

### `y`

Default value: `nil`

This is the screen-relative y-axis coordinate which can be passed in to choose a rect.

### `padding`

Default value: `2`

This describes the padding around a disjoined rect when choosing it.

## Choosing a rect

By default, `inline()` infers which of the `BoundingRect`s to choose based on the placement. However, you may want a different rect to be chosen.

For instance, if the user hovered over the last bounding rect, you likely want the floating element to be placed there. This logic is only applied when the reference element’s rects are disjoined.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    reference.MouseEnter:Connect(function(x, y)
        local result = Aether.process(reference, target, {
            middleware = { Aether.inline({ x = x, y = y }) }
        })

        -- ...
    end)
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process, inline } from "@rbxts/aether";

    reference.MouseEnter.Connect((x, y) => {
        const result = process(reference, target, {
            middleware: [inline({ x, y })],
        });

        // ...
    })
    ```

  </TabItem>
</Tabs>

## Order

`inline()` should generally be placed toward the beginning of your middleware array, before `flip()` (if used).
