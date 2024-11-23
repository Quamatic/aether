---
title: flip
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

Changes the placement of the floating element to keep it in view.

This prevents the floating element from overflowing along its side axis by flipping it to the opposite side by default.

<div class="text--center">
    ![image](/examples/flip.gif)
</div>

## Example

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    Aether.process(reference, target, {
        middleware = { flip() }
    })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process, flip } from "@rbxts/aether";

    process(reference, target, {
        middleware: [flip()]
    })
    ```

  </TabItem>
</Tabs>

:::note
This is an alternative to `autoPlacement()`, so only one of either can be used. See [how they differ here](./auto-placement#conflict-with-flip).
:::

:::danger
The placement returned from `process()` is **always** the final one, not necessarily the one you passed in as the “preferred” one.

This is, of course, due to the nature of `flip()`.
:::

## Input

This is the input you can pass to `flip()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Input = {
        mainAxis: boolean?,
        crossAxis: boolean?,
        fallbackAxisSideDirection: "none" | "start" | "end"?,
        flipAlignment: boolean?,
        fallbackPlacements: { Placement }?,
        fallbackStrategy: "best-fit" | "initial-placement"?,
        detectOverflowConfig: DetectOverflowConfig?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface Input {
        mainAxis?: boolean;
        crossAxis?: boolean;
        fallbackAxisSideDirection?: "none" | "start" | "end",
        flipAlignment?: boolean,
        fallbackPlacements?: Placement[],
        fallbackStrategy?: "best-fit" | "initial-placement",
        detectOverflowConfig?: DetectOverflowConfig;
    }
    ```

  </TabItem>
</Tabs>

### `fallbackAxisSideDirection`

Default value: `"none"`

Whether to allow fallback to the opposite axis if no placements along the preferred placement axis fit, and if so, which side direction along that axis to choose. If necessary, it will fallback to the other direction.

-   `"none"` signals that no fallback to the opposite axis should take place.
-   `"start"` represents `top` or `left`.
-   `"end"` represent `bottom` or `right`.

:::note
In RTL writing direction, the x-axis directions are reversed.
:::

### `flipAlignment`

Default value: `true`

When an alignment is specified, e.g. `"top-start"` instead of just `"top"`, this will flip to `"top-end"` if `start` doesn’t fit.

### `fallbackPlacements`

Default value: `nil`

This describes an **explicit** array of placements to try if the initial `placement` doesn’t fit on the axes in which overflow is checked.

:::note
The options `flipAlignment` and `fallbackAxisSideDirection` no longer have an effect if this option is explicitly specified, as they are only shortcuts to create a computed list of fallback placements. To ensure your explicit list is preferred, they will be ignored.
:::

### `fallbackStrategy`

Default value: `"best-fit"`

When no placements fit, then you’ll want to decide what happens. "best-fit" will use the placement which fits best on the checked axes. 'initial-placement' will use the initial placement specified.

### `detectOverflowConfig`

All of [detectOverflow()](../guides/collisions#config)'s config can be passed in this.

## Combining with [`shift()`](./shift)

If you’re allowing fallback to the opposite axis of the preferred placement via `fallbackAxisSideDirection` or `fallbackPlacements`, then you may want to determine what behavior you want when combining `flip()` with `shift()`.

If you want to ensure the placement side is preserved as best as possible without flipping, then you have two options to consider:

1. Disabling the cross axis check in `flip()` places top priority on `shift()` to do its work, with `flip()` only taking action when absolutely necessary. The preferred placement of the floating element will be conserved as much as possible.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local middleware = {
        Aether.flip({
            fallbackAxisSideDirection = "start",
            crossAxis = false,
        }),
        Aether.shift(),
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { flip, shift } from "@rbxts/aether";

    const middleware = [
        flip({
            fallbackAxisSideDirection: "start",
            crossAxis: false,
        }),
        shift(),
    ]
    ```

  </TabItem>
</Tabs>

2. Placing `shift()` before `flip()` in the array ensures it can do its work before `flip()` tries to change the placement. This is similar to the first technique above, but allows `flip()` to take action on its crossAxis too — useful if `shift()` has a limiter.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local middleware = {
        Aether.shift({
            limiter = Aether.limitShift(),
        }),
        Aether.flip({
            fallbackAxisSideDirection = "start",
        }),
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { flip, shift, limitShift } from "@rbxts/aether";

    const middleware = [
        shift({
            limiter: limitShift(),
        }),
        flip({
            fallbackAxisSideDirection: "start",
        }),
    ]
    ```

  </TabItem>
</Tabs>

:::note
The second method is only recommended if your placement is not edge aligned, e.g. `"top"` instead of `"top-start"`. This is because alignment flipping will no longer be possible since `shift()` takes over first.`

For reusable/generic components, you can use basic conditional checks on the supplied preferred placement to alter the ordering.
:::

## Conflict with [`autoPlacement()`](./auto-placement)
