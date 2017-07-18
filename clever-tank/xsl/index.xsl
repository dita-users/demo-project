<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs xd xhtml"
    version="2.0">
    
    
    <xsl:template match="node()">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="/html">
        
        <div data-type="Publication">
            <xsl:apply-templates/>
        </div>
        
    </xsl:template>
    
    <xsl:template match="head|body">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="li[@class='topicref']">
        <div data-type="Page">
        <xsl:variable name="ref" select="doc(concat('../out/xhtml/', /a/@href))"/>
        <xsl:apply-templates select="$ref/html/body"/>
            
        </div>
    </xsl:template>
    
    
    
</xsl:stylesheet>