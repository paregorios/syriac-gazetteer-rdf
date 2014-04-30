<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:syriaca="http://syriaca.org"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#"
    xmlns:gn="http://www.geonames.org/ontology#" 
    xmlns:osgeo="http://data.ordnancesurvey.co.uk/ontology/geometry/"
    xmlns:pelagios="http://pelagios.github.io/vocab/terms#"
    xmlns:pleiades="http://pleiades.stoa.org/places/vocab#"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:spatial="http://geovocab.org/spatial#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    exclude-result-prefixes="xs t syriaca"
    version="2.0">
    
    <xsl:template name="pelagios-rdfxml">
        <xsl:variable name="placedoc">
            <xsl:value-of select="/t:TEI/t:text[1]/t:body[1]/t:listPlace[1]/t:place[1]/t:idno[@type='URI' and starts-with(., 'http://syriaca.org/place/')][1]"/>.html<xsl:text></xsl:text>
        </xsl:variable>
        <pelagios:PlaceRecord rdf:about="{$placedoc}">
            <!-- title -->
            <xsl:apply-templates select="/t:TEI/t:teiHeader/t:fileDesc/t:titleStmt/t:title[@level='a'][1]"/>
            <!-- description -->
            <xsl:apply-templates select="/t:TEI/t:text[1]/t:body[1]/t:listPlace[1]/t:place[1]/t:desc[starts-with(@xml:id, 'abstract-')][1]"/>
            <!-- place type -->
            <xsl:apply-templates select="/t:TEI/t:text[1]/t:body[1]/t:listPlace[1]/t:place[1]" mode="pelagios-subject"/>
        </pelagios:PlaceRecord>
    </xsl:template>
    
    <xsl:template match="t:desc">
        <dcterms:description><xsl:apply-templates mode="textout"/></dcterms:description>
    </xsl:template>
    
    <xsl:template match="t:place" mode="pelagios-subject">
        <dcterms:subject><xsl:apply-templates mode="textout" select="@type"/></dcterms:subject>
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>