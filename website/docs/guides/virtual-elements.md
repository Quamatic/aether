---
title: Virtual Elements
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

You aren't limited to just `GuiObject`'s for reference areas, you can create custom ones as well using virtual elements.

Virtual elements are for positioning floating element relative to a custom reference area, useful for context menus, range selections, following the cursor, and more.

## Example

The most basic virtual element is a plain object that has a `getBoundingRect` method, which mimics a real element’s `AbsoluteSize` and `AbsolutePosition`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local virtualElement: Aether.VirtualElement = {
        getBoundingRect = function()
            return {
                x = 0,
                y = 0,
                top = 0,
                left = 0,
                bottom = 20,
                right = 20,
                width = 20,
                height = 20,
            }
        end
    }

    Aether.process(virtualElement, reference)
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process, type VirtualElement } from "@rbxts/aether";

    const virtualElement: VirtualElement = {
        getBoundingRect: () => {
            return {
                x: 0,
                y: 0,
                top: 0,
                left: 0,
                bottom: 20,
                right: 20,
                width: 20,
                height: 20,
            }
        }
    }

    process(virtualElement, reference)
    ```

  </TabItem>
</Tabs>

To better understand the properties and how'd they work for a "real" element:

-   `x` - `AbsolutePosition.X`
-   `y` - `AbsolutePosition.Y`
-   `top` - `AbsolutePosition.Y`
-   `left` - `AbsolutePosition.X`
-   `bottom` - `AbsolutePosition.Y + AbsoluteSize.Y`
-   `right` - `AbsolutePosition.X + AbsoluteSize.X`
-   `width` - `AbsoluteSize.X`
-   `height` - `AbsoluteSize.Y`

## `contextElement`

This property is useful if your `getBoundingRect` method is derived from a real element, to ensure clipping and position update detection works as expected.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local contextElement = Instance.new("Frame")

    local virtualElement: Aether.VirtualElement = {
        getBoundingRect = function()
            return {
                x = 0,
                y = 0,
                top = 0,
                left = 0,
                bottom = 20,
                right = 20,
                width = 20,
                height = 20,
            }
        end,
        contextElement = contextElement,
    }

    Aether.process(virtualElement, reference)
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process, type VirtualElement } from "@rbxts/aether";

    const contextElement = new Instance("Frame")

    const virtualElement: VirtualElement = {
        getBoundingRect: () => {
            return {
                x: 0,
                y: 0,
                top: 0,
                left: 0,
                bottom: 20,
                right: 20,
                width: 20,
                height: 20,
            }
        },
        contextElement,
    }

    process(virtualElement, reference)
    ```

  </TabItem>
</Tabs>

## `getNativeRects`

This property is useful when using range selections and the [`inline()`](../middleware/inline) middleware.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local virtualElement: Aether.VirtualElement = {
        getBoundingRect = function()
            ...
        end,
        getNativeRects = function()
            return {
                { x = 0, y = 0, width = 10, height = 10 },
                { x = 10, y = 0, width = 10, height = 10 },
                { x = 20, y = 0, width = 10, height = 10 }
            }
        end,
    }

    Aether.process(virtualElement, reference)
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process, type VirtualElement } from "@rbxts/aether";

    const virtualElement: VirtualElement = {
        getBoundingRect: () => ...,
        getNativeRects: () => {
            return [
                { x: 0, y: 0, width: 10, height: 10 },
                { x: 10, y: 0, width: 10, height: 10 },
                { x: 20, y: 0, width: 10, height: 10 }
            ]
        }
    }

    process(virtualElement, reference)
    ```

  </TabItem>
</Tabs>
