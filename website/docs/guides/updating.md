---
title: Updating
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

To keep a floating element anchored to its reference, an update method is essential.

Although you can create a custom update method, Aether provides a built-in `autoUpdate()` function that simplifies this process.

## Example

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    Aether.autoUpdate(reference, target, function()
        -- ...perform processing
    end)
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { autoUpdate } from "@rbxts/aether";

    autoUpdate(reference, target, () => {
        // ...perform processing
    })
    ```

  </TabItem>
</Tabs>

:::danger
It's important that this function is only used/set-up during the lifecycle of a floating element (e.g., open on the screen and cleaned up when it isnt).
Otherwise, it can cause severe performance degradation especially with many floating elements.
:::

## Input

This is the input you can pass to `autoUpdate()`:

### `reference`

The reference element to check for updating.

### `target`

The target element to check for updating.

### `update`

A callback function that executes when an update is triggered.
