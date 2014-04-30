<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:syriaca="http://syriaca.org"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    exclude-result-prefixes="xs t syriaca"
    version="2.0">
    
    <xsl:template match="t:title">
        <dcterms:title><xsl:apply-templates mode="textout"/></dcterms:title>
    </xsl:template>
    
    <xsl:template match="t:*" mode="textout">
        <xsl:for-each select="node()">
            <xsl:apply-templates select="." mode="textout"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="text()" mode="textout">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    
</xsl:stylesheet>