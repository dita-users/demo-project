<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" version="2.0">

	<xsl:output indent="no" method="xml"/>
	<xsl:strip-space elements="*"/>


	<!-- ***************************************************************************************************************************************** -->
	<!--  default Templates -->
	<!-- ***************************************************************************************************************************************** -->

	<xsl:template match="*">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*">
		<xsl:attribute name="{local-name()}">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>


	<xsl:template match="p[@class = 'p_H1']">
		<xsl:copy>
			<xsl:variable name="countChap" select="count(ancestor::section[@data-type = 'Chapter'])"/>
			<xsl:attribute name="class" select="concat('p_H', $countChap)"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="p[@class = 'p_L1o']">
		<xsl:copy>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="not(preceding-sibling::p[@class = 'p_L1o'])">
						<xsl:value-of select="'p_L1o_1st'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@class"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>


</xsl:stylesheet>
