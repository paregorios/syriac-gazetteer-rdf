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
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
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
            <xsl:apply-templates select="/t:TEI/t:text/t:body/t:listPlace/t:place[1]/t:desc[starts-with(@xml:id, 'abstract-')][1]"/>

            <!-- place type -->
            <xsl:apply-templates select="/t:TEI/t:text/t:body/t:listPlace/t:place" mode="pelagios-subject"/>

            <!-- equivalent records in other gazetteers -->
            <xsl:apply-templates select="/t:TEI/t:text/t:body/t:listPlace/t:place/t:idno[@type='URI' and starts-with(., 'http://pleiades.stoa.org/places/')]" mode="pelagios-equivalents"/>
            
            <!-- place names -->
            <xsl:apply-templates select="/t:TEI/t:text/t:body/t:listPlace/t:place/t:placeName" mode="pelagios"/>
            
            <!-- locations -->
            <xsl:apply-templates select="/t:TEI/t:text/t:body/t:listPlace/t:place/t:location[@type='gps']" mode="pelagios"/>
                
            
        </pelagios:PlaceRecord>
    </xsl:template>
    
    <xsl:template match="t:desc">
        <dcterms:description><xsl:apply-templates mode="textout"/></dcterms:description>
    </xsl:template>
    
    <xsl:template match="t:place" mode="pelagios-subject">
        <dcterms:subject><xsl:apply-templates mode="textout" select="@type"/></dcterms:subject>
    </xsl:template>
    
    <xsl:template match="t:idno" mode="pelagios-equivalents">
        <skos:closeMatch>
            <xsl:attribute name="rdf:resource">
                <xsl:apply-templates select="." mode="textout"/>
            </xsl:attribute>
        </skos:closeMatch>
    </xsl:template> 
    
    <xsl:template match="t:placeName" mode="pelagios">
        <pleiades:hasName>
            <rdf:Description>
                <xsl:copy-of select="@xml:lang"/>
                <xsl:attribute name="rdfs:label">
                    <xsl:apply-templates mode="textout"/>
                </xsl:attribute>
            </rdf:Description>
        </pleiades:hasName>
    </xsl:template>
    
    <xsl:template match="t:location" mode="pelagios">
        <pleiades:hasLocation>
            <rdf:Description>
                <geo:lat rdf:datatype="xsd:double"><xsl:value-of select="normalize-space(substring-before(t:geo, ' '))"/></geo:lat>
                <geo:long rdf:datatype="xsd:double"><xsl:value-of select="normalize-space(substring-after(t:geo, ' '))"/></geo:long>
            </rdf:Description>
            
        </pleiades:hasLocation>
    </xsl:template>
    
    
    
</xsl:stylesheet>