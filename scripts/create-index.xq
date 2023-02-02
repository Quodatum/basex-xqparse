(:~  update/create  index for RR generated ebnf diagrams 
:)
declare namespace xhtml= "http://www.w3.org/1999/xhtml";
declare variable $SITE:=resolve-uri("../site/.",static-base-uri());

(:~ write index file in site 
@param $file xhtml filename of RR generated doc
:)
declare function local:create-index($file as xs:string){
      let $xhtml:=doc($file =>resolve-uri($SITE))
      let $index-url:=("i-" || $file)=>resolve-uri($SITE)
      let $names:= $xhtml//xhtml:p/xhtml:a/@name/string()
      let $index:=doc("i-frame.tpl") transform with {
                        replace value of node  xhtml:html/xhtml:title with substring-before($file,".") || " EBNF",
                        replace value of node  id("title") with substring-before($file,"."),
                        replace value of node  id("parser")/@src with $file,
                        replace node id("names") with 
                              <ul id="names">{
                                    $names!<li><a href="{ $file }#{.}" target="parser">{.}</a></li>
                              }</ul>
      }
      return file:write($index-url, $index,map { "method": "xhtml"})
};

(:~ process files:)
("BaseX.xhtml","XQueryTokenizer.xhtml")!local:create-index(.)

