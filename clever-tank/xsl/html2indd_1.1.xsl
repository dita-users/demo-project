<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
	xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/" xmlns:axx="http://www.axxepta.de/xsl/func"
	exclude-result-prefixes="xs xd" version="2.0">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> Oct 13, 2011</xd:p>
			<xd:p><xd:b>Author:</xd:b> KaBe</xd:p>
			<xd:p/>
		</xd:desc>
	</xd:doc>

	<xsl:output indent="no" method="xml"/>
	<xsl:strip-space elements="*"/>
	<xsl:decimal-format decimal-separator="," grouping-separator="."/>
    
<!-- ***************************************************************************************************************************************** -->
<!--  Global Vars -->
<!-- ***************************************************************************************************************************************** -->    
    
	<xsl:variable name="mmToPt" select="2.835270768358378"/>
	<xsl:variable name="convertTableWidthToPt" select="'yes'"/> <!-- yes|no -->


<!-- ***************************************************************************************************************************************** -->
<!--  default Templates -->
<!-- ***************************************************************************************************************************************** -->
	
	<xsl:template match="node()">
		<xsl:copy>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="@*">
		<xsl:copy-of select="."/>
	</xsl:template>
	
	
<!-- ***************************************************************************************************************************************** -->
<!--  Html Templates -->
<!-- ***************************************************************************************************************************************** -->

   <xsl:template match="/html|div[@data-type ='Publication']">
		<Root xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
			xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/">
			<xsl:apply-templates/>
		</Root>
	</xsl:template>

	<xsl:template match="head">
		<!-- delete -->
	</xsl:template>
    
    <xsl:template match="meta">
        <!-- delete -->
    </xsl:template>
	
	<xsl:template match="body|a">
		<xsl:apply-templates/>
	</xsl:template>
	
	
<!-- ***************************************************************************************************************************************** -->
<!--  Section Templates -->
<!-- ***************************************************************************************************************************************** -->
	
	<xsl:template match="section[@data-type = 'Page']">
		<Page>
			<xsl:apply-templates select="@*[name() != 'data-type' and name() != 'class' and name() != 'data-masterpage']"/>
		    <xsl:attribute name="data-masterpage">
		        <xsl:value-of select="@data-masterpage"/>
		    </xsl:attribute>
			<xsl:apply-templates/>
		</Page>
	</xsl:template>
	
	
	<xsl:template match="section[@data-type = 'Frame']">
		<Frame>
			<xsl:apply-templates select="@*[name() != 'data-type' and name() != 'class']"/>
			<xsl:if test="normalize-space(@class) != ''">
				<xsl:attribute name="data-objectstyle">
					<xsl:value-of select="@class"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</Frame>
	</xsl:template>
	
	
	<xsl:template match="section[@data-type = 'Oval']">
		<Oval>
			<xsl:apply-templates select="@*[name() != 'data-type' and name() != 'class']"/>
			<xsl:if test="normalize-space(@class) != ''">
				<xsl:attribute name="data-objectstyle">
					<xsl:value-of select="@class"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</Oval>
	</xsl:template>	
	
	
	<xsl:template match="section[@data-type[.= 'Chapter' or .= 'SubChapter' or .= 'Products']]">
		<xsl:apply-templates/>
	</xsl:template>
	
	
	<xsl:template match="div">
		<InlineFrame>
		   <xsl:apply-templates select="@*[name()[. != 'class' and . != 'data-type' and . != 'width' and . != 'height']]" />
		   <xsl:if test="not(@data-objectstyle) and normalize-space(@class) != ''">
				<xsl:attribute name="data-objectstyle">
					<xsl:value-of select="@class"/>
				</xsl:attribute>
			</xsl:if>
		   <xsl:if test="not(@data-width) and normalize-space(@width) !=''">
		      <xsl:attribute name="data-width">
		         <xsl:value-of select="@width"/>
		      </xsl:attribute>
		   </xsl:if>
		   <xsl:if test="not(@data-height) and normalize-space(@height) !=''">
		      <xsl:attribute name="data-width">
		         <xsl:value-of select="@height"/>
		      </xsl:attribute>
		   </xsl:if>
			<xsl:apply-templates/>
		</InlineFrame>
	</xsl:template>
	
	
