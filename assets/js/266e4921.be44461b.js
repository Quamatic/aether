"use strict";(self.webpackChunkwebsite=self.webpackChunkwebsite||[]).push([[4494],{4286:(e,n,r)=>{r.r(n),r.d(n,{assets:()=>o,contentTitle:()=>c,default:()=>f,frontMatter:()=>d,metadata:()=>t,toc:()=>u});const t=JSON.parse('{"id":"middleware/hide","title":"hide","description":"A data provider that allows you to hide the floating element in applicable situations.","source":"@site/docs/middleware/hide.md","sourceDirName":"middleware","slug":"/middleware/hide","permalink":"/aether/docs/middleware/hide","draft":false,"unlisted":false,"editUrl":"https://github.com/quamatic/aether/tree/main/website/docs/middleware/hide.md","tags":[],"version":"current","frontMatter":{"title":"hide"},"sidebar":"aether","previous":{"title":"size","permalink":"/aether/docs/middleware/size"},"next":{"title":"arrow","permalink":"/aether/docs/middleware/arrow"}}');var a=r(6106),l=r(2036),s=r(9269),i=r(8914);const d={title:"hide"},c=void 0,o={},u=[{value:"Example",id:"example",level:2},{value:"Input",id:"input",level:2},{value:"<code>strategy</code>",id:"strategy",level:3},{value:"<code>detectOverflowConfig</code>",id:"detectoverflowconfig",level:3},{value:"Data",id:"data",level:2},{value:"<code>referenceHidden</code>",id:"referencehidden",level:3},{value:"<code>referenceHiddenOffsets</code>",id:"referencehiddenoffsets",level:3},{value:"<code>escaped</code>",id:"escaped",level:3},{value:"<code>escapedOffsets</code>",id:"escapedoffsets",level:3},{value:"Order",id:"order",level:2}];function h(e){const n={a:"a",code:"code",h2:"h2",h3:"h3",li:"li",p:"p",pre:"pre",ul:"ul",...(0,l.R)(),...e.components};return(0,a.jsxs)(a.Fragment,{children:[(0,a.jsx)(n.p,{children:"A data provider that allows you to hide the floating element in applicable situations."}),"\n",(0,a.jsx)(n.p,{children:"This is useful for situations where you want to hide the floating element because it appears detached from the reference element (or attached to nothing)."}),"\n",(0,a.jsx)(n.h2,{id:"example",children:"Example"}),"\n",(0,a.jsxs)(s.A,{groupId:"package-manager",children:[(0,a.jsx)(i.A,{value:"wally",label:"luau",default:!0,children:(0,a.jsx)(n.pre,{children:(0,a.jsx)(n.code,{className:"language-luau",children:'local Aether = require(path.to.aether)\n\nlocal result = Aether.process(reference, target, {\n    middleware = { Aether.hide() } -- Default strategy is "reference-hidden"\n})\n\nif result.data.hide.referenceHidden then\n    -- ...reference is hidden!\nend\n'})})}),(0,a.jsx)(i.A,{value:"roblox-ts",label:"roblox-ts",children:(0,a.jsx)(n.pre,{children:(0,a.jsx)(n.code,{className:"language-typescript",children:'import { process, hide } from "@rbxts/aether";\n\nconst result = process(reference, target, {\n    middleware: [hide()] // Default strategy is "reference-hidden"\n});\n\nif (result.data.hide?.referenceHidden) {\n    // ...reference is hidden!\n}\n'})})})]}),"\n",(0,a.jsx)(n.h2,{id:"input",children:"Input"}),"\n",(0,a.jsxs)(n.p,{children:["This is the input you can pass to ",(0,a.jsx)(n.code,{children:"hide()"}),":"]}),"\n",(0,a.jsxs)(s.A,{groupId:"package-manager",children:[(0,a.jsx)(i.A,{value:"wally",label:"luau",default:!0,children:(0,a.jsx)(n.pre,{children:(0,a.jsx)(n.code,{className:"language-luau",children:'type Input = {\n    strategy: "reference-hidden" | "escaped",\n    detectOverflowConfig: DetectOverflowConfig?,\n}\n'})})}),(0,a.jsx)(i.A,{value:"roblox-ts",label:"roblox-ts",children:(0,a.jsx)(n.pre,{children:(0,a.jsx)(n.code,{className:"language-typescript",children:'interface Input {\n    strategy?: "reference-hidden" | "escaped";\n    detectOverflowConfig?: DetectOverflowConfig;\n}\n'})})})]}),"\n",(0,a.jsx)(n.h3,{id:"strategy",children:(0,a.jsx)(n.code,{children:"strategy"})}),"\n",(0,a.jsxs)(n.p,{children:["Default value: ",(0,a.jsx)(n.code,{children:"reference-hidden"})]}),"\n",(0,a.jsx)(n.p,{children:"The strategy used to determine when to hide the floating element."}),"\n",(0,a.jsxs)(n.ul,{children:["\n",(0,a.jsxs)(n.li,{children:['"reference-hidden" - The ',(0,a.jsx)(n.code,{children:"reference"})," element will be checked for overflow relative to its clipping context."]}),"\n",(0,a.jsxs)(n.li,{children:['"escaped" - The ',(0,a.jsx)(n.code,{children:"target"}),' element will be checked if it has fully clipped out of (hence "escaped") the ',(0,a.jsx)(n.code,{children:"reference"})," element's clipping context."]}),"\n"]}),"\n",(0,a.jsxs)(n.p,{children:["If you\u2019d like to use multiple strategies, call ",(0,a.jsx)(n.code,{children:"hide()"})," multiple times in your middleware array with different options."]}),"\n",(0,a.jsx)(n.h3,{id:"detectoverflowconfig",children:(0,a.jsx)(n.code,{children:"detectOverflowConfig"})}),"\n",(0,a.jsxs)(n.p,{children:["All of ",(0,a.jsx)(n.a,{href:"../guides/collisions#config",children:"detectOverflow()"}),"'s config can be passed in this."]}),"\n",(0,a.jsx)(n.h2,{id:"data",children:"Data"}),"\n",(0,a.jsxs)(n.p,{children:[(0,a.jsx)(n.code,{children:"hide()"})," passes the following middleware data:"]}),"\n",(0,a.jsxs)(s.A,{groupId:"package-manager",children:[(0,a.jsx)(i.A,{value:"wally",label:"luau",default:!0,children:(0,a.jsx)(n.pre,{children:(0,a.jsx)(n.code,{className:"language-luau",children:"type Data = {\n    referenceHidden: boolean?,\n    referenceHiddenOffsets: SideObject?,\n    escaped: boolean?,\n    escapedOffsets: SideObject?,\n}\n"})})}),(0,a.jsx)(i.A,{value:"roblox-ts",label:"roblox-ts",children:(0,a.jsx)(n.pre,{children:(0,a.jsx)(n.code,{className:"language-typescript",children:"interface Data {\n    referenceHidden?: boolean;\n    referenceHiddenOffsets?: SideObject;\n    escaped?: boolean;\n    escapedOffsets?: SideObject;\n}\n"})})})]}),"\n",(0,a.jsx)(n.p,{children:"Depending on the strategy used, these options may exist in the data object:"}),"\n",(0,a.jsx)(n.h3,{id:"referencehidden",children:(0,a.jsx)(n.code,{children:"referenceHidden"})}),"\n",(0,a.jsxs)(n.p,{children:["Provided when strategy is ",(0,a.jsx)(n.code,{children:'"reference-hidden"'})]}),"\n",(0,a.jsx)(n.p,{children:"Determines whether the reference element is fully clipped, and is therefore hidden from view."}),"\n",(0,a.jsxs)(n.p,{children:['Note that "hidden" means clipping, the ',(0,a.jsx)(n.code,{children:"Visible"})," property is not considered."]}),"\n",(0,a.jsx)(n.h3,{id:"referencehiddenoffsets",children:(0,a.jsx)(n.code,{children:"referenceHiddenOffsets"})}),"\n",(0,a.jsxs)(n.p,{children:["Provided when strategy is ",(0,a.jsx)(n.code,{children:'"reference-hidden"'})]}),"\n",(0,a.jsx)(n.p,{children:"A side object containing overflow offsets."}),"\n",(0,a.jsx)(n.h3,{id:"escaped",children:(0,a.jsx)(n.code,{children:"escaped"})}),"\n",(0,a.jsxs)(n.p,{children:["Provided when strategy is ",(0,a.jsx)(n.code,{children:'"escaped"'})]}),"\n",(0,a.jsx)(n.p,{children:"Determines whether the floating element has \u201cescaped\u201d the reference\u2019s clipping context and appears fully detached from it."}),"\n",(0,a.jsx)(n.h3,{id:"escapedoffsets",children:(0,a.jsx)(n.code,{children:"escapedOffsets"})}),"\n",(0,a.jsxs)(n.p,{children:["Provided when strategy is ",(0,a.jsx)(n.code,{children:'"escaped"'})]}),"\n",(0,a.jsx)(n.p,{children:"A side object containing overflow offsets."}),"\n",(0,a.jsx)(n.h2,{id:"order",children:"Order"}),"\n",(0,a.jsxs)(n.p,{children:[(0,a.jsx)(n.code,{children:"hide()"})," should generally be placed at the end of your middleware array."]})]})}function f(e={}){const{wrapper:n}={...(0,l.R)(),...e.components};return n?(0,a.jsx)(n,{...e,children:(0,a.jsx)(h,{...e})}):h(e)}},8914:(e,n,r)=>{r.d(n,{A:()=>s});r(7378);var t=r(3372);const a={tabItem:"tabItem_FS4i"};var l=r(6106);function s(e){let{children:n,hidden:r,className:s}=e;return(0,l.jsx)("div",{role:"tabpanel",className:(0,t.A)(a.tabItem,s),hidden:r,children:n})}},9269:(e,n,r)=>{r.d(n,{A:()=>y});var t=r(7378),a=r(3372),l=r(2703),s=r(505),i=r(5086),d=r(6656),c=r(2097),o=r(421);function u(e){return t.Children.toArray(e).filter((e=>"\n"!==e)).map((e=>{if(!e||(0,t.isValidElement)(e)&&function(e){const{props:n}=e;return!!n&&"object"==typeof n&&"value"in n}(e))return e;throw new Error(`Docusaurus error: Bad <Tabs> child <${"string"==typeof e.type?e.type:e.type.name}>: all children of the <Tabs> component should be <TabItem>, and every <TabItem> should have a unique "value" prop.`)}))?.filter(Boolean)??[]}function h(e){const{values:n,children:r}=e;return(0,t.useMemo)((()=>{const e=n??function(e){return u(e).map((e=>{let{props:{value:n,label:r,attributes:t,default:a}}=e;return{value:n,label:r,attributes:t,default:a}}))}(r);return function(e){const n=(0,c.XI)(e,((e,n)=>e.value===n.value));if(n.length>0)throw new Error(`Docusaurus error: Duplicate values "${n.map((e=>e.value)).join(", ")}" found in <Tabs>. Every value needs to be unique.`)}(e),e}),[n,r])}function f(e){let{value:n,tabValues:r}=e;return r.some((e=>e.value===n))}function p(e){let{queryString:n=!1,groupId:r}=e;const a=(0,s.W6)(),l=function(e){let{queryString:n=!1,groupId:r}=e;if("string"==typeof n)return n;if(!1===n)return null;if(!0===n&&!r)throw new Error('Docusaurus error: The <Tabs> component groupId prop is required if queryString=true, because this value is used as the search param name. You can also provide an explicit value such as queryString="my-search-param".');return r??null}({queryString:n,groupId:r});return[(0,d.aZ)(l),(0,t.useCallback)((e=>{if(!l)return;const n=new URLSearchParams(a.location.search);n.set(l,e),a.replace({...a.location,search:n.toString()})}),[l,a])]}function m(e){const{defaultValue:n,queryString:r=!1,groupId:a}=e,l=h(e),[s,d]=(0,t.useState)((()=>function(e){let{defaultValue:n,tabValues:r}=e;if(0===r.length)throw new Error("Docusaurus error: the <Tabs> component requires at least one <TabItem> children component");if(n){if(!f({value:n,tabValues:r}))throw new Error(`Docusaurus error: The <Tabs> has a defaultValue "${n}" but none of its children has the corresponding value. Available values are: ${r.map((e=>e.value)).join(", ")}. If you intend to show no default tab, use defaultValue={null} instead.`);return n}const t=r.find((e=>e.default))??r[0];if(!t)throw new Error("Unexpected error: 0 tabValues");return t.value}({defaultValue:n,tabValues:l}))),[c,u]=p({queryString:r,groupId:a}),[m,x]=function(e){let{groupId:n}=e;const r=function(e){return e?`docusaurus.tab.${e}`:null}(n),[a,l]=(0,o.Dv)(r);return[a,(0,t.useCallback)((e=>{r&&l.set(e)}),[r,l])]}({groupId:a}),b=(()=>{const e=c??m;return f({value:e,tabValues:l})?e:null})();(0,i.A)((()=>{b&&d(b)}),[b]);return{selectedValue:s,selectValue:(0,t.useCallback)((e=>{if(!f({value:e,tabValues:l}))throw new Error(`Can't select invalid tab value=${e}`);d(e),u(e),x(e)}),[u,x,l]),tabValues:l}}var x=r(7606);const b={tabList:"tabList_scTV",tabItem:"tabItem_tmPb"};var g=r(6106);function v(e){let{className:n,block:r,selectedValue:t,selectValue:s,tabValues:i}=e;const d=[],{blockElementScrollPositionUntilNextRender:c}=(0,l.a_)(),o=e=>{const n=e.currentTarget,r=d.indexOf(n),a=i[r].value;a!==t&&(c(n),s(a))},u=e=>{let n=null;switch(e.key){case"Enter":o(e);break;case"ArrowRight":{const r=d.indexOf(e.currentTarget)+1;n=d[r]??d[0];break}case"ArrowLeft":{const r=d.indexOf(e.currentTarget)-1;n=d[r]??d[d.length-1];break}}n?.focus()};return(0,g.jsx)("ul",{role:"tablist","aria-orientation":"horizontal",className:(0,a.A)("tabs",{"tabs--block":r},n),children:i.map((e=>{let{value:n,label:r,attributes:l}=e;return(0,g.jsx)("li",{role:"tab",tabIndex:t===n?0:-1,"aria-selected":t===n,ref:e=>d.push(e),onKeyDown:u,onClick:o,...l,className:(0,a.A)("tabs__item",b.tabItem,l?.className,{"tabs__item--active":t===n}),children:r??n},n)}))})}function j(e){let{lazy:n,children:r,selectedValue:l}=e;const s=(Array.isArray(r)?r:[r]).filter(Boolean);if(n){const e=s.find((e=>e.props.value===l));return e?(0,t.cloneElement)(e,{className:(0,a.A)("margin-top--md",e.props.className)}):null}return(0,g.jsx)("div",{className:"margin-top--md",children:s.map(((e,n)=>(0,t.cloneElement)(e,{key:n,hidden:e.props.value!==l})))})}function w(e){const n=m(e);return(0,g.jsxs)("div",{className:(0,a.A)("tabs-container",b.tabList),children:[(0,g.jsx)(v,{...n,...e}),(0,g.jsx)(j,{...n,...e})]})}function y(e){const n=(0,x.A)();return(0,g.jsx)(w,{...e,children:u(e.children)},String(n))}},2036:(e,n,r)=>{r.d(n,{R:()=>s,x:()=>i});var t=r(7378);const a={},l=t.createContext(a);function s(e){const n=t.useContext(l);return t.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function i(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(a):e.components||a:s(e.components),t.createElement(l.Provider,{value:n},e.children)}}}]);