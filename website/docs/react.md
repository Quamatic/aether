---
title: React Bindings
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

This package provides `react` bindings for Aether.

## Installation

<Tabs groupId="package-manager">
  <TabItem value="wally" label="wally" default>

    ```toml
    [dependencies]
    AetherReact = "quamatic/aether-react@0.1.1"
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```sh
    npm install @rbxts/aether-react
    yarn add @rbxts/aether-react
    pnpm add @rbxts/aether-react
    ```

  </TabItem>
</Tabs>

## Usage

The package exposes a hook named `useFloating()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local React = require(path.to.react)
    local AetherReact = require(path.to.aether-react)

    local e = React.createElement

    local function Component()
        local floating = AetherReact.useFloating()

        return e("Frame", {}, {
            Reference = e("TextButton", {
                Text = "Button",
                ref = floating.refs.setReference,
            }),

            Target = e("TextLabel", {
                Position = UDim2.fromOffset(floating.x, floating.y),
                Text = "Tooltip",
                ref = floating.refs.setTarget,
            })
        })
    end
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```tsx
    import React from "@rbxts/react";
    import { useFloating } from "@rbxts/aether-react";

    function Component() {
        const { x, y, refs } = useFloating();

        return (
            <frame>
                <textbutton Text="Button" ref={refs.setReference} />
                <textlabel Position={UDim2.fromOffset(x, y)} Text="Tooltip" ref={refs.setTarget} />
            </frame>
        )
    }
    ```

  </TabItem>
</Tabs>

This example will position the floating `TextLabel` at the **bottom center** of the `TextButton` element by default.

## Input

This is the input you can pass to `useFloating()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type UseFloatingConfig = {
        placement: Placement?,
        middleware: { ReactiveMiddleware }?,
        elements: {
            reference: ReferenceElement?,
            target: GuiObject?,
        }?,
        whileElementsMounted: (reference: ReferenceElement, target: GuiObject, update: () -> ()) -> () -> ()?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface UseFloatingConfig {
        placement?: Placement;
        middleware?: ReactiveMiddleware[];
        elements?: {
            reference?: ReferenceElement;
            target?: GuiObject;
        };
        whileElementsMounted?: (reference: ReferenceElement, target: GuiObject, update: () => void) => () => void;
    }
    ```

  </TabItem>
</Tabs>

### `placement`

Default value: `"bottom`"

The placement of the floating element relative to the reference element.

Available placement types are found [here](./guides/processing#placement)

### `middleware`

An array of middleware objects that change the positioning of the floating element.

When you want granular control over how the floating element is positioned, middleware are used. They read the current coordinates, optionally alter them, and/or provide data for rendering. They compose and work together to produce the final coordinate.

You can learn more about middleware [here](./middleware)

### `elements`

An object of elements passed to the hook, which is useful for externally passing them, as an alternative to the refs object setters.

The elements must be held in state (not plain refs) to ensure that they are reactive:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local React = require(path.to.react)
    local AetherReact = require(path.to.aether-react)

    local e = React.createElement

    local function Component()
        local reference, setReference = React.useState(nil)
        local floating = AetherReact.useFloating({
            elements = {
                reference = reference,
            }
        })

        return e("Frame", {}, {
            Reference = e("TextButton", {
                Text = "Button",
                ref = setReference,
            }),

            Target = e("TextLabel", {
                Position = UDim2.fromOffset(floating.x, floating.y),
                Text = "Tooltip",
                ref = floating.refs.setTarget,
            })
        })
    end
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```tsx
    import React, { useState } from "@rbxts/react";
    import { useFloating } from "@rbxts/aether-react";

    function Component() {
        const [reference, setReference] = useState(undefined);
        const { x, y, refs } = useFloating({
            elements: {
                reference,
            },
        });

        return (
            <frame>
                <textbutton Text="Button" ref={setReference} />
                <textlabel Position={UDim2.fromOffset(x, y)} Text="Tooltip" ref={refs.setTarget} />
            </frame>
        )
    }
    ```

  </TabItem>
</Tabs>

### `whileElementsMounted`

A function that is called when the reference and floating elements are mounted, and returns a cleanup function called when they are unmounted.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local AetherReact = require(path.to.aether-react)

    AetherReact.useFloating({
        whileElementsMounted = function(reference, target, update)
            -- ...
            return function()
                -- ...
            end
        end,
    })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```tsx
    import { useFloating } from "@rbxts/aether-react";

    useFloating({
        whileElementsMounted: (reference, target, update) => {
            // ...
            return () => {
                // ...
            }
        }
    });
    ```

  </TabItem>
</Tabs>

This allows you to pass [`autoUpdate()`](./guides/updating) whose signature matches the option, to ensure the floating element remains anchored to the reference element:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)
    local AetherReact = require(path.to.aether-react)

    AetherReact.useFloating({
        whileElementsMounted = Aether.autoUpdate,
    })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```tsx
    import { autoUpdate } from "@rbxts/aether";
    import { useFloating } from "@rbxts/aether-react";

    useFloating({
        whileElementsMounted: autoUpdate,
    });
    ```

  </TabItem>