<!-- ***************************************************************************************************************************************** -->
<!--  Table Templates -->
<!-- ***************************************************************************************************************************************** -->
	
	<xsl:template match="table">
		<Table aid:table="table">
			<xsl:apply-templates select="@*[name() != 'class' and name() != 'aid:tcols' and name() != 'aid:trows']"/>
			<xsl:if test="normalize-space(@class) != ''">
				<xsl:attribute name="aid5:tablestyle">
					<xsl:value-of select="@class"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="colgroup">
					<xsl:attribute name="aid:tcols">
						<xsl:value-of select="count(colgroup/col)"/>
					</xsl:attribute>
					<xsl:attribute name="aid:trows">
						<xsl:value-of select="count(tr)"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="@aid:tcols|@aid:trows"/>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:apply-templates/>
		</Table>
	</xsl:template>
	
	
	<xsl:template match="colgroup|col">
		<!-- delete -->
	</xsl:template>


	<xsl:template match="tr">
		<xsl:comment>
			<xsl:text>tablerow #</xsl:text>
			<xsl:value-of select="count(preceding-sibling::tr) + 1"/>
		</xsl:comment>
		<xsl:apply-templates/>
	</xsl:template>


	<xsl:template match="th">
		<Cell aid:table="cell" aid:theader="">
			<xsl:apply-templates
				select="@*[name() != 'class' and name() != 'rowspan' and name() != 'colspan']"/>
			<xsl:if test="normalize-space(@class) != ''">
				<xsl:attribute name="aid5:cellstyle">
					<xsl:value-of select="@class"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="cellAttributes"/>
			<xsl:apply-templates/>
		</Cell>
	</xsl:template>


	<xsl:template match="td">
		<Cell aid:table="cell">
			<xsl:apply-templates
				select="@*[name() != 'class' and name() != 'rowspan' and name() != 'colspan']"/>
			<xsl:if test="normalize-space(@class) != ''">
				<xsl:attribute name="aid5:cellstyle">
					<xsl:value-of select="@class"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="cellAttributes"/>
			<xsl:apply-templates/>
		</Cell>
	</xsl:template>


	<xsl:template name="cellAttributes">
		<xsl:attribute name="aid:ccols">
			<xsl:choose>
				<xsl:when test="@colspan &gt; 1">
					<xsl:value-of select="@colspan"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="aid:crows">
			<xsl:choose>
				<xsl:when test="@rowspan &gt; 1">
					<xsl:value-of select="@rowspan"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:variable name="currentCol" select="count(preceding-sibling::*) + 1"/>
		<xsl:if test="parent::tr/parent::table/colgroup/col[$currentCol]/@width">
			<xsl:attribute name="aid:ccolwidth">
				<xsl:choose>
					<xsl:when test="$convertTableWidthToPt != 'yes'">
						<xsl:value-of select="parent::tr/parent::table/colgroup/col[$currentCol]/@width"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="parent::tr/parent::table/colgroup/col[$currentCol]/@width * $mmToPt"/>						
					</xsl:otherwise>
				</xsl:choose>				
			</xsl:attribute>
		</xsl:if>
	</xsl:template>
	
	
