(:~ post utils :)
module namespace qform = 'urn:quodatum:http.form';

(:~ post form data in $fields to $url :)
declare function qform:post-form($fields as map(*), $url as xs:string)
as item(){
  let $names:= map:keys($fields) 
  let $req:=<http:request method='POST'>
              <http:multipart media-type='multipart/form-data'>{
                $names!(
                  <http:header name='content-disposition' value='form-data; name="{.}"'/>,
                  <http:body media-type='application/octet-stream'/>
                )
             }</http:multipart>
           </http:request>
  let $result:= http:send-request($req, $url, $names!$fields(.))
  return if($result[1]/@status eq "200")
         then $result[2]
         else error(xs:QName("qform:post-form"),$result[1]/@message)        
};