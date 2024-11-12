## Installation

#### roblox-ts:

```sh
npm install @rbxts/aether
yarn add @rbxts/aether
pnpm add @rbxts/aether
```

#### wally:

```toml
[dependencies]
Aether = "quamatic/aether@VERSION"
```

## Vanilla

### Usage

Call `process` with your given reference and target elements, as well as with the configuration you want:

```luau
local Aether = require(path.to.aether)

-- This is not realistic, but simply for example!
local reference = Instance.new("Frame")
local target = Instance.new("Frame")

local result = Aether.process(reference, target, {
    placement = "bottom",
    middleware = {}
})

target.Position = UDim2.fromOffset(result.x, result.y)
```

## React

### Installation

To use the React bindings for Aether, first install using your selected package manager:

#### roblox-ts:

```sh
npm install @rbxts/aether-react
yarn add @rbxts/aether-react
pnpm add @rbxts/aether-react
```

#### wally:

```toml
[dependencies]
AetherReact = "quamatic/aether-react@VERSION"
```

### Usage

Call `useFloating` at the top-level of a React component:

```luau
local React = require(path.to.react)
local AetherReact = require(path.to.aether-react)

local e = React.createElement

local function App()
    local floating = AetherReact.useFloating()

    return e("Frame", {}, {
        Reference = e("Frame", {
            ref = floating.refs.setReference,
        }),

        Target = e("Frame", {
            Position = UDim2.fromOffset(floating.x, floating.y)
            ref = floating.refs.setTarget
        })
    })
end
```

#### Parameters

`useFloating` only takes one parameter, which is a configuration object with various data:

-   `placement`: The target placement to position for.
-   `middleware`: The middleware to use for processing the position.
-   `whileElementsMounted`: The function to run for updating the element.
-   `rtl`: Allows for right-to-left processing. This is optional.
-   `elements`: An object optionally containing the reference or target elements. This is useful for externally passing elements.

#### Returns

`useFloating` returns an object containing the data:

-   `x`: The current X position of the target element.
-   `y`: The current Y position of the target element.
-   `placement`: the final placement after processing. This is not always the same as the placement given in the configuration, as middleware can alter placements as needed.
-   `data`: The current middleware data received after processing the given middleware (those that are given in the config, as well as if they return any).
-   `isPositioned`: A boolean that is true if the element is currently positioned.
-   `update`: A function to forcefully update the position.
-   `refs`: An object containing the refs that should be applied to the reference and floating element:
    -   `reference`: A ref to the reference element.
    -   `target`: A ref to the target element.
    -   `setReference`: A function that sets the reference element.
    -   `setTarget`: A function that sets the target element.
-   `elements`: An object containing the current elements as set by refs.
    -   `reference`: The current reference element.
    -   `target`: The current target element.

## Vide

### Installation

To use the Vide bindings for Aether, first install using your selected package manager:

#### roblox-ts:

```sh
npm install @rbxts/aether-vide
yarn add @rbxts/aether-vide
pnpm add @rbxts/aether-vide
```

#### wally:

```toml
[dependencies]
AetherVide = "quamatic/aether-vide@VERSION"
```

### Usage

Call `useFloating` to be able to use the source data:

```luau
local Vide = require(path.to.vide)
local Aether = require(path.to.aether)
local AetherVide = require(path.to.aether-vide)

local create = Vide.create
local source = Vide.source
local action = Vide.action

local function App()
    local reference = source(nil)
    local target = source(nil)
    local floating = AetherVide.useFloating(reference, target, {
        placement = "bottom",
        middleware = { Aether.offset(5) },
        whileElementsMounted = Aether.autoUpdate,
    })

    return create "Frame" {
        create "Frame" {
            action(reference)
        },

        create "Frame" {
            action(target)
        }
    }
end
```

#### Parameters

-   `reference`: A Vide source that can contain the reference element.
-   `target`: A Vide source that can contain the target element.
-   `config`: Optional config to further specify the requirements for the positioning
    -   `placement`: The target placement to position for.
    -   `middleware`: The middleware to use for processing the target position.
    -   `whileElementsMounted`: The function to run for updating the element.

#### Returns

`useFloating` returns an object that contains various source data:

-   `x`: A Vide source that contains the current X position of the target element.
-   `y`: A Vide source that contains the current Y position of the target element.
-   `data`: A Vide source that contains the current middleware data received after processing the given middleware (those that are given in the config, as well as if they return any).
-   `placement`: A Vide source that contains the final placement after processing. This is not always the same as the placement given in the configuration, as middleware can alter placements as needed.
-   `update`: A function that forcefully re-processes the position.
