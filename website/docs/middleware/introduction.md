---
id: "introduction"
slug: /middleware
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

# Middleware

Middleware allow you to customize the behavior of the positioning and be as granular as you want, adding your own custom logic.

`process()` starts with initial positioning via `placement` — then middleware are executed as an in-between “middle” step of the initial placement computation and eventual return of data for rendering.

## Example

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local shiftByOnePixel: Aether.Middleware = {
        name = "shiftByOnePixel",
        run = function(state)
            return {
                x = state.x + 1,
                y = state.y + 1,
            }
        end,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process, type Middleware } from "@rbxts/aether";

    const shiftByOnePixel: Middleware = {
        name: "shiftByOnePixel",
        run: (state) => ({
            x: state.x + 1,
            y: state.y + 1,
        }),
    };
    ```

  </TabItem>
</Tabs>

This (not particularly useful) middleware adds `1` pixel to the coordinates. To use this middleware, add it to your `middleware` array:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    Aether.process(reference, target, {
        middleware = { shiftByOnePixel }
    })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process } from "@rbxts/aether";

    process(reference, target, {
        middleware: [shiftByOnePixel]
    });
    ```

  </TabItem>
</Tabs>

## Shape

This is the shape of the `Middleware` type:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Middleware<T> = {
        name: string,
        run: (state: MiddlewareState) => MiddlewareResult<T>
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface Middleware<T> {
        name: string;
        run: (state: MiddlewareState) => MiddlewareResult<T>;
    }
    ```

  </TabItem>
</Tabs>

### `name`

A **unique** name that identifies the middleware. If the middleware generates a result containing data, this name will be used as the key for that data in the result.

### `run`

The function executed when the middleware is processed.

## Middleware State

An object is passed to `run` containing useful data about the middleware lifecycle being executed.

In the previous examples, we destructured `x` and `y` out of the `run` parameter object. These are only two properties that get passed into middleware, but there are many more.

The properties passed are below:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type MiddlewareState = {
        x: number,
        y: number,
        initialPlacement: Placement,
        placement: Placement,
        data: MiddlewareData,
        elements: ElementRefs,
        rects: ElementRects,
        rtl: boolean,
        cache: Cache,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface MiddlewareState {
        x: number;
        y: number;
        initialPlacement: Placement;
        placement: Placement;
        data: MiddlewareData;
        elements: ElementRefs;
        rects: ElementRects;
        rtl: boolean;
        cache: Cache;
    }
    ```

  </TabItem>
</Tabs>

### `x`

This is the current x-axis coordinate to position the floating element to.

### `y`

This is the current y-axis coordinate to position the floating element to.

### `initialPlacement`

The initial (or preferred) placement passed in to `process()`.

### `placement`

The stateful resultant placement. Middleware like `flip()` change `initialPlacement` to a new one.

### `data`

This is an object containing all the data of any middleware at the current step in the lifecycle. The lifecycle loops over the `middleware` array, so later middleware have access to data from any middleware run prior.

### `elements`

This is an object containing the reference and floating elements.

### `rects`

This is an object containing the `Rect`s of the reference and floating elements, an object of shape `{ width, height, x, y }`.

### `rtl`

The right-to-left boolean flag passed in to `process()`.

### `cache`

The cache used for storing elements and scales during the lifecycle.

## Ordering

The order in which middleware are placed in the array matters, as middleware use the coordinates that were returned from previous ones. This means they perform their work based on the current positioning state.

Three `shiftByOnePixel` in the middleware array means the coordinates get shifted by 3 pixels in total:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local shiftByOnePixel: Aether.Middleware = {
        name = "shiftByOnePixel",
        run = function(state)
            return {
                x = state.x + 1,
                y = state.y + 1,
            }
        end,
    }

    Aether.proess(reference, target, {
        middleware = {
            shiftByOnePixel,
            shiftByOnePixel,
            shiftByOnePixel
        }
    })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process, type Middleware } from "@rbxts/aether";

    const shiftByOnePixel: Middleware = {
        name: "shiftByOnePixel",
        run: (state) => ({
            x: state.x + 1,
            y: state.y + 1,
        }),
    };

    process(reference, target, {
        middleware: [
            shiftByOnePixel,
            shiftByOnePixel,
            shiftByOnePixel
        ],
    });
    ```

  </TabItem>
</Tabs>

If the later `shiftByOnePixel` implementations had a condition based on the current value of `x` and `y`, the condition can change based on their placement in the array.

Understanding this can help in knowing which order to place middleware in, as placing a middleware before or after another can produce a different result.

## Resetting the lifecycle

There are use cases for needing to reset the middleware lifecycle so that other middleware perform fresh logic.

-   When `flip()` and `autoPlacement()` change the placement, they reset the lifecycle so that other middleware that modify the coordinates based on the current placement do not perform stale logic.
-   `size()` resets the lifecycle with the newly applied dimensions, as many middleware read the dimensions to perform their logic.

In order to do this, add a `reset` property to the returned object from `fn`.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Reset = true | {
        placement: Placement?,
        rects: true | ElementRects?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    type Reset =
        | true
        | {
            placement?: Placement;
            rects?: true | ElementRects;
        };
    ```

  </TabItem>
</Tabs>

The `Reset` type offers two modes for resetting behavior:

1. `true` – A complete reset of all middleware computations, without introducing new state.
2. **An object** – Allows selective resetting with additional options for customization.

### Object Properties

#### `placement`

Specifies the starting placement after resetting.

#### `rects`

Controls how the `rects` of elements are recomputed:

When set to `true`, the `rects` will automatically be re-computed. Otherwise, you can return your own new `rects`.
