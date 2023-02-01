(:~  update/create  index for RR generated ebnf diagrams 
:)

declare variable $SITE:=resolve-uri("../site/.",static-base-uri());


declare function local:create-index($file as xs:string){
 let $xhtml:=doc($file =>resolve-uri($SITE))
let $index-url:=("i-" || $file)=>resolve-uri($SITE)
let $names:= $xhtml//Q{http://www.w3.org/1999/xhtml}a/@name/string()
let $index:=doc("i-frame.xhtml") transform with {
  replace node id("names") with 
       <ul id="names">{
            $names!<li><a href="{ $file }#{.}" target="parser">{.}</a></li>,
            replace value of node  id("parser")/@src with $file
      }</ul>
}
return file:write($index-url, $index,map { "method": "xhtml"})
};
("BaseX.xhtml","XQueryTokenizer.xhtml")!local:create-index(.)

