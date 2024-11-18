// @ts-check

// This runs in Node.js - Don't use client-side code here (browser APIs, JSX...)

/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you want.

 @type {import('@docusaurus/plugin-content-docs').SidebarsConfig}
 */
const sidebars = {
  aether: [
    "getting-started",
    "installation",
    {
      type: "category",
      label: "Guides",
      collapsed: false,
      items: [
        "guides/processing",
        "guides/updating",
        "guides/collisions",
        "guides/virtual-elements"
      ]
    },
    {
      type: "category",
      label: "Middleware",
      link: {
        type: "doc",
        id: "middleware/introduction"
      },
      items: [
        "middleware/offset",
        "middleware/flip",
        "middleware/auto-placement",
        "middleware/shift",
        "middleware/size",
        "middleware/hide",
        "middleware/arrow",
        "middleware/inline",
      ]
    },
    "utility",
    "types",
    "react",
    "vide"
  ]
};

export default sidebars;
