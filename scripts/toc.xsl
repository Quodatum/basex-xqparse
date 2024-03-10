<!-- enrich rr  https://github.com/GuntherRademacher/rroutput
     @author Andy Bunce, Quodatum
     @license Apache 2
-->
<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:svg="http://www.w3.org/2000/svg">  
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:variable name="names"  select="/xhtml:html/xhtml:body/xhtml:p/xhtml:a/@name/string()=>sort()"  />
    
    
    <xsl:template match="xhtml:body" >
        <xsl:copy>
            <xhtml:main>
                <xhtml:div>
                    <xsl:apply-templates />
                </xhtml:div>
                <xsl:call-template name="toc"/>
            </xhtml:main> 
        </xsl:copy>
    </xsl:template>

    <!-- hide 1st empty svg (rr bug?) -->
    <xsl:template match="svg:svg[1]" >
        <xsl:copy>
            <xsl:attribute name="display" select="'none'"/>
            <xsl:apply-templates />
        </xsl:copy>
    </xsl:template>

    <!-- add extra styles -->
    <xsl:template match="xhtml:head/xhtml:style[@type='text/css'][1]" >
        <xsl:copy>
            html {
            scroll-behavior: smooth;
            }
            
            nav {
            position: fixed;
            top: 5vh;
            right:5vh;     
            width:35vh;
            border: 1px solid #ffe9e9
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
            <xsl:value-of select="."/>
        </xsl:copy>
    </xsl:template>
    
    <!-- insert toc  -->
    <xsl:template name="toc" >
        <xhtml:nav class="section-nav">         
            <xhtml:label for="name">Productions:</xhtml:label>
            <xhtml:input type="text" id="the-filter" name="name" placeholder="filter..." size="5"/>
            <xhtml:a href="#" title="Reset" id="the-reset"
                     onclick="document.getElementById('the-filter').value='';update();"
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