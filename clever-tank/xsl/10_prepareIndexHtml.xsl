<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" version="2.0">

	<xsl:output indent="no" method="xml"/>
	<xsl:strip-space elements="*"/>


	<!-- ***************************************************************************************************************************************** -->
	<!--  Golbal Vars -->
	<!-- ***************************************************************************************************************************************** -->
	<xsl:variable name="path2html" select="'../out/xhtml/'"/>
	<xsl:variable name="pageWidth" select="174"/>

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


	<!-- ***************************************************************************************************************************************** -->
	<!--  Html Templates -->
	<!-- ***************************************************************************************************************************************** -->

	<xsl:template match="/html:html">
		<Root data-type="Publication">
			<section data-type="Page" data-masterpage="C-Cover">
				<section data-type="Frame">
					<p class="p_Titel">
						<xsl:apply-templates select="html:body/html:h1/node()"/>
					</p>
				</section>
			</section>
			<section data-type="Page" data-masterpage="B-TOC">
				<section data-type="Frame"> </section>
			</section>
			<section data-type="Page" data-masterpage="A-Basic">
				<section data-type="Frame">
					<xsl:apply-templates select="html:body/html:div/*"/>
				</section>
			</section>
		</Root>
	</xsl:template>

	<xsl:template match="html:head">
		<!-- delete -->
	</xsl:template>

	<xsl:template match="html:meta">
		<!-- delete -->
	</xsl:template>

	<xsl:template match="html:body | html:a">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="@html:lang">
		<!-- delete -->
	</xsl:template>


	<!-- ***************************************************************************************************************************************** -->
	<!--  Section Templates -->
	<!-- ***************************************************************************************************************************************** -->


	<xsl:template match="html:ul[@class = 'map'][parent::html:div/parent::html:body]" priority="1">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- Main -->
	<xsl:template match="html:li[@class = 'topicref']">
		<section data-type="Chapter">
			<xsl:variable name="topicRef" select="document(concat($path2html, html:a/@href))"/>
			<xsl:apply-templates select="$topicRef/html:html/html:body"/>
			<xsl:apply-templates select="html:ul/html:li"/>
		</section>
	</xsl:template>



	<!-- Submap in Content -->
	<xsl:template match="html:div[@class = 'related-links']" priority="1000">
		<!-- delete  -->
	</xsl:template>


	<xsl:template match="html:div" priority="1">
		<xsl:apply-templates/>
	</xsl:template>



	<!-- ***************************************************************************************************************************************** -->
	<!--  Image Templates -->
	<!-- ***************************************************************************************************************************************** -->

	<xsl:template match="html:img">
		<p class="p_Anker_Image">
			<xsl:element name="{local-name()}">
				<xsl:variable name="oldSrc" select="@src"/>
				<xsl:variable name="imageName" select="tokenize($oldSrc, '/')[last()]"/>
				<xsl:attribute name="src">
					<xsl:value-of select="concat($path2html, 'graphics/', $imageName)"/>
				</xsl:attribute>
				<xsl:attribute name="data-srcPrint">
					<xsl:value-of select="concat($path2html, 'graphics/', $imageName)"/>
				</xsl:attribute>
				<xsl:attribute name="class" select="'Grafik'"/>
			</xsl:element>
		</p>
	</xsl:template>

	<!-- ***************************************************************************************************************************************** -->
	<!--  Absätze -->
	<!-- ***************************************************************************************************************************************** -->
	<xsl:template match="html:h1[@class = 'title topictitle1']" priority="1000">
		<p class="p_H1">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="@class[. = 'p']">
		<xsl:attribute name="class" select="'p_p'"/>
	</xsl:template>

	<xsl:template match="html:h2">
		<p class="p_bold">
			<xsl:apply-templates/>
		</p>
	</xsl:template>


	<!-- ***************************************************************************************************************************************** -->
	<!--  Listen unordered -->
	<!-- ***************************************************************************************************************************************** -->

	<xsl:template match="html:ul">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="html:li[html:p]">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="html:li[parent::html:ul][not(html:p)]" priority="-0.3">
		<p class="p_L1">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="html:p[not(preceding-sibling::*)][parent::html:li/parent::html:ul]">
		<p class="p_L1">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="html:p[preceding-sibling::*][parent::html:li/parent::html:ul]">
		<p class="p_L1_Fortsetzung">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<!-- ***************************************************************************************************************************************** -->
	<!--  Listen ordered -->
	<!-- ***************************************************************************************************************************************** -->

	<xsl:template match="html:ol">
		<xsl:apply-templates/>
	</xsl:template>


	<xsl:template match="html:li[parent::html:ol][not(html:p)]" priority="-0.3">
		<p class="p_L1o">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="html:p[not(preceding-sibling::*)][parent::html:li/parent::html:ol]">
		<p class="p_L1o">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="html:p[preceding-sibling::*][parent::html:li/parent::html:ol]">
		<p class="p_L1o_Fortsetzung">
			<xsl:apply-templates/>
		</p>
	</xsl:template>


	<!-- ***************************************************************************************************************************************** -->
	<!--  Zeichenformate -->
	<!-- ***************************************************************************************************************************************** -->
	<xsl:template match="html:strong | html:span[@html:class = 'keyword']" priority="1000">
		<span class="bold">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- ***************************************************************************************************************************************** -->
	<!--  Tabellen -->
	<!-- ***************************************************************************************************************************************** -->

	<xsl:template match="html:table[html:col]">
		<p class="p_Anker_Tabelle">
			<table>
				<colgroup>
					<xsl:variable name="colWidth" select="$pageWidth div count(html:col)"/>
					<xsl:for-each select="html:col">
						<col width="{$colWidth}"/>
					</xsl:for-each>
				</colgroup>
				<xsl:apply-templates select="html:thead/* | html:tbody/* | html:tfooter/* | html:tr"
				/>
			</table>
		</p>
	</xsl:template>


</xsl:stylesheet>
