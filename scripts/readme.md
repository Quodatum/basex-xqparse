curl -v -F key1=value1 -F text=<ebnf\BaseX.ebnf http://localhost:7777/rr/ui
http://localhost:7777/rr/ui
curl -s -F text=<ebnf\BaseX.ebnf -o test.xhtml -F task=VIEW -F frame=diagram -F width=992 http://localhost:7777/rr/ui
