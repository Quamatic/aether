---
title: hide
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

A data provider that allows you to hide the floating element in applicable situations.

This is useful for situations where you want to hide the floating element because it appears detached from the reference element (or attached to nothing).

<div class="text--center">
    ![image](/examples/hide.gif)
</div>

In the above example, the floating element turns partially transparent once it has `escaped` the reference element’s clipping context. Once the reference element is hidden, it hides itself.

## Example

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local result = Aether.process(reference, target, {
        middleware = { Aether.hide() } -- Default strategy is "reference-hidden"
    })

    if result.data.hide.referenceHidden then
        -- ...reference is hidden!
    end
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process, hide } from "@rbxts/aether";

    const result = process(reference, target, {
        middleware: [hide()] // Default strategy is "reference-hidden"
    });

    if (result.data.hide?.referenceHidden) {
        // ...reference is hidden!
    }
    ```

  </TabItem>
</Tabs>

## Input

This is the input you can pass to `hide()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Input = {
        strategy: "reference-hidden" | "escaped",
        detectOverflowConfig: DetectOverflowConfig?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface Input {
        strategy?: "reference-hidden" | "escaped";
        detectOverflowConfig?: DetectOverflowConfig;
    }
    ```

  </TabItem>
</Tabs>

### `strategy`

Default value: `reference-hidden`

The strategy used to determine when to hide the floating element.

-   "reference-hidden" - The `reference` element will be checked for overflow relative to its clipping context.
-   "escaped" - The `target` element will be checked if it has fully clipped out of (hence "escaped") the `reference` element's clipping context.

If you’d like to use multiple strategies, call `hide()` multiple times in your middleware array with different options.

### `detectOverflowConfig`

All of [detectOverflow()](../guides/collisions#config)'s config can be passed in this.

## Data

`hide()` passes the following middleware data:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Data = {
        referenceHidden: boolean?,
        referenceHiddenOffsets: SideObject?,
        escaped: boolean?,
        escapedOffsets: SideObject?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface Data {
        referenceHidden?: boolean;
        referenceHiddenOffsets?: SideObject;
        escaped?: boolean;
        escapedOffsets?: SideObject;
    }
    ```

  </TabItem>
</Tabs>

Depending on the strategy used, these options may exist in the data object:

### `referenceHidden`

Provided when strategy is `"reference-hidden"`

Determines whether the reference element is fully clipped, and is therefore hidden from view.

Note that "hidden" means clipping, the `Visible` property is not considered.

### `referenceHiddenOffsets`

Provided when strategy is `"reference-hidden"`

A side object containing overflow offsets.

### `escaped`

Provided when strategy is `"escaped"`

Determines whether the floating element has “escaped” the reference’s clipping context and appears fully detached from it.

### `escapedOffsets`

Provided when strategy is `"escaped"`

A side object containing overflow offsets.

## Order

`hide()` should generally be placed at the end of your middleware array.
