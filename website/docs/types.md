---
title: Types
---

```mdx-code-block
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
```

These are the utility types used and provided by Aether.

## `Side`

The side of a placement.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Side = "top" | "left" | "bottom" | "right"
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    type Side = "top" | "left" | "bottom" | "right";
    ```

  </TabItem>
</Tabs>

## `Alignment`

The alignment of a placement.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Alignment = "start" | "end"
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    type Alignment = "start" | "end";
    ```

  </TabItem>
</Tabs>

## `Placement`

A placement value.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Placement =
        | Side
        | "top-start"
        | "top-end"
        | "bottom-start"
        | "bottom-end"
        | "left-start"
        | "left-end"
        | "right-start"
        | "right-end"
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    type Alignment = Side | `${Side}-${Alignment}`
    ```

  </TabItem>
</Tabs>

:::note
You aren't limited to just these 12 placements. [offset()](./middleware/offset#creating-custom-placements) allows you to create _any_ placement.
:::

## `SideObject`

Used for representing different [`Side`](#side) values.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type SideObject = {
        top: number,
        bottom: number,
        left: number,
        right: number,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface SideObject {
        top: number;
        bottom: number;
        left: number;
        right: number;
    }
    ```

  </TabItem>
</Tabs>

## `Rect`

An object containing a rectangular area.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Rect = {
        x: number,
        y: number,
        width: number,
        height: number,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface Rect {
        x: number;
        y: number;
        width: number;
        height: number;
    }
    ```

  </TabItem>
</Tabs>

## `BoundingRect`

A [`Rect`](#rect) containing [`SideObject`](#sideobject) values.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type BoundingRect = {
        x: number,
        y: number,
        width: number,
        height: number,
        top: number,
        bottom: number,
        left: number,
        right: number,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    interface BoundingRect {
        x: number;
        y: number;
        width: number;
        height: number;
        top: number;
        bottom: number;
        left: number;
        right: number;
    }
    ```

  </TabItem>
</Tabs>

## `ElementRects`

Contains the [`Rect`](#rect) values for the `reference` and `target` (floating) element.

## `Padding`

Represents a value used for padding element sides. A single number applies the same padding to all sides, while a [SideObject](#sideobject) enables customization of padding for each side individually.

<Tabs groupId="package-manager">
  <TabItem value="wally" label="luau" default>

    ```luau
    type Padding = number | {
        top: number?,
        bottom: number?,
        left: number?,
        right: number?,
    }
    ```

  </TabItem>

  <TabItem value="roblox-ts" label="roblox-ts">

    ```typescript
    type Padding = number | Partial<{
        top: number;
        bottom: number;
        left: number;
        right: number;
    }>
    ```

  </TabItem>
</Tabs>
