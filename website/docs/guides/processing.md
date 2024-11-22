---
title: Processing
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

In order to process the position for a floating element next to its reference, Aether provides the `process()` function.

## Example

At its most basic, the function accepts two elements:

-   **Reference element** - also known as the anchor element, this is the element that is being _referred_ to for positioning. Often this is a button that triggers a floating popover like a tooltip or menu.
-   **Target element** - this is the element that floats next to the reference element, remaining anchored to it. This is the popover or tooltip itself.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local reference = Instance.new("TextButton")
    local target = Instance.new("Frame")

    local result = Aether.process(reference, target)
    target.Position = UDim2.fromOffset(result.x, result.y)
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process } from "@rbxts/aether";

    const reference = new Instance("TextButton");
    const target = new Instance("Frame");

    const result = process(reference, target);
    target.Position = UDim2.fromOffset(result.x, result.y);
    ```

  </TabItem>
</Tabs>

:::warning
To ensure positioning works smoothly, the floating element's `AnchorPoint` should _not_ be set - i.e., anything other than `(0, 0)`
:::

## Anchoring

Since `process()` is only a single function call, it only positions the floating element once.

To ensure it remains anchored to the reference element in a variety of scenarios, wrap the calculation in [autoUpdate()](./updating):

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local cleanup = Aether.autoUpdate(reference, target, function()
        local result = Aether.process(reference, target)
        print(result.x, result.y)
    end)

    -- ...later, when it's not needed anymore:
    cleanup()
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { autoUpdate, process } from "@rbxts/aether";

    const cleanup = autoUpdate(reference, target, () => {
        const result = process(reference, target);
        print(result.x, result.y);
    });

    // ...later, when it's not needed anymore:
    cleanup();
    ```

  </TabItem>
</Tabs>

## Input

This is the input you can pass to `process()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type ProcessConfig = {
        placement: Placement?,
        middleware: { Middleware }?,
        rtl: boolean?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface ProcessConfig {
        placement?: Placement;
        middleware?: Middleware[];
        rtl?: boolean;
    }
    ```

  </TabItem>
</Tabs>

### `placement`

Default value: `"bottom"`

Where to place the floating element relative to its reference element.

12 strings are available:

-   `"top"`
-   `"top-start"`
-   `"top-end"`
-   `"bottom"`
-   `"bottom-start"`
-   `"bottom-end"`
-   `"left"`
-   `"left-start"`
-   `"left-end"`
-   `"right"`
-   `"right-start"`
-   `"right-end"`

To further break down what these strings mean:

-   `"top"`, "`bottom`", `"left"`, and `"right"` are _sides_.
-   `"-start"` and `"-end"` are _alignments_.

:::note
You aren't limited to just these 12 placements. [offset()](../middleware/offset#creating-custom-placements) allows you to create _any_ placement.
:::

### `middleware`

When you want granular control over how the floating element is positioned, middleware are used. They read the current coordinates, optionally alter them, and/or provide data for rendering. They compose and work together to produce the final coordinates which you receive as `x` and `y` parameters.

The following are included in the package:

#### Placement modifiers

These middleware alter the base placement coordinates.

-   [`offset()`](../middleware/offset) modifies the placement to add distance or margin between the reference and floating elements.
-   [`inline()`](../middleware/offset) positions the floating element relative to individual client rects rather than the bounding box for better precision.

#### Visibility optimizers

These middleware alter the coordinates to ensure the floating element stays on screen optimally.

-   [`shift()`](../middleware/shift) prevents the floating element from overflowing a clipping container by shifting it to stay in view.
-   [`flip()`](../middleware/flip) prevents the floating element from overflowing a clipping container by flipping it to the opposite placement to stay in view.
-   [`autoPlacement()`](../middleware/auto-placement) automatically chooses a placement for you using a “most space” strategy.
-   [`size()`](../middleware/size) resizes the floating element, for example so it will not overflow a clipping container, or to match the width of the reference element.

#### Data providers

These middleware only provide data and do not alter the coordinates.

-   [`arrow()`](../middleware/arrow) provides data to position an inner element of the floating element such that it is centered to its reference element.
-   [`hide()`](../middleware/hide) provides data to hide the floating element in applicable situations when it no longer appears attached to its reference element due to different clipping contexts.

#### Custom

You can also craft your own custom middleware to extend the behavior of the library. Read Middleware to learn how to create your own.

## Return value

`process()` returns the following type:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type ProcessResult = {
        x: number,
        y: number,
        placement: Placement,
        data: MiddlewareData,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface ProcessResult {
        x: number;
        y: number;
        placement: Placement;
        data: MiddlewareData;
    }
    ```

  </TabItem>
</Tabs>

### `x`

The x-coordinate of the floating element.

### `y`

The y-coordinate of the floating element.

### `placement`

The final placement of the floating element, which may be different from the initial or preferred one passed in due to middleware modifications. This allows you to know which side the floating element is placed at.

### `data`

The data returned by any middleware used.

## Virtual Reference Elements

The `reference` element can be input as a [virtual element](./virtual-elements). This can be used when you need something like a custom reference area,
or more control over your boundary.

## Cache

A cache is used during processing processing for storing element boundaries and scales. This is so processing speed is increased, such as during multiple lifecycle resets.

The cache only lives for a single `process()` call.
