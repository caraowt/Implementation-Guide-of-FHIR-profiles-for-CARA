Profile: ScpExternalObservation
Parent: ScpObservation
Id: scp-external-observation
Title: "SCP - External Observaton"
Description: "The Observaton of a Shared Care Plan coming from third parties."

* meta.tag ^slicing.discriminator.type = #value
* meta.tag ^slicing.discriminator.path = "system"
* meta.tag ^slicing.rules = #open
* meta.tag ^slicing.description = "Slice based on the meta.tag.system"
* meta.tag ^slicing.ordered = false
* meta.tag contains externalSystemSlice 1..1
* meta.tag[externalSystemSlice].system 1..1
* meta.tag[externalSystemSlice].system = "urn:cara:external_system"
* meta.tag[externalSystemSlice].code 1..1

* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice based on the identifier.system"
* identifier ^slicing.ordered = false
* identifier contains externalIdSlice 1..1
* identifier[externalIdSlice].system = "urn:cara:external_id"
* identifier[externalIdSlice].value 1..1
