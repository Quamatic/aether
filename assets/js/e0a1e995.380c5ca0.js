"use strict";(self.webpackChunkwebsite=self.webpackChunkwebsite||[]).push([[7102],{111:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>d,contentTitle:()=>c,default:()=>p,frontMatter:()=>i,metadata:()=>r,toc:()=>u});const r=JSON.parse('{"id":"guides/collisions","title":"Collisions","description":"Aether provides a way of detecting (and avoiding) collisions, via detectOverflow().","source":"@site/docs/guides/collisions.md","sourceDirName":"guides","slug":"/guides/collisions","permalink":"/aether/docs/guides/collisions","draft":false,"unlisted":false,"editUrl":"https://github.com/quamatic/aether/tree/main/website/docs/guides/collisions.md","tags":[],"version":"current","frontMatter":{"title":"Collisions"},"sidebar":"aether","previous":{"title":"Updating","permalink":"/aether/docs/guides/updating"},"next":{"title":"Virtual Elements","permalink":"/aether/docs/guides/virtual-elements"}}');var l=t(6106),a=t(2036),o=t(9269),s=t(8914);const i={title:"Collisions"},c=void 0,d={},u=[{value:"Understanding Boundaries",id:"understanding-boundaries",level:2},{value:"Example",id:"example",level:2},{value:"Config",id:"config",level:2},{value:"<code>boundary</code>",id:"boundary",level:3},{value:"<code>rootBoundary</code>",id:"rootboundary",level:3},{value:"<code>elementContext</code>",id:"elementcontext",level:3},{value:"<code>altBoundary</code>",id:"altboundary",level:3},{value:"<code>padding</code>",id:"padding",level:3}];function h(e){const n={a:"a",admonition:"admonition",code:"code",em:"em",h2:"h2",h3:"h3",li:"li",p:"p",pre:"pre",strong:"strong",ul:"ul",...(0,a.R)(),...e.components};return(0,l.jsxs)(l.Fragment,{children:[(0,l.jsxs)(n.p,{children:["Aether provides a way of detecting (and avoiding) collisions, via ",(0,l.jsx)(n.code,{children:"detectOverflow()"}),"."]}),"\n",(0,l.jsxs)(n.p,{children:[(0,l.jsx)(n.code,{children:"detectOverflow()"})," detects when the floating or reference element is overflowing a clipping container or custom boundary."]}),"\n",(0,l.jsxs)(n.p,{children:["Visibility optimizer middleware use this function for ",(0,l.jsx)(n.strong,{children:"collision detection"}),", making it useful for your own custom middleware that do the same."]}),"\n",(0,l.jsx)(n.h2,{id:"understanding-boundaries",children:"Understanding Boundaries"}),"\n",(0,l.jsx)(n.p,{children:"A boundary (or clipping container) is an area that causes child elements inside it to be clipped if they overflow it."}),"\n",(0,l.jsxs)(n.p,{children:[(0,l.jsx)(n.code,{children:"detectOverflow"})," takes two types of boundaries:"]}),"\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.code,{children:'"boundary"'})," which is the area that overflow will be checked ",(0,l.jsx)(n.em,{children:"relative to"}),"."]}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.code,{children:'"rootBoundary"'}),' which is the "root" area that overflow will be checked ',(0,l.jsx)(n.em,{children:"relative to"}),". This sounds like it has the same purpose as ",(0,l.jsx)(n.code,{children:'"boundary"'}),', but\nthe "root" is there because it involves screen boundaries.']}),"\n"]}),"\n",(0,l.jsxs)(n.p,{children:["More info can be found ",(0,l.jsx)(n.a,{href:"#config",children:"in the config"}),"."]}),"\n",(0,l.jsx)(n.h2,{id:"example",children:"Example"}),"\n",(0,l.jsxs)(n.p,{children:["Here's an example of a custom middleware using ",(0,l.jsx)(n.code,{children:"detectOverflow()"}),":"]}),"\n",(0,l.jsxs)(o.A,{groupId:"package-manager",children:[(0,l.jsx)(s.A,{value:"wally",label:"luau",default:!0,children:(0,l.jsx)(n.pre,{children:(0,l.jsx)(n.code,{className:"language-luau",children:'local Aether = require(path.to.aether)\n\nlocal middleware: Aether.Middleware = {\n    name = "middleware",\n    run = function(state)\n        local overflow = Aether.detectOverflow(state)\n        return {}\n    end,\n}\n'})})}),(0,l.jsx)(s.A,{value:"roblox-ts",label:"roblox-ts",children:(0,l.jsx)(n.pre,{children:(0,l.jsx)(n.code,{className:"language-typescript",children:'import { detectOverflow, type Middleware } from "@rbxts/aether";\n\nconst middleware: Middleware = {\n    name: "middleware",\n    run: (state) => {\n        const overflow = detectOverflow(state);\n        return {}\n    },\n};\n'})})})]}),"\n",(0,l.jsxs)(n.p,{children:["The returned value, ",(0,l.jsx)(n.code,{children:"overflow"}),", is a ",(0,l.jsx)(n.a,{href:"../types#sideobject",children:(0,l.jsx)(n.code,{children:"SideObject"})})," containing side properties with numbers representing offsets."]}),"\n",(0,l.jsxs)(n.ul,{children:["\n",(0,l.jsx)(n.li,{children:"A positive number means the element is overflowing the clipping boundary by that number of pixels. (more pixels = further away from the boundary)"}),"\n",(0,l.jsx)(n.li,{children:"A negative number means the element has that number of pixels left before it will overflow the clipping boundary. (less pixels = closer to the boundary)"}),"\n",(0,l.jsxs)(n.li,{children:[(0,l.jsx)(n.code,{children:"0"})," means the side lies flush with the clipping boundary."]}),"\n"]}),"\n",(0,l.jsx)(n.h2,{id:"config",children:"Config"}),"\n",(0,l.jsxs)(n.p,{children:[(0,l.jsx)(n.code,{children:"detectOverflow()"})," takes a config as a second argument:"]}),"\n",(0,l.jsxs)(o.A,{groupId:"package-manager",children:[(0,l.jsx)(s.A,{value:"wally",label:"luau",default:!0,children:(0,l.jsx)(n.pre,{children:(0,l.jsx)(n.code,{className:"language-luau",children:"type DetectOverflowConfig = {\n    boundary: Boundary?,\n    rootBoundary: RootBoundary?,\n    elementContext: ElementContext?,\n    altBoundary: boolean?,\n    padding: Padding?\n}\n"})})}),(0,l.jsx)(s.A,{value:"roblox-ts",label:"roblox-ts",children:(0,l.jsx)(n.pre,{children:(0,l.jsx)(n.code,{className:"language-typescript",children:"interface DetectOverflowConfig {\n    boundary?: Boundary;\n    rootBoundary?: RootBoundary;\n    elementContext?: ElementContext;\n    altBoundary?: boolean;\n    padding?: Padding;\n}\n"})})})]}),"\n",(0,l.jsx)(n.h3,{id:"boundary",children:(0,l.jsx)(n.code,{children:"boundary"})}),"\n",(0,l.jsxs)(o.A,{groupId:"package-manager",children:[(0,l.jsx)(s.A,{value:"wally",label:"luau",default:!0,children:(0,l.jsx)(n.pre,{children:(0,l.jsx)(n.code,{className:"language-luau",children:'type Boundary = "clipping-ancestors" | GuiObject | { GuiObject } | Rect\n'})})}),(0,l.jsx)(s.A,{value:"roblox-ts",label:"roblox-ts",children:(0,l.jsx)(n.pre,{children:(0,l.jsx)(n.code,{className:"language-typescript",children:'type Boundary = "clipping-ancestors" | GuiObject | GuiObject[] | Rect;\n'})})})]}),"\n",(0,l.jsxs)(n.p,{children:["This describes the clipping element(s) or area that overflow will be checked relative to. The default is ",(0,l.jsx)(n.code,{children:'"clipping-ancestors"'}),", which are the overflow ancestors which will cause the element to be clipped."]}),"\n",(0,l.jsxs)(n.p,{children:["You can also pass multiple ",(0,l.jsx)(n.code,{children:"GuiObject"}),"s, or a custom ",(0,l.jsx)(n.a,{href:"../types#rect",children:(0,l.jsx)(n.code,{children:"Rect"})}),"."]}),"\n",(0,l.jsx)(n.admonition,{type:"note",children:(0,l.jsxs)(n.p,{children:['An "overflow ancestor" is a ',(0,l.jsx)(n.code,{children:"GuiObject"})," that has ",(0,l.jsx)(n.code,{children:"ClipsDescendants"})," enabled."]})}),"\n",(0,l.jsx)(n.h3,{id:"rootboundary",children:(0,l.jsx)(n.code,{children:"rootBoundary"})}),"\n",(0,l.jsxs)(o.A,{groupId:"package-manager",children:[(0,l.jsx)(s.A,{value:"wally",label:"luau",default:!0,children:(0,l.jsx)(n.pre,{children:(0,l.jsx)(n.code,{className:"language-luau",children:'type RootBoundary = "layer-collector" | Rect\n'})})}),(0,l.jsx)(s.A,{value:"roblox-ts",label:"roblox-ts",children:(0,l.jsx)(n.pre,{children:(0,l.jsx)(n.code,{className:"language-typescript",children:'type RootBoundary = "layer-collector" | Rect;\n'})})})]}),"\n",(0,l.jsxs)(n.p,{children:["This describes the root boundary that the element will be checked for overflow relative to. The default is ",(0,l.jsx)(n.code,{children:'"layer-collector"'}),", which is the ancestor ",(0,l.jsx)(n.a,{href:"https://create.roblox.com/docs/reference/engine/classes/LayerCollector",children:"LayerCollector"})," that contains the element. Most of the time, this could just be known as the screen area."]}),"\n",(0,l.jsxs)(n.p,{children:["You may also pass a ",(0,l.jsx)(n.a,{href:"../types#rect",children:(0,l.jsx)(n.code,{children:"Rect"})})," object to define a custom boundary area (relative to the screen)."]}),"\n",(0,l.jsx)(n.h3,{id:"elementcontext",children:(0,l.jsx)(n.code,{children:"elementContext"})}),"\n",(0,l.jsxs)(o.A,{groupId:"package-manager",children:[(0,l.jsx)(s.A,{value:"wally",label:"luau",default:!0,children:(0,l.jsx)(n.pre,{children:(0,l.jsx)(n.code,{className:"language-luau",children:'type ElementContext = "reference" | "target"\n'})})}),(0,l.jsx)(s.A,{value:"roblox-ts",label:"roblox-ts",children:(0,l.jsx)(n.pre,{children:(0,l.jsx)(n.code,{className:"language-typescript",children:'type ElementContext = "reference" | "target";\n'})})})]}),"\n",(0,l.jsxs)(n.p,{children:["By default, the ",(0,l.jsx)(n.code,{children:'"target"'})," element is the one being checked for overflow."]}),"\n",(0,l.jsxs)(n.p,{children:["But you can also change the context to ",(0,l.jsx)(n.code,{children:'"reference"'})," to instead check its overflow relative to its clipping boundary."]}),"\n",(0,l.jsx)(n.h3,{id:"altboundary",children:(0,l.jsx)(n.code,{children:"altBoundary"})}),"\n",(0,l.jsxs)(n.p,{children:["This is a boolean value which determines whether to check the alternate ",(0,l.jsx)(n.code,{children:"elementContext"}),"\u2019s boundary."]}),"\n",(0,l.jsxs)(n.p,{children:["For instance, if the ",(0,l.jsx)(n.code,{children:"elementContext"})," is ",(0,l.jsx)(n.code,{children:'"target"'}),", and you enable this option, then the boundary in which overflow is checked for is the ",(0,l.jsx)(n.code,{children:'"reference"'}),"\u2019s boundary. This only applies if you are using the default ",(0,l.jsx)(n.code,{children:'"clipping-ancestors"'})," string as the boundary."]}),"\n",(0,l.jsx)(n.h3,{id:"padding",children:(0,l.jsx)(n.code,{children:"padding"})}),"\n",(0,l.jsxs)(n.p,{children:["This describes the virtual ",(0,l.jsx)(n.a,{href:"../types#padding",children:"Padding"})," around the boundary to check for overflow."]})]})}function p(e={}){const{wrapper:n}={...(0,a.R)(),...e.components};return n?(0,l.jsx)(n,{...e,children:(0,l.jsx)(h,{...e})}):h(e)}},8914:(e,n,t)=>{t.d(n,{A:()=>o});t(7378);var r=t(3372);const l={tabItem:"tabItem_FS4i"};var a=t(6106);function o(e){let{children:n,hidden:t,className:o}=e;return(0,a.jsx)("div",{role:"tabpanel",className:(0,r.A)(l.tabItem,o),hidden:t,children:n})}},9269:(e,n,t)=>{t.d(n,{A:()=>w});var r=t(7378),l=t(3372),a=t(2703),o=t(505),s=t(5086),i=t(6656),c=t(2097),d=t(421);function u(e){return r.Children.toArray(e).filter((e=>"\n"!==e)).map((e=>{if(!e||(0,r.isValidElement)(e)&&function(e){const{props:n}=e;return!!n&&"object"==typeof n&&"value"in n}(e))return e;throw new Error(`Docusaurus error: Bad <Tabs> child <${"string"==typeof e.type?e.type:e.type.name}>: all children of the <Tabs> component should be <TabItem>, and every <TabItem> should have a unique "value" prop.`)}))?.filter(Boolean)??[]}function h(e){const{values:n,children:t}=e;return(0,r.useMemo)((()=>{const e=n??function(e){return u(e).map((e=>{let{props:{value:n,label:t,attributes:r,default:l}}=e;return{value:n,label:t,attributes:r,default:l}}))}(t);return function(e){const n=(0,c.XI)(e,((e,n)=>e.value===n.value));if(n.length>0)throw new Error(`Docusaurus error: Duplicate values "${n.map((e=>e.value)).join(", ")}" found in <Tabs>. Every value needs to be unique.`)}(e),e}),[n,t])}function p(e){let{value:n,tabValues:t}=e;return t.some((e=>e.value===n))}function x(e){let{queryString:n=!1,groupId:t}=e;const l=(0,o.W6)(),a=function(e){let{queryString:n=!1,groupId:t}=e;if("string"==typeof n)return n;if(!1===n)return null;if(!0===n&&!t)throw new Error('Docusaurus error: The <Tabs> component groupId prop is required if queryString=true, because this value is used as the search param name. You can also provide an explicit value such as queryString="my-search-param".');return t??null}({queryString:n,groupId:t});return[(0,i.aZ)(a),(0,r.useCallback)((e=>{if(!a)return;const n=new URLSearchParams(l.location.search);n.set(a,e),l.replace({...l.location,search:n.toString()})}),[a,l])]}function f(e){const{defaultValue:n,queryString:t=!1,groupId:l}=e,a=h(e),[o,i]=(0,r.useState)((()=>function(e){let{defaultValue:n,tabValues:t}=e;if(0===t.length)throw new Error("Docusaurus error: the <Tabs> component requires at least one <TabItem> children component");if(n){if(!p({value:n,tabValues:t}))throw new Error(`Docusaurus error: The <Tabs> has a defaultValue "${n}" but none of its children has the corresponding value. Available values are: ${t.map((e=>e.value)).join(", ")}. If you intend to show no default tab, use defaultValue={null} instead.`);return n}const r=t.find((e=>e.default))??t[0];if(!r)throw new Error("Unexpected error: 0 tabValues");return r.value}({defaultValue:n,tabValues:a}))),[c,u]=x({queryString:t,groupId:l}),[f,b]=function(e){let{groupId:n}=e;const t=function(e){return e?`docusaurus.tab.${e}`:null}(n),[l,a]=(0,d.Dv)(t);return[l,(0,r.useCallback)((e=>{t&&a.set(e)}),[t,a])]}({groupId:l}),m=(()=>{const e=c??f;return p({value:e,tabValues:a})?e:null})();(0,s.A)((()=>{m&&i(m)}),[m]);return{selectedValue:o,selectValue:(0,r.useCallback)((e=>{if(!p({value:e,tabValues:a}))throw new Error(`Can't select invalid tab value=${e}`);i(e),u(e),b(e)}),[u,b,a]),tabValues:a}}var b=t(7606);const m={tabList:"tabList_scTV",tabItem:"tabItem_tmPb"};var g=t(6106);function j(e){let{className:n,block:t,selectedValue:r,selectValue:o,tabValues:s}=e;const i=[],{blockElementScrollPositionUntilNextRender:c}=(0,a.a_)(),d=e=>{const n=e.currentTarget,t=i.indexOf(n),l=s[t].value;l!==r&&(c(n),o(l))},u=e=>{let n=null;switch(e.key){case"Enter":d(e);break;case"ArrowRight":{const t=i.indexOf(e.currentTarget)+1;n=i[t]??i[0];break}case"ArrowLeft":{const t=i.indexOf(e.currentTarget)-1;n=i[t]??i[i.length-1];break}}n?.focus()};return(0,g.jsx)("ul",{role:"tablist","aria-orientation":"horizontal",className:(0,l.A)("tabs",{"tabs--block":t},n),children:s.map((e=>{let{value:n,label:t,attributes:a}=e;return(0,g.jsx)("li",{role:"tab",tabIndex:r===n?0:-1,"aria-selected":r===n,ref:e=>i.push(e),onKeyDown:u,onClick:d,...a,className:(0,l.A)("tabs__item",m.tabItem,a?.className,{"tabs__item--active":r===n}),children:t??n},n)}))})}function v(e){let{lazy:n,children:t,selectedValue:a}=e;const o=(Array.isArray(t)?t:[t]).filter(Boolean);if(n){const e=o.find((e=>e.props.value===a));return e?(0,r.cloneElement)(e,{className:(0,l.A)("margin-top--md",e.props.className)}):null}return(0,g.jsx)("div",{className:"margin-top--md",children:o.map(((e,n)=>(0,r.cloneElement)(e,{key:n,hidden:e.props.value!==a})))})}function y(e){const n=f(e);return(0,g.jsxs)("div",{className:(0,l.A)("tabs-container",m.tabList),children:[(0,g.jsx)(j,{...n,...e}),(0,g.jsx)(v,{...n,...e})]})}function w(e){const n=(0,b.A)();return(0,g.jsx)(y,{...e,children:u(e.children)},String(n))}},2036:(e,n,t)=>{t.d(n,{R:()=>o,x:()=>s});var r=t(7378);const l={},a=r.createContext(l);function o(e){const n=r.useContext(a);return r.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function s(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(l):e.components||l:o(e.components),r.createElement(a.Provider,{value:n},e.children)}}}]);