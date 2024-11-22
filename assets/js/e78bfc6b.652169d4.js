"use strict";(self.webpackChunkwebsite=self.webpackChunkwebsite||[]).push([[1832],{3984:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>d,contentTitle:()=>c,default:()=>p,frontMatter:()=>o,metadata:()=>a,toc:()=>u});const a=JSON.parse('{"id":"middleware/size","title":"size","description":"Provides data to change the size of a floating element.","source":"@site/docs/middleware/size.md","sourceDirName":"middleware","slug":"/middleware/size","permalink":"/aether/docs/middleware/size","draft":false,"unlisted":false,"editUrl":"https://github.com/quamatic/aether/tree/main/website/docs/middleware/size.md","tags":[],"version":"current","frontMatter":{"title":"size"},"sidebar":"aether","previous":{"title":"shift","permalink":"/aether/docs/middleware/shift"},"next":{"title":"hide","permalink":"/aether/docs/middleware/hide"}}');var i=n(6106),l=n(2036),r=n(9269),s=n(8914);const o={title:"size"},c=void 0,d={},u=[{value:"Example",id:"example",level:2},{value:"Input",id:"input",level:2},{value:"<code>apply</code>",id:"apply",level:3},{value:"<code>detectOverflowConfig</code>",id:"detectoverflowconfig",level:3},{value:"Using with <code>flip()</code>",id:"using-with-flip",level:2},{value:"<code>&quot;best-fit&quot;</code>",id:"best-fit",level:3},{value:"<code>initial-placement</code>",id:"initial-placement",level:3}];function h(e){const t={a:"a",admonition:"admonition",code:"code",h2:"h2",h3:"h3",p:"p",pre:"pre",strong:"strong",...(0,l.R)(),...e.components};return(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(t.p,{children:"Provides data to change the size of a floating element."}),"\n",(0,i.jsx)(t.p,{children:"This is useful to ensure the floating element isn\u2019t too big to fit in the viewport (or more specifically, its clipping context), especially when a maximum size isn\u2019t specified. It also allows matching the width/height of the reference element."}),"\n",(0,i.jsx)(t.h2,{id:"example",children:"Example"}),"\n",(0,i.jsxs)(r.A,{groupId:"package-manager",children:[(0,i.jsx)(s.A,{value:"wally",label:"luau",default:!0,children:(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-luau",children:"local Aether = require(path.to.aether)\n\nlocal target = ...\n\nlocal result = Aether.process(reference, target, {\n    middleware = {\n        Aether.size({\n            apply = function(availableWidth, availableHeight)\n                -- Change styles, e.g.\n                -- For this example, let's just say `target` has a UISizeConstraint child.\n                target.UISizeConstraint.MaxSize = Vector2.new(math.max(availableWidth, 0), math.max(availableHeight, 0))\n            end,\n        })\n    }\n})\n"})})}),(0,i.jsx)(s.A,{value:"roblox-ts",label:"roblox-ts",children:(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",children:'import { process, size } from "@rbxts/aether"\n\nconst target = ...\n\nconst result = process(reference, target, {\n    middleware: [\n      size({\n        apply: (availableWidth, availableHeight) => {\n          // Change styles, e.g.\n          // For this example, let\'s just say `target` has a UISizeConstraint child.\n          target.UISizeConstraint.MaxValue = new Vector2(math.max(availableWidth, 0), math.max(availableHeight, 0))\n        }\n      })\n    ]\n})\n'})})})]}),"\n",(0,i.jsx)(t.h2,{id:"input",children:"Input"}),"\n",(0,i.jsxs)(t.p,{children:["This is the input you can pass to ",(0,i.jsx)(t.code,{children:"size()"}),":"]}),"\n",(0,i.jsxs)(r.A,{groupId:"package-manager",children:[(0,i.jsx)(s.A,{value:"wally",label:"luau",default:!0,children:(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-luau",children:"type Input = {\n    apply: (availableWidth: number, availableHeight: number) -> ()?,\n    detectOverflowConfig: DetectOverflowConfig?,\n}\n"})})}),(0,i.jsx)(s.A,{value:"roblox-ts",label:"roblox-ts",children:(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",children:"interface Input {\n    apply?: (availableWidth: number, availableHeight: number) => void;\n    detectOverflowConfig?: DetectOverflowConfig;\n}\n"})})})]}),"\n",(0,i.jsx)(t.h3,{id:"apply",children:(0,i.jsx)(t.code,{children:"apply"})}),"\n",(0,i.jsxs)(t.p,{children:["Default value: ",(0,i.jsx)(t.code,{children:"nil"})]}),"\n",(0,i.jsxs)(t.p,{children:["Unlike other middleware, in which you assign styles after ",(0,i.jsx)(t.code,{children:"process()"})," has done its work, ",(0,i.jsx)(t.code,{children:"size()"})," has its own apply function to do the work during the lifecycle:"]}),"\n",(0,i.jsx)(t.admonition,{type:"note",children:(0,i.jsxs)(t.p,{children:["Both properties can be negative. In the case of applying max styles, namely to a ",(0,i.jsx)(t.code,{children:"UISizeConstraint"}),", you should clamp them above ",(0,i.jsx)(t.code,{children:"0"}),"."]})}),"\n",(0,i.jsx)(t.h3,{id:"detectoverflowconfig",children:(0,i.jsx)(t.code,{children:"detectOverflowConfig"})}),"\n",(0,i.jsxs)(t.p,{children:["All of ",(0,i.jsx)(t.a,{href:"../guides/collisions#config",children:"detectOverflow()"}),"'s config can be passed in this."]}),"\n",(0,i.jsxs)(t.h2,{id:"using-with-flip",children:["Using with ",(0,i.jsx)(t.code,{children:"flip()"})]}),"\n",(0,i.jsxs)(t.p,{children:["Using ",(0,i.jsx)(t.code,{children:"size()"})," together with ",(0,i.jsx)(t.code,{children:"flip()"})," enables some useful behavior. The floating element can be resized, thus allowing it to prefer its initial placement as much as possible, until it reaches a minimum size, at which point it will flip."]}),"\n",(0,i.jsxs)(t.p,{children:["If you\u2019re using the ",(0,i.jsx)(t.code,{children:"padding"})," option in either middleware, ensure they share the same value."]}),"\n",(0,i.jsx)(t.h3,{id:"best-fit",children:(0,i.jsx)(t.code,{children:'"best-fit"'})}),"\n",(0,i.jsxs)(t.p,{children:['The "best-fit" fallback strategy in the ',(0,i.jsx)(t.code,{children:"flip()"})," middleware is the default, which ensures the best fitting placement is used. In this scenario, place ",(0,i.jsx)(t.code,{children:"size()"})," ",(0,i.jsx)(t.strong,{children:"after"})," ",(0,i.jsx)(t.code,{children:"flip()"}),":"]}),"\n",(0,i.jsx)(t.p,{children:"This strategy ensures the floating element stays in view at all times at the most optimal size."}),"\n",(0,i.jsx)(t.h3,{id:"initial-placement",children:(0,i.jsx)(t.code,{children:"initial-placement"})}),"\n",(0,i.jsxs)(t.p,{children:["If instead, you want the initial placement to take precedence, and are setting a minimum acceptable size, place ",(0,i.jsx)(t.code,{children:"size()"})," ",(0,i.jsx)(t.strong,{children:"before"})," ",(0,i.jsx)(t.code,{children:"flip()"}),":"]}),"\n",(0,i.jsxs)(r.A,{groupId:"package-manager",children:[(0,i.jsx)(s.A,{value:"wally",label:"luau",default:!0,children:(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-luau",children:'local Aether = require(path.to.aether)\n\nlocal middleware = {\n    Aether.size({\n        apply = function(availableWidth, availableHeight)\n            -- Minimum acceptablem height is 50px.\n            -- flip() would then take over if we applied this to a UISizeConstraint, for example.\n            print("Height:", math.max(50, availableHeight))\n        end\n    }),\n    Aether.flip()\n}\n'})})}),(0,i.jsx)(s.A,{value:"roblox-ts",label:"roblox-ts",children:(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",children:'import { size, flip } from "@rbxts/aether"\n\nconst middleware = [\n    size({\n      apply: (availableWidth, availableHeight) => {\n          // Minimum acceptablem height is 50px.\n          // flip() would then take over if we applied this to a UISizeConstraint, for example.\n          print("Height:", math.max(50, availableHeight))\n      }\n    }),\n    flip(),\n]\n'})})})]})]})}function p(e={}){const{wrapper:t}={...(0,l.R)(),...e.components};return t?(0,i.jsx)(t,{...e,children:(0,i.jsx)(h,{...e})}):h(e)}},8914:(e,t,n)=>{n.d(t,{A:()=>r});n(7378);var a=n(3372);const i={tabItem:"tabItem_FS4i"};var l=n(6106);function r(e){let{children:t,hidden:n,className:r}=e;return(0,l.jsx)("div",{role:"tabpanel",className:(0,a.A)(i.tabItem,r),hidden:n,children:t})}},9269:(e,t,n)=>{n.d(t,{A:()=>y});var a=n(7378),i=n(3372),l=n(2703),r=n(505),s=n(5086),o=n(6656),c=n(2097),d=n(421);function u(e){return a.Children.toArray(e).filter((e=>"\n"!==e)).map((e=>{if(!e||(0,a.isValidElement)(e)&&function(e){const{props:t}=e;return!!t&&"object"==typeof t&&"value"in t}(e))return e;throw new Error(`Docusaurus error: Bad <Tabs> child <${"string"==typeof e.type?e.type:e.type.name}>: all children of the <Tabs> component should be <TabItem>, and every <TabItem> should have a unique "value" prop.`)}))?.filter(Boolean)??[]}function h(e){const{values:t,children:n}=e;return(0,a.useMemo)((()=>{const e=t??function(e){return u(e).map((e=>{let{props:{value:t,label:n,attributes:a,default:i}}=e;return{value:t,label:n,attributes:a,default:i}}))}(n);return function(e){const t=(0,c.XI)(e,((e,t)=>e.value===t.value));if(t.length>0)throw new Error(`Docusaurus error: Duplicate values "${t.map((e=>e.value)).join(", ")}" found in <Tabs>. Every value needs to be unique.`)}(e),e}),[t,n])}function p(e){let{value:t,tabValues:n}=e;return n.some((e=>e.value===t))}function m(e){let{queryString:t=!1,groupId:n}=e;const i=(0,r.W6)(),l=function(e){let{queryString:t=!1,groupId:n}=e;if("string"==typeof t)return t;if(!1===t)return null;if(!0===t&&!n)throw new Error('Docusaurus error: The <Tabs> component groupId prop is required if queryString=true, because this value is used as the search param name. You can also provide an explicit value such as queryString="my-search-param".');return n??null}({queryString:t,groupId:n});return[(0,o.aZ)(l),(0,a.useCallback)((e=>{if(!l)return;const t=new URLSearchParams(i.location.search);t.set(l,e),i.replace({...i.location,search:t.toString()})}),[l,i])]}function f(e){const{defaultValue:t,queryString:n=!1,groupId:i}=e,l=h(e),[r,o]=(0,a.useState)((()=>function(e){let{defaultValue:t,tabValues:n}=e;if(0===n.length)throw new Error("Docusaurus error: the <Tabs> component requires at least one <TabItem> children component");if(t){if(!p({value:t,tabValues:n}))throw new Error(`Docusaurus error: The <Tabs> has a defaultValue "${t}" but none of its children has the corresponding value. Available values are: ${n.map((e=>e.value)).join(", ")}. If you intend to show no default tab, use defaultValue={null} instead.`);return t}const a=n.find((e=>e.default))??n[0];if(!a)throw new Error("Unexpected error: 0 tabValues");return a.value}({defaultValue:t,tabValues:l}))),[c,u]=m({queryString:n,groupId:i}),[f,b]=function(e){let{groupId:t}=e;const n=function(e){return e?`docusaurus.tab.${e}`:null}(t),[i,l]=(0,d.Dv)(n);return[i,(0,a.useCallback)((e=>{n&&l.set(e)}),[n,l])]}({groupId:i}),g=(()=>{const e=c??f;return p({value:e,tabValues:l})?e:null})();(0,s.A)((()=>{g&&o(g)}),[g]);return{selectedValue:r,selectValue:(0,a.useCallback)((e=>{if(!p({value:e,tabValues:l}))throw new Error(`Can't select invalid tab value=${e}`);o(e),u(e),b(e)}),[u,b,l]),tabValues:l}}var b=n(7606);const g={tabList:"tabList_scTV",tabItem:"tabItem_tmPb"};var x=n(6106);function v(e){let{className:t,block:n,selectedValue:a,selectValue:r,tabValues:s}=e;const o=[],{blockElementScrollPositionUntilNextRender:c}=(0,l.a_)(),d=e=>{const t=e.currentTarget,n=o.indexOf(t),i=s[n].value;i!==a&&(c(t),r(i))},u=e=>{let t=null;switch(e.key){case"Enter":d(e);break;case"ArrowRight":{const n=o.indexOf(e.currentTarget)+1;t=o[n]??o[0];break}case"ArrowLeft":{const n=o.indexOf(e.currentTarget)-1;t=o[n]??o[o.length-1];break}}t?.focus()};return(0,x.jsx)("ul",{role:"tablist","aria-orientation":"horizontal",className:(0,i.A)("tabs",{"tabs--block":n},t),children:s.map((e=>{let{value:t,label:n,attributes:l}=e;return(0,x.jsx)("li",{role:"tab",tabIndex:a===t?0:-1,"aria-selected":a===t,ref:e=>o.push(e),onKeyDown:u,onClick:d,...l,className:(0,i.A)("tabs__item",g.tabItem,l?.className,{"tabs__item--active":a===t}),children:n??t},t)}))})}function j(e){let{lazy:t,children:n,selectedValue:l}=e;const r=(Array.isArray(n)?n:[n]).filter(Boolean);if(t){const e=r.find((e=>e.props.value===l));return e?(0,a.cloneElement)(e,{className:(0,i.A)("margin-top--md",e.props.className)}):null}return(0,x.jsx)("div",{className:"margin-top--md",children:r.map(((e,t)=>(0,a.cloneElement)(e,{key:t,hidden:e.props.value!==l})))})}function w(e){const t=f(e);return(0,x.jsxs)("div",{className:(0,i.A)("tabs-container",g.tabList),children:[(0,x.jsx)(v,{...t,...e}),(0,x.jsx)(j,{...t,...e})]})}function y(e){const t=(0,b.A)();return(0,x.jsx)(w,{...e,children:u(e.children)},String(t))}},2036:(e,t,n)=>{n.d(t,{R:()=>r,x:()=>s});var a=n(7378);const i={},l=a.createContext(i);function r(e){const t=a.useContext(l);return a.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function s(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(i):e.components||i:r(e.components),a.createElement(l.Provider,{value:t},e.children)}}}]);