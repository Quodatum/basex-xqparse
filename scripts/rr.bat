@echo off
setLocal EnableDelayedExpansion

REM Path to core and library classes
set MAIN=%~dp0\..
java -jar "C:\Users\mrwhe\apps\apache-tomcat-9.0.86\webapps\rr.war" -out:"%MAIN%\site\test.html" %MAIN%\ebnf\BaseX.ebnf