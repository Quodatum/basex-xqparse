declare namespace xhtml="http://www.w3.org/1999/xhtml";

let $a:=doc("C:\Users\mrwhe\git\quodatum\basex-xqparse\site\BaseX.html")

let $names:= $a/*:html/*:body/*:p/*:a/@name/string()=>sort()

let $main:=<xhtml:div>{ $a/*:html/*:body/* }</xhtml:div>
let $nav:=<nav class="section-nav">
		<ol>
			<li><a href="#introduction">Introduction</a></li>
			
		</ol>
	</nav>
let $new:=<xhtml:html>
         {$a/*:html/*:head},
         <xhtml:body>      
         <xhtml:div>{ $a/*:html/*:body}</xhtml:div>,
         {$nav}
         </xhtml:body>  
   </xhtml:html> 
return file:write("c:\tmp\basex.xhtml",$new) 
  