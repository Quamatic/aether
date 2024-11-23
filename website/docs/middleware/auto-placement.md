---
title: autoPlacement
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

Chooses the placement that has the most space available automatically.

This is useful when you don’t know which placement will be best for the floating element, or don’t want to have to explicitly specify it.

<div class="text--center">
    ![image](/examples/auto-placement.gif)
</div>

## Example

:::note
This is an alternative to `flip()`, so only one of either can be used. See [how they differ here](#conflict-with-flip).
:::

## Input

This is the input you can pass to `autoPlacement()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Input = {
        crossAxis: boolean?,
        alignment: Alignment?,
        autoAlignment: boolean?,
        allowedPlacements: { Placement }?,
        detectOverflowConfig: DetectOverflowConfig?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface Input {
        crossAxis?: boolean;
        alignment?: Aligment;
        autoAlignment?: boolean;
        allowedPlacements?: Placement[];
        detectOverflowConfig?: DetectOverflowConfig;
    }
    ```

  </TabItem>
</Tabs>

### `crossAxis`

Default value: `false`

Determines whether a “most space” strategy is also used for the cross axis (which runs along the alignment of the floating element). May be desirable when the `allowedPlacements` are all on the same axis.

### `alignment`

Default value: `nil`

Without options, `autoPlacement()` will choose any of the Side placements which fit best, i.e. `"top"`, `"right"`, `"bottom"`, or `"left"`.

By specifying an alignment, it will choose those aligned placements.

### `autoAlignment`

Default value: `true`

When `alignment` is specified, this describes whether to automatically choose placements with the opposite alignment if they fit better.

### `allowedPlacements`

Default value: computed subset of all placements

Describes the placements which are allowed to be chosen.

### `detectOverflowConfig`

All of [detectOverflow()](../guides/collisions#config)'s config can be passed in this.

## Conflict with [`flip()`](./flip)

`flip()` and `autoPlacement()` cannot be used together inside the same middleware array;
make sure you choose only one of them to use.

The reason is they both try to perform work on the placement but with opposing strategies. Therefore, they will continually try to change the result or work of the other one, leading to a reset loop.

-   `flip()` uses a fallback “no space” strategy. Ensures the preferred placement is kept unless there is no space left.
-   `autoPlacement()` uses a primary “most space” strategy. Always chooses the placement with the most space available.
