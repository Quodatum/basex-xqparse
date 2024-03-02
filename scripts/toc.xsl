<!-- enrich rr output -->
<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"> 
    <xsl:output method="html" version="5"/> 
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:variable name="names"  select="/xhtml:html/xhtml:body/xhtml:p/xhtml:a/@name/string()=>sort()"  />
    
    
    <xsl:template match="xhtml:body" >
        <xhtml:body>
            <xhtml:main>
                <xhtml:div>
                    <xsl:apply-templates />
                </xhtml:div>
                <xsl:call-template name="toc"/>
            </xhtml:main>
            
        </xhtml:body>
    </xsl:template>
    
    <xsl:template match="xhtml:head/xhtml:style[@type='text/css'][1]" >
        <xhtml:style type="text/css">
            html {
            scroll-behavior: smooth;
            }
            
            nav {
            position: fixed;
            top: 5vh;
            right:5vh;
            height:80vh;
            width:35vh;
            overflow-y:scroll;
            }
            
            #the-list {
            list-style: none;
            margin: 0;
            padding: 0;
            }
            
            #the-list li {
            padding: 2px;
            border-bottom: 1px solid #ffe9e9;
            }
            #the-list li:hover { background: #fffed6; }
            #the-list li.hide { display: none; }
            <xsl:value-of select="."/>
        </xhtml:style>
    </xsl:template>
    
    <xsl:template name="toc" >
        <xhtml:nav class="section-nav">
            
            <xhtml:label for="name">Productions:</xhtml:label>
            <xhtml:input type="text" id="the-filter" name="name" placeholder="filter..." size="5"/>
            <xhtml:a href="#" title="Clear" onclick="document.getElementById('the-filter').value='';
                                                     filter.onkeyup();"
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
            window.addEventListener("load", () => {
            var filter = document.getElementById("the-filter"), // search box
            list = document.querySelectorAll("#the-list li"); // all list items
            
            filter.onkeyup = () => {
            let search = filter.value.toLowerCase();
                for (let i of list) {
                let item = i.innerHTML.toLowerCase();
                if (item.indexOf(search) == -1) { i.classList.add("hide"); }
                else { i.classList.remove("hide"); }
                }
            };
            });
        </xhtml:script>  
    </xsl:template>
    
</xsl:stylesheet>