</Tabs>

## Return value

The hook returns the following type:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type UseFloatingReturn = {
        placement: Placement,
        x: number,
        y: number,
        data: MiddlewareData,
        update: () -> (),
        refs: {
            reference: React.MutableRefObject<ReferenceElement?>,
            target: React.MutableRefObject<GuiObject?>,
            setReference: (node: ReferenceElement?) -> (),
            setTarget: (node: GuiObject?) -> (),
        },
        elements: {
            reference: ReferenceElement?,
            target: GuiObject?,
        }
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface UseFloatingReturn {
        placement: Placement;
        x: number;
        y: number;
        data: MiddlewareData;
        update: () => void;
        refs: {
            reference: React.MutableRefObject<ReferenceElement | undefined>;
            target: React.MutableRefObject<GuiObject | undefined>;
            setReference: (node?: ReferenceElement) => void;
            setTarget: (node?: GuiObject) => void;
        };
        elements: {
            reference?: ReferenceElement;
            target?: GuiObject;
        }
    }
    ```

  </TabItem>
</Tabs>

### `placement`

The **final** placement of the floating element relative to the reference element. Unlike the one passed in the options, this one can be mutated by middleware like `flip()`. This is necessary to determine the actual side of the floating element for positioning.

### `x`

The final x-coordinate of the floating element.

### `y`

The final y-coordinate of the floating element.

### `data`

The data provided by any middleware used.

### `update`

A function that updates the floating element’s position manually.

### `refs`

The refs that should be applied to the reference and floating elements.

#### `reference`

A ref for the reference element.

#### `target`

A ref for the floating (target) element. For usage in effects, prefer using `elements.target`

#### `setReference`

A function that sets the reference element.

#### `setTarget`

A function that sets the floating (target) element.

### `elements`

The elements as set by the refs, useful for access during rendering or when needing to reactively check if the element exists.

#### `reference`

The reference element. May be virtual.

#### `target`

The floating (target) element.

## Reactive middleware

When using stateful values inside _functions_, those values aren't fresh or reactive.

For example:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local AetherReact = require(path.to.aether-react)

    local value, setValue = React.useState(0)

    AetherReact.offset(value) -- reactive and fresh
    AetherReact.offset(function()
        return value
    end) -- NOT reactive or fresh
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { offset } from "@rbxts/aether-react";

    const [value, setValue] = useState(0);

    offset(value) // reactive and fresh
    offset(() => value) // NOT reactive or fresh
    ```

  </TabItem>
</Tabs>

However, the package allows you to the specify dependencies as a second argument of any middleware function that will keep it reactive:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local AetherReact = require(path.to.aether-react)

    local value, setValue = React.useState(0)

    AetherReact.offset(function()
        return value
    end, { value })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { offset } from "@rbxts/aether-react";

    const [value, setValue] = useState(0);

    offset(() => value, [value])
    ```

  </TabItem>
</Tabs>
