<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    xpath-default-namespace="urn:isbn:1-931666-22-9"
    version="2.0">
    
    <!-- SANC StyleSheet {Version: 2.0; Author: Jeremy M. Gibson (Systems Integration Librarian); Date: 2014-10-12} -->
    <!-- SANC StyleSheet {Version: 2.1; Author: Jeremy M. Gibson (Systems Integration Librarian); Date: 2015-06-06} -->
    <!-- SANC StyleSheet {Version: 2.2; Author: Jeremy M. Gibson (Systems Integration Librarian); Date: 2015-09-01} -->
    <!-- SANC StyleSheet {Version: 3.0; Author: Jeremy M. Gibson (Systems Integration Librarian); Date: 2016-07-01} -->
    
    <xsl:output
        doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        use-character-maps="no-control-characters"
    />
    <xsl:character-map name="no-control-characters">
        <xsl:output-character character="&#127;" string=" "/>
        <xsl:output-character character="&#128;" string="?"/>
        <xsl:output-character character="&#129;" string=" "/>
        <xsl:output-character character="&#130;" string=","/>
        <xsl:output-character character="&#131;" string=" "/>
        <xsl:output-character character="&#132;" string=" "/>
        <xsl:output-character character="&#133;" string=" "/>
        <xsl:output-character character="&#134;" string=" "/>
        <xsl:output-character character="&#135;" string=" "/>
        <xsl:output-character character="&#136;" string=" "/>
        <xsl:output-character character="&#137;" string=" "/>
        <xsl:output-character character="&#138;" string=" "/>
        <xsl:output-character character="&#139;" string=" "/>
        <xsl:output-character character="&#140;" string=" "/>
        <xsl:output-character character="&#141;" string=" "/>
        <xsl:output-character character="&#142;" string=" "/>
        <xsl:output-character character="&#143;" string=" "/>
        <xsl:output-character character="&#144;" string=" "/>
        <xsl:output-character character="&#145;" string="'"/>
        <xsl:output-character character="&#146;" string="'"/>
        <xsl:output-character character="&#147;" string='"'/>
        <xsl:output-character character="&#148;" string='"'/>
        <xsl:output-character character="&#149;" string=" "/>
        <xsl:output-character character="&#150;" string="-"/>
        <xsl:output-character character="&#151;" string="--"/>
        <xsl:output-character character="&#152;" string="~"/>
        <xsl:output-character character="&#153;" string=" "/>
        <xsl:output-character character="&#154;" string=" "/>
        <xsl:output-character character="&#155;" string=" "/>
        <xsl:output-character character="&#156;" string=" "/>
        <xsl:output-character character="&#157;" string=" "/>
        <xsl:output-character character="&#158;" string=" "/>
        <xsl:output-character character="&#159;" string=" "/>
    </xsl:character-map>
    
    <!--Change the following select attribute to the domain (path) your xslt folder is located -->
    <xsl:variable name="DOMAIN" select="'http://ead.archives.ncdcr.gov/build'"></xsl:variable>
    <xsl:variable name="Labels">
        <xsl:value-of select="concat($DOMAIN, '/includes/labels.xml')"/>
    </xsl:variable>
    <xsl:variable name="LOOKUP" select="document($Labels, /)"></xsl:variable>
    
    
    <xsl:template match="ead">
        <html>

            <head>
                <meta charset="utf-8"/>
                 <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
                 <title></title>
                 <meta name="description" content=""/>
                 <meta name="viewport" content="width=device-width, initial-scale=1"/>
                                
                <link rel="stylesheet" href="{$DOMAIN}/css/bootstrap.min.css"/>
                <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
                                        rel="stylesheet" type="text/css"/>

                <link rel="stylesheet" href="{$DOMAIN}/css/sanc_v_3_0.css"/>
                
            </head>
            
            <body>
                <!-- NavBar -->
                <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
                    <div class="container">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                                <span class="sr-only">Toggle navigation</span>
                            </button>
                            <a class="navbar-brand" href="http://www.ncdcr.gov/archives/" target="_blank">State Archives of North Carolina</a>
                        </div>
                        
                        <div id="navbar" class="navbar-collapse collapse">
                            <ul class="nav navbar-nav">
                                <li><a href="#">Top of Page</a></li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Finding Aid Sections<span class="caret"></span></a>
                                    <ul class="dropdown-menu" role="menu"> <xsl:apply-templates select="archdesc" mode="nav_bar"/>
                                    </ul>
                                </li>
                            </ul>
                            <xsl:if test="//c02">
                                <ul class="nav navbar-nav navbar-right">
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Container List Sections<span class="caret"></span></a>
                                        <ul class="dropdown-menu" role="menu"><xsl:call-template name="dsc_bar"/></ul>
                                    </li>
                                </ul>
                            </xsl:if>
                        </div>
                    </div><!-- END CONTAINER -->
                </nav>
                
                <!-- /NavBar -->
                
                <!-- Large callout gives abstract and name of Finding Aid -->
                <div class="jumbotron container-fullwidth">
                    <div class="row">
                        <div class="col-sm-3 rowspan">
                            <img id="callout" class="img-responsive" src="{$DOMAIN}/imgs/great_seal_small_01.jpg" alt="callout"/>
                        </div>
                        <div class="col-sm-8">
                            <h3><xsl:value-of select="//archdesc/did/unittitle"/></h3>
                            <hr/>
                            <xsl:variable name="abstract" select="substring((/ead/archdesc/did/abstract)[1],1, 700)"></xsl:variable>
                            <xsl:variable name="scope" select="(/ead/archdesc/scopecontent/p)[1]"></xsl:variable>
                            <xsl:choose>
                                <xsl:when test="string-length($abstract) = 0">
                                    <p><xsl:value-of select="concat(substring($scope, 1, 700), ' ... (more below)')"/></p>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:if test="string-length($abstract) &gt;= 700">
                                        <p><xsl:value-of select="concat($abstract, ' ... (more below)')"/></p>
                                    </xsl:if>
                                    <xsl:if test="string-length($abstract) &lt; 700">
                                        <p><xsl:value-of select="$abstract"/></p>
                                    </xsl:if>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </div>
                </div>
                
                
                <div class="container" style="margin-top: 100px">
                <!-- ARCHDESC -->
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <a data-toggle="collapse" href="#arch-desc">Archival Description</a>
                        </h3>
                    </div>
                    <div id="arch-desc" class="panel-collapse collapse">
                        <div class="panel-body">
                            <xsl:apply-templates select="archdesc"/>  
                        </div>
                    </div>
                </div>
                  
                <!-- /ARCHDESC -->
                
                <!-- DSC -->
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                <a data-toggle="collapse" href="#archdesc_dsc">Container List</a>
                            </h3>
                        </div>
                        <div id="archdesc_dsc" class="panel-collapse collapse">
                            <div class="panel-body">
                                <xsl:apply-templates select="//dsc"/>
                            </div>
                        </div>
                    </div>
                        
                <!-- /DSC -->
                   
                    
               <!-- END OF MAIN CONTAINER -->
                </div>

                <!-- END CONTENTS -->
                <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
                <script src="{$DOMAIN}/js/bootstrap.min.js"></script>
                    
                <script src="{$DOMAIN}/js/plugins.js"></script>
                <script src="{$DOMAIN}/js/sanc_main.js"></script>
                
            </body>
        </html>
    </xsl:template>
    <!-- ################################ END HTML ######################################### -->
    
    <!-- BEGIN ***** Navigation Bar ***** BLOCK -->
    
    <!--
        The Navigation Bar is built by traversing the archdesc node.
        For each section a navigation link is created. The link is created
        using the EAD element name, and the text is taken from the cannonical element
        name as found in the EAD specification.
   -->
    
    <xsl:template match="archdesc/child::*" mode="nav_bar">
        <xsl:call-template name="basic" />
    </xsl:template>
    
    <!--
        The Container List Menu is built by traversing the <dsc> node.
        EACH C01 is listed using it's <did> <unittitle>
   -->
    
    <xsl:template name="dsc_bar">
        <xsl:for-each select="//dsc/*">
            <xsl:variable name="href" select="./@id"/>
            <xsl:variable name="title" select="./did/unittitle"/>
            <li><a href="#{$href}">
                <xsl:value-of select="$title"/>
            </a></li>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="basic">
        <xsl:variable name="href" select="name()" />
        <li><a href="#archdesc_{$href}"><xsl:value-of xpath-default-namespace="" select="$LOOKUP/elements/element[@tag=$href]/@human"/></a></li>
    </xsl:template>
    
    <!-- END ***** Navigation Bar ***** BLOCK -->
    
    
    <xsl:template match="dsc">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- #### C01 ##### -->
    
    <xsl:template match="c01">
        <xsl:variable name="id" select="@id"/>
        <xsl:variable name="level" select="@level"/>
        <xsl:variable name="title" select="did/unittitle"/>
        <xsl:variable name="unitid" select="did/unitid[@type eq 'local ID']"/>
        <xsl:if test="@level = 'item'">
            <div id="{$id}" class="row">
                <div class="col-md-2"><xsl:value-of select="$unitid"/></div>
                <div class="col-md-10"><xsl:value-of select="$title"/></div>
            </div>
        </xsl:if>
        <xsl:if test="@level != 'item'">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <a data-toggle="collapse" href="#{$id}"><xsl:value-of select="$unitid"/>: <xsl:value-of select="$title"/></a>
                    </h3>
                </div>
                <div id="{$id}" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates>
                            <xsl:with-param name="in_dsc" select="'1'"/>
                        </xsl:apply-templates>
                    </div>
                </div>
            </div>
        </xsl:if>
    </xsl:template>
    <!-- #### /C01 #### -->
    
    <!-- #### C02 ##### -->
    <xsl:template match="c02">
        <xsl:variable name="id" select="@id"/>
        <xsl:variable name="level" select="@level"/>
        <xsl:variable name="title" select="did/unittitle"/>
        <xsl:variable name="unitid" select="did/unitid"/>
        <xsl:variable name="id_type" select="did/unitid/@type"/>
        
        
        <xsl:if test="@level = 'item'">
            <div id="{$id}" class="row">
                <div class="col-md-2"><xsl:value-of select="$unitid"/></div>
                <div class="col-md-10"><xsl:value-of select="$title"/></div>
            </div>
        </xsl:if>
        <xsl:if test="@level != 'item'">
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#{$id}"><xsl:value-of select="$title"/></a>
                    </h4>
                </div>
                <div id="{$id}" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates>
                            <xsl:with-param name="in_dsc" select="'1'"/>
                        </xsl:apply-templates>
                    </div>
                </div>
            </div>
        </xsl:if>
    </xsl:template>
    
    <!-- #### /C02 #### -->
    
    <!-- #### C03 #### -->
    <xsl:template match="c03">
        <xsl:variable name="id" select="@id"/>
        <xsl:variable name="level" select="@level"/>
        <xsl:variable name="title" select="did/unittitle"/>
        <xsl:variable name="unitid" select="did/unitid"/>
        <xsl:variable name="id_type" select="did/unitid/@type"/>
        
        
        <xsl:if test="@level = 'item'">
            <div id="{$id}" class="row">
                <div class="col-md-2"><xsl:value-of select="$unitid"/></div>
                <div class="col-md-10"><xsl:value-of select="$title"/></div>
            </div>
        </xsl:if>
        <xsl:if test="@level != 'item'">
            <div class="panel panel-danger">
                <div class="panel-heading">
                    <h5 class="panel-title">
                        <a data-toggle="collapse" href="#{$id}"><xsl:value-of select="$title"/></a>
                    </h5>
                </div>
                <div id="{$id}" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates>
                            <xsl:with-param name="in_dsc" select="'1'"/>
                        </xsl:apply-templates>
                    </div>
                </div>
            </div>
        </xsl:if>
    </xsl:template>
    <!-- #### /C03 #### -->
    
    <!-- #### C04 #### -->
    <xsl:template match="c04">
        <xsl:variable name="id" select="@id"/>
        <xsl:variable name="level" select="@level"/>
        <xsl:variable name="title" select="did/unittitle"/>
        <xsl:variable name="unitid" select="did/unitid"/>
        <xsl:variable name="id_type" select="did/unitid/@type"/>
        
        
        <xsl:if test="@level = 'item'">
            <div id="{$id}" class="row">
                <div class="col-md-2"><xsl:value-of select="$unitid"/></div>
                <div class="col-md-10"><xsl:value-of select="$title"/></div>
            </div>
        </xsl:if>
        <xsl:if test="@level != 'item'">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h5 class="panel-title">
                        <a data-toggle="collapse" href="#{$id}"><xsl:value-of select="$title"/></a>
                    </h5>
                </div>
                <div id="{$id}" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates>
                            <xsl:with-param name="in_dsc" select="'1'"/>
                        </xsl:apply-templates>
                    </div>
                </div>
            </div>
        </xsl:if>
    </xsl:template>
    <!-- #### /C04 #### -->
    
    <!-- #### C05 #### -->
    <xsl:template match="c05">
        <xsl:variable name="id" select="@id"/>
        <xsl:variable name="level" select="@level"/>
        <xsl:variable name="title" select="did/unittitle"/>
        <xsl:variable name="unitid" select="did/unitid"/>
        <xsl:variable name="id_type" select="did/unitid/@type"/>
        
        
        <xsl:if test="@level = 'item'">
            <div id="{$id}" class="row">
                <div class="col-md-2"><xsl:value-of select="$unitid"/></div>
                <div class="col-md-10"><xsl:value-of select="$title"/></div>
            </div>
        </xsl:if>
        <xsl:if test="@level != 'item'">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h5 class="panel-title">
                        <a data-toggle="collapse" href="#{$id}"><xsl:value-of select="$title"/></a>
                    </h5>
                </div>
                <div id="{$id}" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates>
                            <xsl:with-param name="in_dsc" select="'1'"/>
                        </xsl:apply-templates>
                    </div>
                </div>
            </div>
        </xsl:if>
    </xsl:template>
    <!-- #### /C05 #### -->
    
    <xsl:template name="two_col_row">
        <xsl:param name="cell_1"/>
        <xsl:param name="cell_2"/>
        <div class="row">
            <div class="col-md-2"><strong><xsl:value-of select="$cell_1"/></strong></div>
            <div class="col-md-9"><xsl:value-of select="$cell_2"/></div>
        </div>
    </xsl:template>
    
    <xsl:template name="three_col_row_wide">
        <xsl:param name="cell_1"/>
        <xsl:param name="cell_2"/>
        <xsl:param name="cell_3"/>
        <div class="row">
            <div class="col-md-3"><strong><xsl:value-of select="$cell_1"/></strong></div>
            <div class="col-md-4"><xsl:value-of select="$cell_2"/></div>
            <div class="col-md-4"><xsl:value-of select="$cell_3"/></div>
        </div>
    </xsl:template>
    
    <xsl:template name="three_col_row_narrow">
        <xsl:param name="cell_1"/>
        <xsl:param name="cell_2"/>
        <xsl:param name="cell_3"/>
        <div class="row">
            <div class="col-md-2"><strong><xsl:value-of select="$cell_1"/></strong></div>
            <div class="col-md-2"><xsl:value-of select="$cell_2"/></div>
            <div class="col-md-7"><xsl:value-of select="$cell_3"/></div>
        </div>
    </xsl:template>
    
    <!-- ###### ARCHDESC ####### -->
    <xsl:template match="archdesc">
        
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <a data-toggle="collapse" href="#archdesc_did">Descriptive Identification</a>
                </h3>
            </div>
            <div id="archdesc_did" class="panel-collapse collapse">
                <div class="panel-body">
                    <xsl:apply-templates select="did"/>
                </div>
            </div>
        </div>
        
        <xsl:if test="arrangement">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <a data-toggle="collapse" href="#archdesc_arrangement">Arrangement</a>
                    </h3>
                </div>
                <div id="archdesc_arrangement" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates select="arrangement"/>
                    </div>
                </div>
            </div>
        </xsl:if>
        
        <xsl:if test="accessrestrict">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <a data-toggle="collapse" href="#archdesc_accessrestrict">Access and Use Restrictions</a>
                    </h3>
                </div>
                <div id="archdesc_accessrestrict" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates select="accessrestrict"/>
                        <xsl:apply-templates select="userestrict"/>
                    </div>
                </div>
            </div>
        </xsl:if>
        
        <xsl:if test="processinfo">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <a data-toggle="collapse" href="#archdesc_processinfo">Processing Information</a>
                    </h3>
                </div>
                <div id="archdesc_processinfo" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates select="processinfo"/>
                    </div>
                </div>
            </div>
        </xsl:if>
        
        <xsl:if test="bioghist">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <a data-toggle="collapse" href="#archdesc_bioghist">Biography or History</a>
                    </h3>
                </div>
                <div id="archdesc_bioghist" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates select="bioghist"/>
                    </div>
                </div>
            </div>
        </xsl:if>
        
        <xsl:if test="prefercite">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <a data-toggle="collapse" href="#archdesc_prefercite">Preferred Citation</a>
                    </h3>
                </div>
                <div id="archdesc_prefercite" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates select="prefercite"/>
                    </div>
                </div>
            </div>
        </xsl:if>
        
        <xsl:if test="acqinfo">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <a data-toggle="collapse" href="#archdesc_acqinfo">Acquistion Information</a>
                    </h3>
                </div>
                <div id="archdesc_acqinfo" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates select="acqinfo"/>
                    </div>
                </div>
            </div>
        </xsl:if>
        
        <xsl:if test="relatedmaterial">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <a data-toggle="collapse" href="#archdesc_relatedmaterial">Related Material</a>
                    </h3>
                </div>
                <div id="archdesc_relatedmaterial" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates select="relatedmaterial"/>
                    </div>
                </div>
            </div>
        </xsl:if>
        
        <xsl:if test="scopecontent">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <a data-toggle="collapse" href="#archdesc_scopecontent">Scope and Contents</a>
                    </h3>
                </div>
                <div id="archdesc_scopecontent" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates select="scopecontent"/>
                    </div>
                </div>
            </div>
        </xsl:if>
        
        <xsl:if test="controlaccess">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <a data-toggle="collapse" href="#archdesc_controlaccess">Controlled Access Headings</a>
                    </h3>
                </div>
                <div id="archdesc_controlaccess" class="panel-collapse collapse">
                    <div class="panel-body">
                        <xsl:apply-templates select="controlaccess"/>
                    </div>
                </div>
            </div>
        </xsl:if>
    </xsl:template>
    
    <!-- ###### /ARCHDESC ###### -->
    
    <!-- ###### DID Elements ######### -->
    
    <xsl:template match="did">
        <xsl:variable name="id"><xsl:value-of select="../@id"/></xsl:variable>
        <xsl:variable name="level">
            <xsl:value-of select="../@level"/>
        </xsl:variable>
        <div id="did-{$id}" class="container">
            <div class="section">
                <div class="row">
                    <div class="collapse" id="did-contents-{$id}">
                        <div class="container">
                            <div class="col-md-11">
                                <div class="section">
                                    <div class="row">
                                        <xsl:apply-templates>
                                            <xsl:with-param name="id" select="$id"/>
                                        </xsl:apply-templates>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="abstract">
        <div class="row">
            <div class="col-md-2"><strong>Abstract</strong></div>
            <div class="col-md-9"><xsl:apply-templates/></div>
        </div>
    </xsl:template>
    
    <xsl:template match="physloc">
        <xsl:call-template name="two_col_row">
            <xsl:with-param name="cell_1">Location</xsl:with-param>
            <xsl:with-param name="cell_2"><xsl:apply-templates/></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="unittitle">
        <xsl:call-template name="two_col_row">
            <xsl:with-param name="cell_1">Title</xsl:with-param>
            <xsl:with-param name="cell_2"><xsl:value-of select="."/></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="unitid">
        <xsl:if test=".[@type eq 'local ID']">
            <xsl:call-template name="two_col_row">
                <xsl:with-param name="cell_1">Local ID</xsl:with-param>
                <xsl:with-param name="cell_2"><xsl:value-of select=".[@type eq 'local ID']"/></xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="unitdate">
        <xsl:call-template name="two_col_row">
            <xsl:with-param name="cell_1">Date(s)</xsl:with-param>
            <xsl:with-param name="cell_2"><xsl:value-of select="."/> &#129; <xsl:value-of select="./@type"/></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="container">
        <xsl:call-template name="two_col_row">
            <xsl:with-param name="cell_1">Container</xsl:with-param>
            <xsl:with-param name="cell_2"><xsl:value-of select="@type"/>:&#129;<xsl:value-of select="."/></xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- ################################ Language Group ######################################### -->
    <xsl:template match="langmaterial">
        <xsl:apply-templates/>
    </xsl:template>
        
    <xsl:template match="language">
        <xsl:call-template name="two_col_row">
            <xsl:with-param name="cell_1">Language</xsl:with-param>
            <xsl:with-param name="cell_2"><xsl:value-of select="."/></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <!-- ################################ /Language Group ######################################### -->
    
    <!-- ################################ Physical Description Group ######################################### -->
    <xsl:template match="physdesc">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="extent">
        <xsl:choose>
            <xsl:when test="@label">
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1"><xsl:value-of select="@label"/></xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:value-of select="."/> &#129; <xsl:value-of select="@unit"/></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1">Extent</xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:value-of select="."/> &#129; <xsl:value-of select="@unit"/></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
         
    </xsl:template>
    <!-- ################################ /Physical Description Group ######################################### -->
    <!-- ################################ Origination Group ######################################### -->
    <xsl:template match="origination">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="origination/persname">
        <xsl:variable name="role" select="@role"/>
        <xsl:choose>
            <xsl:when test="$role">
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1"><xsl:value-of select="$role"/></xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:value-of select="."/></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1">Personal Name</xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:value-of select="."/></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="origination/famname">
        <xsl:variable name="role" select="@role"/>
        <xsl:choose>
            <xsl:when test="$role">
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1"><xsl:value-of select="$role"/></xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:value-of select="."/></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1">Family Name</xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:value-of select="."/></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="origination/corpname">
        <xsl:variable name="role" select="@role"/>
        <xsl:choose>
            <xsl:when test="$role">
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1"><xsl:value-of select="$role"/></xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:value-of select="."/></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1">Corporate Name</xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:value-of select="."/></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- ################################ /Origination Group ######################################### -->
    <!-- ################################ Repository Group ######################################### -->
    <xsl:template match="repository">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="repository/corpname">
        <xsl:variable name="role" select="@role"/>
        <xsl:choose>
            <xsl:when test="$role">
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1"><xsl:value-of select="$role"/></xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:value-of select="."/></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1">Corporate Name</xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:value-of select="."/></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- ################################ /Repository Group ######################################### -->

    <!-- ###### /DID Elements ######### -->
    
    <!-- ###### Arrangement ########## -->
    <xsl:template match="arrangement">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- ###### /Arrangement ########## -->
    
    <!-- ###### Access and Use ######## -->
    <xsl:template match="accessrestrict">
        <xsl:call-template name="two_col_row">
            <xsl:with-param name="cell_1">Access Restrictions</xsl:with-param>
            <xsl:with-param name="cell_2"><xsl:apply-templates/></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="userestrict">
        <xsl:call-template name="two_col_row">
            <xsl:with-param name="cell_1">Use Restrictions</xsl:with-param>
            <xsl:with-param name="cell_2"><xsl:apply-templates/></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <!-- ###### /Access and Use ######## -->
    
    <!-- ###### Processing Information ####### -->
    <xsl:template match="processinfo">
        <xsl:param name="in_dsc"/>
        <xsl:choose>
            <xsl:when test="$in_dsc = ''">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1">Processing Information</xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:apply-templates/></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    <!-- ###### /Processing Information####### -->
    
    <!-- ###### Biography or History ####### -->
    <xsl:template match="bioghist">
        <xsl:param name="in_dsc"/>
        <xsl:choose>
            <xsl:when test="$in_dsc = ''">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <div class="row">
                    <div class="col-md-2"><strong>Biography or History</strong></div>
                    <div class="col-md-9"><xsl:apply-templates/></div>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- ###### /Biography or History ####### -->
    
    <xsl:template match="prefercite">
        <xsl:param name="in_dsc"/>
        <xsl:choose>
            <xsl:when test="$in_dsc = ''">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1">Prefered Citation</xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:apply-templates/></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="acqinfo">
        <xsl:param name="in_dsc"/>
        <xsl:choose>
            <xsl:when test="$in_dsc = ''">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1">Acquisition Info</xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:apply-templates/></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="relatedmaterial">
        <xsl:param name="in_dsc"/>
        <xsl:choose>
            <xsl:when test="$in_dsc = ''">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1">Related Material</xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:apply-templates/></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="scopecontent">
        <xsl:param name="in_dsc"/>
        <xsl:choose>
            <xsl:when test="$in_dsc = ''">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="two_col_row">
                    <xsl:with-param name="cell_1">Scope and Content</xsl:with-param>
                    <xsl:with-param name="cell_2"><xsl:apply-templates/></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- ###### Controlled Access ###### -->
    <xsl:template match="controlaccess">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="controlaccess/corpname">
        <xsl:call-template name="three_col_row_narrow">
            <xsl:with-param name="cell_1">Corporate Name</xsl:with-param>
            <xsl:with-param name="cell_2"><xsl:value-of select="@source"/></xsl:with-param>
            <xsl:with-param name="cell_3"><xsl:value-of select="."></xsl:value-of></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="controlaccess/subject">
        <xsl:call-template name="three_col_row_narrow">
            <xsl:with-param name="cell_1">Subject</xsl:with-param>
            <xsl:with-param name="cell_2"><xsl:value-of select="@source"/></xsl:with-param>
            <xsl:with-param name="cell_3"><xsl:value-of select="."></xsl:value-of></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="controlaccess/famname">
        <xsl:call-template name="three_col_row_narrow">
            <xsl:with-param name="cell_1">Family Name(s)</xsl:with-param>
            <xsl:with-param name="cell_2"><xsl:value-of select="@source"/></xsl:with-param>
            <xsl:with-param name="cell_3"><xsl:value-of select="."></xsl:value-of></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="controlaccess/persname">
        <xsl:call-template name="three_col_row_narrow">
            <xsl:with-param name="cell_1">Personal Name(s)</xsl:with-param>
            <xsl:with-param name="cell_2"><xsl:value-of select="@source"/></xsl:with-param>
            <xsl:with-param name="cell_3"><xsl:value-of select="."></xsl:value-of></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="controlaccess/genreform">
        <xsl:call-template name="three_col_row_narrow">
            <xsl:with-param name="cell_1">Genre/Physical Characteristic</xsl:with-param>
            <xsl:with-param name="cell_2"><xsl:value-of select="@source"/></xsl:with-param>
            <xsl:with-param name="cell_3"><xsl:value-of select="."></xsl:value-of></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="controlaccess/geogname">
        <xsl:call-template name="three_col_row_narrow">
            <xsl:with-param name="cell_1">Geographic Names</xsl:with-param>
            <xsl:with-param name="cell_2"><xsl:value-of select="@source"/></xsl:with-param>
            <xsl:with-param name="cell_3"><xsl:value-of select="."></xsl:value-of></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <!-- ###### /Controlled Access ###### -->
    
    
    <!-- ###### General Items ######### -->
    <xsl:template match="list">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    
    <xsl:template match="item">
            <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="ref">
        <xsl:variable name="target" select="@target"/>
        <xsl:variable name="value"><xsl:value-of select="."/></xsl:variable>
        
        <xsl:choose>
            <xsl:when test="not(starts-with('http', $target))">
                <a href="#{$target}"><xsl:value-of select="$value"/></a>
            </xsl:when>
            <xsl:otherwise>
                <a href="{$target}"><xsl:value-of select="$value"/></a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="head"/>
    
    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="lb">
        <p/>
    </xsl:template>
     
    <xsl:template match="extref">
        <xsl:variable name="href" select="@xlink:href"></xsl:variable>
        <a href="{$href}"><xsl:apply-templates/></a>
    </xsl:template>
    
    <!-- ###### /General Items ######## -->
    
    <!-- Helper Matches -->
    
    <!-- Double quotes -->
    <xsl:template match="emph[@render eq 'doublequote']">
        &#160;<xsl:text>"</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>"</xsl:text>
    </xsl:template>
    
    <xsl:template match="title[@render eq 'doublequote']">
        &#160;<xsl:text>"</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>"</xsl:text>
    </xsl:template>
    
    <!-- END Double quotes -->
    
    <!-- Single quotes -->
    <xsl:template match="emph[@render eq 'singlequote']">
        &#160;<xsl:text>'</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>'</xsl:text>
    </xsl:template>
    
    <xsl:template match="title[@render eq 'singlequote']">
        &#160;<xsl:text>'</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>'</xsl:text>
    </xsl:template>
    
    <!-- END Single quotes -->
    
    <!-- Italics -->
    
    <xsl:template match="emph[@render eq 'italic']">
        &#160;<em><xsl:apply-templates/></em> 
    </xsl:template>
    
    <xsl:template match="title[@render eq 'italic']">
        &#160;<em><xsl:apply-templates/></em>
    </xsl:template>
    
    <!-- END Italics -->
    
    <!-- Bold -->
    <xsl:template match="emph[@render eq 'bold']">
        &#160;<b><xsl:apply-templates/></b>
    </xsl:template>
    
    <xsl:template match="title[@render eq 'bold']">
        &#160;<b><xsl:apply-templates/></b>
    </xsl:template>
    <!-- END Bold -->
    
    <!-- BoldDoubleQuote -->
    <xsl:template match="emph[@render eq 'bolddoublequote']">
        &#160;<b><xsl:text>"</xsl:text><xsl:apply-templates/><xsl:text>"</xsl:text></b>
    </xsl:template>
    
    <xsl:template match="title[@render eq 'bolddoublequote']">
        &#160;<b><xsl:text>"</xsl:text><xsl:apply-templates/><xsl:text>"</xsl:text></b>
    </xsl:template>
    <!-- END BoldDoubleQuote -->
    
    <!-- BoldItalic -->
    <xsl:template match="emph[@render eq 'bolditalic']">
        &#160;<i><b><xsl:apply-templates/></b></i>
    </xsl:template>
    
    <xsl:template match="title[@render eq 'bolditalic']">
        &#160;<i><b><xsl:apply-templates/></b></i>
    </xsl:template>
    <!-- END BoldItalic -->
    
    <!-- BoldSingleQuote -->
    <xsl:template match="emph[@render eq 'boldsinglequote']">
        &#160;<b><xsl:apply-templates/></b>
    </xsl:template>
    
    <xsl:template match="title[@render eq 'boldsinglequote']">
        &#160;<b><xsl:text>'</xsl:text><xsl:apply-templates/><xsl:text>'</xsl:text></b>
    </xsl:template>
    
    <!-- END BoldSingleQuote -->
    
    <xsl:template match="emph[@render eq 'boldunderline']">
        &#160;<b><u><xsl:apply-templates/></u></b>
    </xsl:template>
    
    <xsl:template match="emph[@render eq 'sub']">
        &#160;<sub><xsl:apply-templates/></sub>
    </xsl:template>
    
    <xsl:template match="emph[@render eq 'super']">
        &#160;<sup><xsl:apply-templates/></sup>
    </xsl:template>
    
    <xsl:template match="emph[@render eq 'underline']">
        &#160;<u><xsl:apply-templates/></u>
    </xsl:template>
    
    <!-- #### END ##### -->
</xsl:stylesheet>