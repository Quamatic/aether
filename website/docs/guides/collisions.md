---
title: Collisions
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

Aether provides a way of detecting (and avoiding) collisions, via `detectOverflow()`.

`detectOverflow()` detects when the floating or reference element is overflowing a clipping container or custom boundary.

Visibility optimizer middleware use this function for **collision detection**, making it useful for your own custom middleware that do the same.

## Understanding Boundaries

A boundary (or clipping container) is an area that causes child elements inside it to be clipped if they overflow it.

`detectOverflow` takes two types of boundaries:

-   `"boundary"` which is the area that overflow will be checked _relative to_.
-   `"rootBoundary"` which is the "root" area that overflow will be checked _relative to_. This sounds like it has the same purpose as `"boundary"`, but
    the "root" is there because it involves screen boundaries.

More info can be found [in the config](#config).

## Example

Here's an example of a custom middleware using `detectOverflow()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local middleware: Aether.Middleware = {
        name = "middleware",
        run = function(state)
            local overflow = Aether.detectOverflow(state)
            return {}
        end,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { detectOverflow, type Middleware } from "@rbxts/aether";

    const middleware: Middleware = {
        name: "middleware",
        run: (state) => {
            const overflow = detectOverflow(state);
            return {}
        },
    };
    ```

  </TabItem>
</Tabs>

The returned value, `overflow`, is a [`SideObject`](../types#sideobject) containing side properties with numbers representing offsets.

-   A positive number means the element is overflowing the clipping boundary by that number of pixels. (more pixels = further away from the boundary)
-   A negative number means the element has that number of pixels left before it will overflow the clipping boundary. (less pixels = closer to the boundary)
-   `0` means the side lies flush with the clipping boundary.

## Config

`detectOverflow()` takes a config as a second argument:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type DetectOverflowConfig = {
        boundary: Boundary?,
        rootBoundary: RootBoundary?,
        elementContext: ElementContext?,
        altBoundary: boolean?,
        padding: Padding?
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface DetectOverflowConfig {
        boundary?: Boundary;
        rootBoundary?: RootBoundary;
        elementContext?: ElementContext;
        altBoundary?: boolean;
        padding?: Padding;
    }
    ```

  </TabItem>
</Tabs>

### `boundary`

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Boundary = "clipping-ancestors" | GuiObject | { GuiObject } | Rect
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    type Boundary = "clipping-ancestors" | GuiObject | GuiObject[] | Rect;
    ```

  </TabItem>
</Tabs>

This describes the clipping element(s) or area that overflow will be checked relative to. The default is `"clipping-ancestors"`, which are the overflow ancestors which will cause the element to be clipped.

You can also pass multiple `GuiObject`s, or a custom [`Rect`](../types#rect).

:::note
An "overflow ancestor" is a `GuiObject` that has `ClipsDescendants` enabled.
:::

### `rootBoundary`

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type RootBoundary = "layer-collector" | Rect
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    type RootBoundary = "layer-collector" | Rect;
    ```

  </TabItem>
</Tabs>

This describes the root boundary that the element will be checked for overflow relative to. The default is `"layer-collector"`, which is the ancestor [LayerCollector](https://create.roblox.com/docs/reference/engine/classes/LayerCollector) that contains the element. Most of the time, this could just be known as the screen area.

You may also pass a [`Rect`](../types#rect) object to define a custom boundary area (relative to the screen).

### `elementContext`

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type ElementContext = "reference" | "target"
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    type ElementContext = "reference" | "target";
    ```

  </TabItem>
</Tabs>

By default, the `"target"` element is the one being checked for overflow.

But you can also change the context to `"reference"` to instead check its overflow relative to its clipping boundary.

### `altBoundary`

This is a boolean value which determines whether to check the alternate `elementContext`’s boundary.

For instance, if the `elementContext` is `"target"`, and you enable this option, then the boundary in which overflow is checked for is the `"reference"`’s boundary. This only applies if you are using the default `"clipping-ancestors"` string as the boundary.

### `padding`

This describes the virtual [Padding](../types#padding) around the boundary to check for overflow.
