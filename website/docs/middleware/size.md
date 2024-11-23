---
title: size
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

Provides data to change the size of a floating element.

This is useful to ensure the floating element isn’t too big to fit in the viewport (or more specifically, its clipping context), especially when a maximum size isn’t specified. It also allows matching the width/height of the reference element.

<div class="text--center">
    ![image](/examples/size.gif)
</div>

## Example

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local target = ...

    local result = Aether.process(reference, target, {
        middleware = {
            Aether.size({
                apply = function(availableWidth, availableHeight)
                    -- Change styles, e.g.
                    -- For this example, let's just say `target` has a UISizeConstraint child.
                    target.UISizeConstraint.MaxSize = Vector2.new(math.max(availableWidth, 0), math.max(availableHeight, 0))
                end,
            })
        }
    })
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { process, size } from "@rbxts/aether"

    const target = ...

    const result = process(reference, target, {
        middleware: [
          size({
            apply: (availableWidth, availableHeight) => {
              // Change styles, e.g.
              // For this example, let's just say `target` has a UISizeConstraint child.
              target.UISizeConstraint.MaxValue = new Vector2(math.max(availableWidth, 0), math.max(availableHeight, 0))
            }
          })
        ]
    })
    ```

  </TabItem>
</Tabs>

## Input

This is the input you can pass to `size()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Input = {
        apply: (availableWidth: number, availableHeight: number) -> ()?,
        detectOverflowConfig: DetectOverflowConfig?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface Input {
        apply?: (availableWidth: number, availableHeight: number) => void;
        detectOverflowConfig?: DetectOverflowConfig;
    }
    ```

  </TabItem>
</Tabs>

### `apply`

Default value: `nil`

Unlike other middleware, in which you assign styles after `process()` has done its work, `size()` has its own apply function to do the work during the lifecycle:

:::note
Both properties can be negative. In the case of applying max styles, namely to a `UISizeConstraint`, you should clamp them above `0`.
:::

### `detectOverflowConfig`

All of [detectOverflow()](../guides/collisions#config)'s config can be passed in this.

## Using with `flip()`

Using `size()` together with `flip()` enables some useful behavior. The floating element can be resized, thus allowing it to prefer its initial placement as much as possible, until it reaches a minimum size, at which point it will flip.

If you’re using the `padding` option in either middleware, ensure they share the same value.

### `"best-fit"`

The "best-fit" fallback strategy in the `flip()` middleware is the default, which ensures the best fitting placement is used. In this scenario, place `size()` **after** `flip()`:

This strategy ensures the floating element stays in view at all times at the most optimal size.

### `initial-placement`

If instead, you want the initial placement to take precedence, and are setting a minimum acceptable size, place `size()` **before** `flip()`:

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    local Aether = require(path.to.aether)

    local middleware = {
        Aether.size({
            apply = function(availableWidth, availableHeight)
                -- Minimum acceptablem height is 50px.
                -- flip() would then take over if we applied this to a UISizeConstraint, for example.
                print("Height:", math.max(50, availableHeight))
            end
        }),
        Aether.flip()
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    import { size, flip } from "@rbxts/aether"

    const middleware = [
        size({
          apply: (availableWidth, availableHeight) => {
              // Minimum acceptablem height is 50px.
              // flip() would then take over if we applied this to a UISizeConstraint, for example.
              print("Height:", math.max(50, availableHeight))
          }
        }),
        flip(),
    ]
    ```

  </TabItem>
</Tabs>
