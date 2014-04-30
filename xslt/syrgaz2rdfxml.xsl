<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:syriaca="http://syriaca.org"
    xmlns="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    exclude-result-prefixes="xs t syriaca"
    version="2.0">
    
    <!-- this transform is meant to address the following specifications:
        MESA: http://wiki.collex.org/index.php/Submitting_RDF
        Pelagios: https://github.com/pelagios/pelagios-cookbook/wiki/Pelagios-Gazetteer-Interconnection-Format -->
    
    <xsl:import href="common-rdfxml.xsl" />
    <xsl:import href="pelagios-rdfxml.xsl" />
    <xsl:import href="mesa-rdfxml.xsl" />

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <RDF xmlns="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
            <xsl:call-template name="pelagios-rdfxml"/>
            <xsl:call-template name="mesa-rdfxml"/>
        </RDF>
    </xsl:template>
    
</xsl:stylesheet>