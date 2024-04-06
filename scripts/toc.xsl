<!-- enrich rr  https://github.com/GuntherRademacher/rr output
     @author Andy Bunce, Quodatum
     @license Apache 2
-->
<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:svg="http://www.w3.org/2000/svg">  
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:param name="title" as="xs:string" select="'(untitled)'"/>
    <xsl:variable name="names"  select="/xhtml:html/xhtml:body/xhtml:p/xhtml:a/@name/string()=>sort()"  />
    
    
    <xsl:template match="xhtml:body" >
        <xsl:copy>
            <xhtml:header style="display:flex;justify-content:space-evenly;">
                <xhtml:div><xsl:value-of select="$title"/></xhtml:div>
                <xhtml:div >
                    <xhtml:details id="the-details">
                        <xhtml:summary>Find</xhtml:summary>
                        <xhtml:div>
                            <xsl:call-template name="toc"/>
                        </xhtml:div>
                    </xhtml:details>
                </xhtml:div>
            </xhtml:header>
            <xhtml:main>
                <xhtml:div >
                    <xsl:apply-templates />
                </xhtml:div>
            </xhtml:main> 
        </xsl:copy>
    </xsl:template>
    
    
    <!-- add extra styles -->
    <xsl:template match="xhtml:head/xhtml:style[@type='text/css'][1]" >
        <xsl:copy>
            html {
            scroll-behavior: smooth;
            }
            
            nav {
            top: 8vh;  
            width:100%;
            border: 1px solid #ffe9e9;
            background-color: #fffed6; 
            }
            
            #the-reset { padding: 2px; }
            #the-reset:hover {  background-color: bisque; }
            
            #the-list {
            list-style: none;
            margin: 0;
            padding: 10px;
            height:50vh;
            overflow-y:scroll;
            }
            
            #the-list li {
            padding: 1px;
            }
            #the-list li:hover { background: #fffed6; }
            #the-list li.hide { display: none; }
            
            header{
            height: 20px;
            padding: 0px;
            background-color: #fffed6; 
            z-index: 99;
            position: sticky;
            top: 0;
            }
            
            a{
            scroll-margin-top: 2rem;   
            }
            <xsl:value-of select="."/>
        </xsl:copy>
    </xsl:template>
    
    <!-- insert toc  -->
    <xsl:template name="toc" >
        <xhtml:nav class="section-nav">         
            <xhtml:label for="name">Productions:</xhtml:label>
            <xhtml:input type="text" id="the-filter" name="name" placeholder="filter..." size="5"/>
            <xhtml:a href="#" title="Reset" id="the-reset"
                     onclick="document.getElementById('the-details').removeAttribute('open');update();"
                >X</xhtml:a>
            <xhtml:ul id="the-list">
                <xsl:for-each select="$names">
                    <xhtml:li>
                        <xhtml:a href="#{.}"><xsl:value-of select="."/></xhtml:a>
                    </xhtml:li>    
                </xsl:for-each>              
            </xhtml:ul>
        </xhtml:nav> 
        <xhtml:script>
            var filter = document.getElementById("the-filter"), // search box
            list = document.querySelectorAll("#the-list li"); // all list items
            update=function(){
            let search = filter.value.toLowerCase();
            for (let i of list) {
            let item = i.innerHTML.toLowerCase();
            if (item.indexOf(search) == -1) { i.classList.add("hide"); }
            else { i.classList.remove("hide"); }
            }
            };
            window.addEventListener("load", () => {filter.onkeyup =update;});
        </xhtml:script>  
    </xsl:template>
    
</xsl:stylesheet>