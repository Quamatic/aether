---
title: Vide Bindings
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

This package provides `vide` bindings for Aether.

## Installation

<Tabs groupId="package-manager">
  <TabItem value="wally" label="wally" default>

    ```toml
    [dependencies]
    AetherVide = "quamatic/aether-vide@VERSION"
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```sh
    npm install @rbxts/aether-vide
    yarn add @rbxts/aether-vide
    pnpm add @rbxts/aether-vide
    ```

  </TabItem>
</Tabs>

## Usage

The package exposes a composable named `useFloating()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Vide = require(path.to.vide)
    local AetherVide = require(path.to.aether-vide)

    local create = Vide.create
    local source = Vide.source
    local action = Vide.action

    local function Component()
        local reference = source(nil)
        local target = source(nil)
        local floating = AetherVide.useFloating(reference, target)

        return create "Frame" {
            create "TextButton" {
                action(reference)
            },

            create "TextLabel" {
                Position = function()
                    return UDim2.fromOffset(floating.x(), floating.y())
                end,

                Text = "Tooltip",

                action(target)
            },
        }
    end
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```tsx
    import Vide, { source, action } from "@rbxts/vide"
    import { useFloating } from "@rbxts/aether-vide"

    function Component() {
        const reference = source(undefined);
        const target = source(undefined);
        const floating = useFloating(reference, target);

        return (
            <frame>
                <textbutton action={reference} />
                <textlabel
                    Position={() => UDim2.fromOffset(floating.x(), floating.y())}
                    Text="Tooltip"
                    action={target}
                />
            </frame>
        )
    }
    ```

  </TabItem>
</Tabs>

This example will position the floating `TextLabel` at the **bottom center** of the `TextButton` element by default.

-   `reference` is the reference (or anchor) element that is being referred to for positioning.
-   `target` is the floating element that is being positioned relative to the reference element.
-   `floating` is the result returned from `useFloating()`

## Return value

The composable returns all the values from [`process()`](./guides/processing#return-value), but in source form to work with Vide. This includes data about the final placement and middleware data which are useful when rendering.

## Options

The composable accepts all the [options from `process()`](./guides/processing#input), which allows you to customize the position. Here’s an example:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)
    local AetherVide = require(path.to.aether-vide)

    -- Inside your Vide component

    AetherVide.useFloating(reference, target, {
        placement = "right",
        middleware = { Aether.offset(10), Aether.flip(), Aether.shift() },
    })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { offset, flip, shift } from "@rbxts/aether";
    import { useFloating } from "@rbxts/aether-vide";

    useFloating(reference, target, {
        placement: "right",
        middleware: [offset(10), flip(), shift()]
    });
    ```

  </TabItem>
</Tabs>

It also accepts `source` values:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Vide = require(path.to.vide)
    local Aether = require(path.to.aether)
    local AetherVide = require(path.to.aether-vide)

    local source = Vide.source

    -- Inside your Vide component
    local placement = source("right")
    local middleware = source({ Aether.offset(10), Aether.flip(), Aether.shift() })

    AetherVide.useFloating(reference, target, {
        placement = placement,
        middleware = middleware,
    })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import Vide, { source } from "@rbxts/vide";
    import { offset, flip, shift } from "@rbxts/aether";
    import { useFloating } from "@rbxts/aether-vide";

    // Inside your Vide component
    const placement = source("right");
    const middleware = source([offset(10), flip(), shift()]);

    useFloating(reference, target, {
        placement,
        middleware,
    });
    ```

  </TabItem>
</Tabs>

## Anchoring

The position is only calculated once on render, or when the reference or floating elements changed — for example, the floating element get mounted via `show()` rendering.

To ensure the floating element remains anchored to its reference element in a variety of scenarios without detaching, you can pass the [`autoUpdate`](./guides/updating) utility to the `whileElementsMounted` prop:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)
    local AetherVide = require(path.to.aether-vide)

    -- Inside your Vide component
    AetherVide.useFloating(reference, target, {
        whileElementsMounted = Aether.autoUpdate
    })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { autoUpdate } from "@rbxts/aether";
    import { useFloating } from "@rbxts/aether-vide";

    useFloating(reference, target, {
        whileElementsMounted: autoUpdate,
    });
    ```

  </TabItem>
</Tabs>

To pass options to `autoUpdate`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)
    local AetherVide = require(path.to.aether-vide)

    -- Inside your Vide component
    AetherVide.useFloating(reference, target, {
        whileElementsMounted = function(reference, target, update)
            local cleanup = Aether.autoUpdate(reference, target, update, "render")
            -- Important! Always return the cleanup function
            return cleanup
        end,
    })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { autoUpdate } from "@rbxts/aether";
    import { useFloating } from "@rbxts/aether-vide";

    useFloating(reference, target, {
        whileElementsMounted: (reference, target, update) => {
            const cleanup = autoUpdate(reference, target, update, "render");
            // Important! Always return the cleanup function
            return cleanup;
        },
    });
    ```

  </TabItem>
</Tabs>

## Manual updating

While `autoUpdate` covers most cases where the position of the floating element must be updated, it does not mean you are strictly limited to using it.

The composable returns an `update()` function to update the position at will:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Vide = require(path.to.vide)
    local Aether = require(path.to.aether)
    local AetherVide = require(path.to.aether-vide)

    local create = Vide.create
    local changed = Vide.changed

    local function Component()
        local floating = AetherVide.useFloating(reference, target)

        return create "Frame" {
            changed("AbsoluteSize", floating.update),
        }
    end
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```tsx
    import Vide from "@rbxts/vide";
    import { useFloating } from "@rbxts/aether-vide";

    function Component() {
        const { update } = useFloating(reference, target);

        return <frame AbsoluteSizeChanged={update}>
    }
    ```

  </TabItem>
</Tabs>
