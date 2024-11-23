"use strict";(self.webpackChunkwebsite=self.webpackChunkwebsite||[]).push([[2595],{75:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>u,contentTitle:()=>c,default:()=>p,frontMatter:()=>i,metadata:()=>l,toc:()=>d});const l=JSON.parse('{"id":"middleware/auto-placement","title":"autoPlacement","description":"Chooses the placement that has the most space available automatically.","source":"@site/docs/middleware/auto-placement.md","sourceDirName":"middleware","slug":"/middleware/auto-placement","permalink":"/aether/docs/middleware/auto-placement","draft":false,"unlisted":false,"editUrl":"https://github.com/quamatic/aether/tree/main/website/docs/middleware/auto-placement.md","tags":[],"version":"current","frontMatter":{"title":"autoPlacement"},"sidebar":"aether","previous":{"title":"flip","permalink":"/aether/docs/middleware/flip"},"next":{"title":"shift","permalink":"/aether/docs/middleware/shift"}}');var a=n(6106),s=n(2036),r=n(9269),o=n(8914);const i={title:"autoPlacement"},c=void 0,u={},d=[{value:"Example",id:"example",level:2},{value:"Input",id:"input",level:2},{value:"<code>crossAxis</code>",id:"crossaxis",level:3},{value:"<code>alignment</code>",id:"alignment",level:3},{value:"<code>autoAlignment</code>",id:"autoalignment",level:3},{value:"<code>allowedPlacements</code>",id:"allowedplacements",level:3},{value:"<code>detectOverflowConfig</code>",id:"detectoverflowconfig",level:3},{value:"Conflict with <code>flip()</code>",id:"conflict-with-flip",level:2}];function h(e){const t={a:"a",admonition:"admonition",code:"code",h2:"h2",h3:"h3",img:"img",li:"li",p:"p",pre:"pre",ul:"ul",...(0,s.R)(),...e.components};return(0,a.jsxs)(a.Fragment,{children:[(0,a.jsx)(t.p,{children:"Chooses the placement that has the most space available automatically."}),"\n",(0,a.jsx)(t.p,{children:"This is useful when you don\u2019t know which placement will be best for the floating element, or don\u2019t want to have to explicitly specify it."}),"\n",(0,a.jsx)("div",{class:"text--center",children:(0,a.jsx)(t.p,{children:(0,a.jsx)(t.img,{alt:"image",src:n(8479).A+"",width:"512",height:"384"})})}),"\n",(0,a.jsx)(t.h2,{id:"example",children:"Example"}),"\n",(0,a.jsx)(t.admonition,{type:"note",children:(0,a.jsxs)(t.p,{children:["This is an alternative to ",(0,a.jsx)(t.code,{children:"flip()"}),", so only one of either can be used. See ",(0,a.jsx)(t.a,{href:"#conflict-with-flip",children:"how they differ here"}),"."]})}),"\n",(0,a.jsx)(t.h2,{id:"input",children:"Input"}),"\n",(0,a.jsxs)(t.p,{children:["This is the input you can pass to ",(0,a.jsx)(t.code,{children:"autoPlacement()"}),":"]}),"\n",(0,a.jsxs)(r.A,{groupId:"package-manager",children:[(0,a.jsx)(o.A,{value:"wally",label:"luau",default:!0,children:(0,a.jsx)(t.pre,{children:(0,a.jsx)(t.code,{className:"language-luau",children:"type Input = {\n    crossAxis: boolean?,\n    alignment: Alignment?,\n    autoAlignment: boolean?,\n    allowedPlacements: { Placement }?,\n    detectOverflowConfig: DetectOverflowConfig?,\n}\n"})})}),(0,a.jsx)(o.A,{value:"roblox-ts",label:"roblox-ts",children:(0,a.jsx)(t.pre,{children:(0,a.jsx)(t.code,{className:"language-typescript",children:"interface Input {\n    crossAxis?: boolean;\n    alignment?: Aligment;\n    autoAlignment?: boolean;\n    allowedPlacements?: Placement[];\n    detectOverflowConfig?: DetectOverflowConfig;\n}\n"})})})]}),"\n",(0,a.jsx)(t.h3,{id:"crossaxis",children:(0,a.jsx)(t.code,{children:"crossAxis"})}),"\n",(0,a.jsxs)(t.p,{children:["Default value: ",(0,a.jsx)(t.code,{children:"false"})]}),"\n",(0,a.jsxs)(t.p,{children:["Determines whether a \u201cmost space\u201d strategy is also used for the cross axis (which runs along the alignment of the floating element). May be desirable when the ",(0,a.jsx)(t.code,{children:"allowedPlacements"})," are all on the same axis."]}),"\n",(0,a.jsx)(t.h3,{id:"alignment",children:(0,a.jsx)(t.code,{children:"alignment"})}),"\n",(0,a.jsxs)(t.p,{children:["Default value: ",(0,a.jsx)(t.code,{children:"nil"})]}),"\n",(0,a.jsxs)(t.p,{children:["Without options, ",(0,a.jsx)(t.code,{children:"autoPlacement()"})," will choose any of the Side placements which fit best, i.e. ",(0,a.jsx)(t.code,{children:'"top"'}),", ",(0,a.jsx)(t.code,{children:'"right"'}),", ",(0,a.jsx)(t.code,{children:'"bottom"'}),", or ",(0,a.jsx)(t.code,{children:'"left"'}),"."]}),"\n",(0,a.jsx)(t.p,{children:"By specifying an alignment, it will choose those aligned placements."}),"\n",(0,a.jsx)(t.h3,{id:"autoalignment",children:(0,a.jsx)(t.code,{children:"autoAlignment"})}),"\n",(0,a.jsxs)(t.p,{children:["Default value: ",(0,a.jsx)(t.code,{children:"true"})]}),"\n",(0,a.jsxs)(t.p,{children:["When ",(0,a.jsx)(t.code,{children:"alignment"})," is specified, this describes whether to automatically choose placements with the opposite alignment if they fit better."]}),"\n",(0,a.jsx)(t.h3,{id:"allowedplacements",children:(0,a.jsx)(t.code,{children:"allowedPlacements"})}),"\n",(0,a.jsx)(t.p,{children:"Default value: computed subset of all placements"}),"\n",(0,a.jsx)(t.p,{children:"Describes the placements which are allowed to be chosen."}),"\n",(0,a.jsx)(t.h3,{id:"detectoverflowconfig",children:(0,a.jsx)(t.code,{children:"detectOverflowConfig"})}),"\n",(0,a.jsxs)(t.p,{children:["All of ",(0,a.jsx)(t.a,{href:"../guides/collisions#config",children:"detectOverflow()"}),"'s config can be passed in this."]}),"\n",(0,a.jsxs)(t.h2,{id:"conflict-with-flip",children:["Conflict with ",(0,a.jsx)(t.a,{href:"./flip",children:(0,a.jsx)(t.code,{children:"flip()"})})]}),"\n",(0,a.jsxs)(t.p,{children:[(0,a.jsx)(t.code,{children:"flip()"})," and ",(0,a.jsx)(t.code,{children:"autoPlacement()"})," cannot be used together inside the same middleware array;\nmake sure you choose only one of them to use."]}),"\n",(0,a.jsx)(t.p,{children:"The reason is they both try to perform work on the placement but with opposing strategies. Therefore, they will continually try to change the result or work of the other one, leading to a reset loop."}),"\n",(0,a.jsxs)(t.ul,{children:["\n",(0,a.jsxs)(t.li,{children:[(0,a.jsx)(t.code,{children:"flip()"})," uses a fallback \u201cno space\u201d strategy. Ensures the preferred placement is kept unless there is no space left."]}),"\n",(0,a.jsxs)(t.li,{children:[(0,a.jsx)(t.code,{children:"autoPlacement()"})," uses a primary \u201cmost space\u201d strategy. Always chooses the placement with the most space available."]}),"\n"]})]})}function p(e={}){const{wrapper:t}={...(0,s.R)(),...e.components};return t?(0,a.jsx)(t,{...e,children:(0,a.jsx)(h,{...e})}):h(e)}},8914:(e,t,n)=>{n.d(t,{A:()=>r});n(7378);var l=n(3372);const a={tabItem:"tabItem_FS4i"};var s=n(6106);function r(e){let{children:t,hidden:n,className:r}=e;return(0,s.jsx)("div",{role:"tabpanel",className:(0,l.A)(a.tabItem,r),hidden:n,children:t})}},9269:(e,t,n)=>{n.d(t,{A:()=>y});var l=n(7378),a=n(3372),s=n(2703),r=n(505),o=n(5086),i=n(6656),c=n(2097),u=n(421);function d(e){return l.Children.toArray(e).filter((e=>"\n"!==e)).map((e=>{if(!e||(0,l.isValidElement)(e)&&function(e){const{props:t}=e;return!!t&&"object"==typeof t&&"value"in t}(e))return e;throw new Error(`Docusaurus error: Bad <Tabs> child <${"string"==typeof e.type?e.type:e.type.name}>: all children of the <Tabs> component should be <TabItem>, and every <TabItem> should have a unique "value" prop.`)}))?.filter(Boolean)??[]}function h(e){const{values:t,children:n}=e;return(0,l.useMemo)((()=>{const e=t??function(e){return d(e).map((e=>{let{props:{value:t,label:n,attributes:l,default:a}}=e;return{value:t,label:n,attributes:l,default:a}}))}(n);return function(e){const t=(0,c.XI)(e,((e,t)=>e.value===t.value));if(t.length>0)throw new Error(`Docusaurus error: Duplicate values "${t.map((e=>e.value)).join(", ")}" found in <Tabs>. Every value needs to be unique.`)}(e),e}),[t,n])}function p(e){let{value:t,tabValues:n}=e;return n.some((e=>e.value===t))}function m(e){let{queryString:t=!1,groupId:n}=e;const a=(0,r.W6)(),s=function(e){let{queryString:t=!1,groupId:n}=e;if("string"==typeof t)return t;if(!1===t)return null;if(!0===t&&!n)throw new Error('Docusaurus error: The <Tabs> component groupId prop is required if queryString=true, because this value is used as the search param name. You can also provide an explicit value such as queryString="my-search-param".');return n??null}({queryString:t,groupId:n});return[(0,i.aZ)(s),(0,l.useCallback)((e=>{if(!s)return;const t=new URLSearchParams(a.location.search);t.set(s,e),a.replace({...a.location,search:t.toString()})}),[s,a])]}function f(e){const{defaultValue:t,queryString:n=!1,groupId:a}=e,s=h(e),[r,i]=(0,l.useState)((()=>function(e){let{defaultValue:t,tabValues:n}=e;if(0===n.length)throw new Error("Docusaurus error: the <Tabs> component requires at least one <TabItem> children component");if(t){if(!p({value:t,tabValues:n}))throw new Error(`Docusaurus error: The <Tabs> has a defaultValue "${t}" but none of its children has the corresponding value. Available values are: ${n.map((e=>e.value)).join(", ")}. If you intend to show no default tab, use defaultValue={null} instead.`);return t}const l=n.find((e=>e.default))??n[0];if(!l)throw new Error("Unexpected error: 0 tabValues");return l.value}({defaultValue:t,tabValues:s}))),[c,d]=m({queryString:n,groupId:a}),[f,x]=function(e){let{groupId:t}=e;const n=function(e){return e?`docusaurus.tab.${e}`:null}(t),[a,s]=(0,u.Dv)(n);return[a,(0,l.useCallback)((e=>{n&&s.set(e)}),[n,s])]}({groupId:a}),b=(()=>{const e=c??f;return p({value:e,tabValues:s})?e:null})();(0,o.A)((()=>{b&&i(b)}),[b]);return{selectedValue:r,selectValue:(0,l.useCallback)((e=>{if(!p({value:e,tabValues:s}))throw new Error(`Can't select invalid tab value=${e}`);i(e),d(e),x(e)}),[d,x,s]),tabValues:s}}var x=n(7606);const b={tabList:"tabList_scTV",tabItem:"tabItem_tmPb"};var g=n(6106);function v(e){let{className:t,block:n,selectedValue:l,selectValue:r,tabValues:o}=e;const i=[],{blockElementScrollPositionUntilNextRender:c}=(0,s.a_)(),u=e=>{const t=e.currentTarget,n=i.indexOf(t),a=o[n].value;a!==l&&(c(t),r(a))},d=e=>{let t=null;switch(e.key){case"Enter":u(e);break;case"ArrowRight":{const n=i.indexOf(e.currentTarget)+1;t=i[n]??i[0];break}case"ArrowLeft":{const n=i.indexOf(e.currentTarget)-1;t=i[n]??i[i.length-1];break}}t?.focus()};return(0,g.jsx)("ul",{role:"tablist","aria-orientation":"horizontal",className:(0,a.A)("tabs",{"tabs--block":n},t),children:o.map((e=>{let{value:t,label:n,attributes:s}=e;return(0,g.jsx)("li",{role:"tab",tabIndex:l===t?0:-1,"aria-selected":l===t,ref:e=>i.push(e),onKeyDown:d,onClick:u,...s,className:(0,a.A)("tabs__item",b.tabItem,s?.className,{"tabs__item--active":l===t}),children:n??t},t)}))})}function w(e){let{lazy:t,children:n,selectedValue:s}=e;const r=(Array.isArray(n)?n:[n]).filter(Boolean);if(t){const e=r.find((e=>e.props.value===s));return e?(0,l.cloneElement)(e,{className:(0,a.A)("margin-top--md",e.props.className)}):null}return(0,g.jsx)("div",{className:"margin-top--md",children:r.map(((e,t)=>(0,l.cloneElement)(e,{key:t,hidden:e.props.value!==s})))})}function j(e){const t=f(e);return(0,g.jsxs)("div",{className:(0,a.A)("tabs-container",b.tabList),children:[(0,g.jsx)(v,{...t,...e}),(0,g.jsx)(w,{...t,...e})]})}function y(e){const t=(0,x.A)();return(0,g.jsx)(j,{...e,children:d(e.children)},String(t))}},8479:(e,t,n)=>{n.d(t,{A:()=>l});const l=n.p+"assets/images/auto-placement-7d1bec7ec5e96b040952ac4844bb7715.gif"},2036:(e,t,n)=>{n.d(t,{R:()=>r,x:()=>o});var l=n(7378);const a={},s=l.createContext(a);function r(e){const t=l.useContext(s);return l.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function o(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(a):e.components||a:r(e.components),l.createElement(s.Provider,{value:t},e.children)}}}]);