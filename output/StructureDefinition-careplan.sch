<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <!-- 
    This file contains just the constraints for the profile CarePlan
    It includes the base constraints for the resource as well.
    Because of the way that schematrons and containment work, 
    you may need to use this schematron fragment to build a, 
    single schematron that validates contained resources (if you have any) 
  -->
  <sch:pattern>
    <sch:title>f:CarePlan</sch:title>
    <sch:rule context="f:CarePlan">
      <sch:assert test="count(f:extension[@url = 'http://example.org/fhir/fish/StructureDefinition/social-data']) &lt;= 1">extension with URL = 'http://example.org/fhir/fish/StructureDefinition/social-data': maximum cardinality of 'extension' is 1</sch:assert>
      <sch:assert test="count(f:extension[@url = 'http://example.org/fhir/fish/StructureDefinition/historical-data']) &lt;= 1">extension with URL = 'http://example.org/fhir/fish/StructureDefinition/historical-data': maximum cardinality of 'extension' is 1</sch:assert>
      <sch:assert test="count(f:extension[@url = 'http://example.org/fhir/fish/StructureDefinition/patient-priorities']) &lt;= 1">extension with URL = 'http://example.org/fhir/fish/StructureDefinition/patient-priorities': maximum cardinality of 'extension' is 1</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>f:CarePlan/f:activity</sch:title>
    <sch:rule context="f:CarePlan/f:activity">
      <sch:assert test="count(f:extension[@url = 'http://example.org/fhir/fish/StructureDefinition/attention-point']) &lt;= 1">extension with URL = 'http://example.org/fhir/fish/StructureDefinition/attention-point': maximum cardinality of 'extension' is 1</sch:assert>
      <sch:assert test="count(f:extension[@url = 'http://example.org/fhir/fish/StructureDefinition/outcome-reference']) &lt;= 1">extension with URL = 'http://example.org/fhir/fish/StructureDefinition/outcome-reference': maximum cardinality of 'extension' is 1</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
