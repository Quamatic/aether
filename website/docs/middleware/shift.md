---
title: shift
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

Shifts the floating element to keep it in view.

This prevents the floating element from overflowing along its axis of alignment, thereby preserving the side it’s placed on.

<div class="text--center">
    ![image](/examples/shift.gif)
</div>

## Example

<Tabs groupId="package-manager">
  <TabItem value="wally" label="wally" default>

    ```luau
    local Aether = require(path.to.aether)

    local result = Aether.process(reference, target, {
        middleware = { Aether.shift() }
    })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process, shift } from "@rbxts/aether"

    const result = process(reference, target, {
        middleware: [shift()],
    })
    ```

  </TabItem>
</Tabs>

## Order

`shift()` should generally be placed at the end of your middleware away, or after middleware that can produce different placements.

## Input

This is the input you can pass to `shift()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="wally" default>

    ```luau
    type Input = {
        mainAxis: boolean?,
        crossAxis: boolean?,
        limiter: ((state: MiddlewareState) -> Position)?,
        detectOverflowConfig: DetectOverflowConfig?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface Input {
        mainAxis?: boolean;
        crossAxis?; boolean;
        limiter?: (state: MiddlewareState) => Position,
        detectOverflowConfig?: DetectOverflowConfig,
    }
    ```

  </TabItem>
</Tabs>

### `mainAxis`

Default value: `true`

This is the main axis in which shifting is applied.

-   `x`-axis for `"top"` and `"bottom"` placements
-   `y`-axis for `"left"` and `"right"` placements

### `crossAxis`

Default value: `false`

This is the cross axis in which shifting is applied, the opposite axis of `mainAxis`.

Enabling this can lead to the floating element **overlapping** the reference element, which may not be desired and is often replaced by the [flip()](./flip) middleware.

### `limiter`

Default value: `nil` (no-op)

This accepts a function that limits the shifting done, in order to prevent detachment or “overly-eager” behavior. The behavior is to stop shifting once the opposite edges of the elements are aligned.

### `detectOverflowConfig`

Default value: `nil`

All of [detectOverflow()](../guides/collisions#config)'s config can be passed in this.

## Data

`shift()` passes the following middleware data:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Data = {
        x: number,
        y: number,
        enabled: {
            x: boolean,
            y: boolean,
        }
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface Data {
        x: number;
        y: number;
        enabled: {
            x: boolean;
            y: boolean;
        };
    }
    ```

  </TabItem>
</Tabs>

`x` and `y` represent how much the floating element has been shifted along that axis. The values are offsets, and therefore can be negative.

The axes in `enabled` are relative to the current placement's main/cross axis, and only based on the values of [mainAxis](#mainaxis) and [crossAxis](#crossaxis)
