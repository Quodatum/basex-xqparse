(:~ $rr-web :)
declare variable $rr-server := "http://localhost:7777/rr/ui";

declare function local:railroad($ebnf as xs:string,$server as xs:string,$opts as map(*)?)
{
let $defaults:=map{
        "name":"compilation",
        "task":"VIEW",
        "options":("factoring","eliminaterecursion","inline","keep"),
        "uri":""
    }  
let $req:=<http:request method='POST'>
          <http:multipart media-type='multipart/form-data'>
            <http:header name='content-disposition' value='form-data; name="text"'/>
            <http:body media-type='application/octet-stream'/>
             <http:header name='content-disposition' value='form-data; name="name"'/>
            <http:body media-type='application/octet-stream'/>
          </http:multipart>
         </http:request>
  let $result:= http:send-request($req,$server,($ebnf,"compilation"))
  return if($result[1]/@status eq "200")
         then $result[2]
         else error(xs:QName("local:railroad"),$result[1]/@message)
};


let $ebnf:=file:read-text("C:\Users\mrwhe\git\quodatum\basex-xqparse\ebnf\BaseX.ebnf")
let $rr:=local:railroad($ebnf,$rr-server, map{})
(: let $t:=xslt:transform-text($rr,"toc.xsl")
return file:write-text("c:\tmp\gg.html",$t) :) 
return $rr