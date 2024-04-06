(:~ generate site :)
import module namespace qform = 'urn:quodatum:http.form' at 'postutil.xqm';
(:~ local RR server :)
declare variable $rr-server := "http://localhost:7777/rr/ui";

declare variable $base := "../ebnf/"=>file:resolve-path(file:base-dir() );
declare variable $dest := "../site/"=>file:resolve-path(file:base-dir() );

declare variable $opts:=map{
 "task":"VIEW",
 "frame":"diagram",
 "width":992
};
for $file in file:list($base,false(),"*.ebnf")
let $ebnf:=file:read-text(file:resolve-path($file,$base))
let $rr:=qform:post-form(map:put($opts,"ebnf",$ebnf),$rr-server)
let $t:=xslt:transform($rr,"toc.xsl",map{"title": $file})
let $d:=file:resolve-path($file || ".xhtml",$dest )
return file:write($d,$t,map{"method":"xhtml"})