<!-- ***************************************************************************************************************************************** -->
<!--  Paragraphs/Zeichen/Links Templates -->
<!-- ***************************************************************************************************************************************** -->
	
	<xsl:template match="p">
		<Para>
			<xsl:apply-templates select="@*[name() != 'class']"/>
			<xsl:if test="normalize-space(@class) != ''">
				<xsl:attribute name="aid:pstyle">
					<xsl:value-of select="@class"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@class = 'line-50%'">
				<!-- space einfügen da in ID keine Linie unter leeren Absatz -->
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:apply-templates/>
		</Para>
	</xsl:template>
    
    
    <xsl:template match="h1|h2|h3|h4|h5|h6">
        <Para>
            <xsl:apply-templates select="@*[name() != 'class']"/>
                <xsl:attribute name="aid:pstyle">
                    <xsl:value-of select="name()"/>
                </xsl:attribute>
            
            <xsl:if test="@class = 'line-50%'">
                <!-- space einfügen da in ID keine Linie unter leeren Absatz -->
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </Para>
    </xsl:template>
    
    <xsl:template match="ul|ol">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="li">
        <Para>
            <xsl:apply-templates select="@*[name() != 'class']"/>
            <xsl:attribute name="aid:pstyle">
                <xsl:value-of select="name()"/>
            </xsl:attribute>
            
            <xsl:if test="@class = 'line-50%'">
                <!-- space einfügen da in ID keine Linie unter leeren Absatz -->
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </Para>
    </xsl:template>


	<xsl:template match="p[@class = 'Warning']">
		<!-- delete -->
	</xsl:template>


	<xsl:template match="span">
		<Char>
			<xsl:apply-templates select="@*[name()[. != 'class' and . != 'data-type']]"/>
			<xsl:if test="normalize-space(@class) != ''">
				<xsl:attribute name="aid:cstyle">
					<xsl:value-of select="@class"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</Char>
	</xsl:template>
   
   <xsl:template match="sup">
      <Char>
         <xsl:attribute name="aid:cstyle">
            <xsl:value-of select="'sup'"/>
         </xsl:attribute>         
         <xsl:apply-templates/>
      </Char>
   </xsl:template>
	
	
	<xsl:template match="a">
		<xsl:apply-templates/>
	</xsl:template>


	<xsl:template match="img">
		<Image>
			<xsl:apply-templates
			   select="@*[name()[. != 'class' and . != 'class2' and . != 'alt' and . != 'src' and . != 'data-srcPrint' and . != 'width' and . != 'height']]"/>
			<xsl:if test="normalize-space(@class) != ''">
				<xsl:attribute name="data-objectstyle">
					<xsl:value-of select="@class"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@src">
				<xsl:attribute name="href">
					<xsl:value-of select="concat('file:///', @data-srcPrint)"/>
				</xsl:attribute>
			</xsl:if>
		   <xsl:if test="not(@data-width) and normalize-space(@width) !=''">
		      <xsl:attribute name="data-width">
		         <xsl:value-of select="@width"/>
		      </xsl:attribute>
		   </xsl:if>
		   <xsl:if test="not(@data-height) and normalize-space(@height) !=''">
		      <xsl:attribute name="data-width">
		         <xsl:value-of select="@height"/>
		      </xsl:attribute>
		   </xsl:if>
			<xsl:apply-templates/>
		</Image>
	</xsl:template>
	
	<xsl:template match="br">
		<Br/>
	</xsl:template>


    <xsl:template match="hr[@data-type = 'PageBreak']">
		<PageBreak/>
	</xsl:template>


    <xsl:template match="hr[@data-type = 'ColumnBreak']">
		<ColumnBreak/>
	</xsl:template>
    
    <xsl:template match="hr[@data-type = 'Line']">
        <Line>
            <xsl:apply-templates select="@*[name() != 'data-type' and name() != 'class']"/>
            <xsl:if test="normalize-space(@class) != ''">
                <xsl:attribute name="objectstyle">
                    <xsl:value-of select="@class"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </Line>
    </xsl:template>	
	
	<xsl:template match="span[@class = 'Tab']">
		<Tab/>
	</xsl:template>


    <xsl:template match="mtext|math">
        
    </xsl:template>
   
   <xsl:template match="*[@data-skip]">
      <!-- skip -->
      <xsl:apply-templates/>
   </xsl:template>

<!--    <xsl:template match="@data-fit|@data-anchorXoffset|@data-anchorYoffset|@data-y1|@data-x1|@data-y2|@data-x2|@data-resize">
        <xsl:attribute name="{substring-after(name(),'data-')}">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>-->
    
    



</xsl:stylesheet>
