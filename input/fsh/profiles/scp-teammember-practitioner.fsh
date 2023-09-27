Profile: ScpTeamMemberPractitioner
Parent: Practitioner
Id: scp-teammember-practitioner
Title: "SCP - Team Member - Practitioner"
Description: "The Team Member of a Shared Care Plan with the profile Healthcare Professional."

* meta.tag 1..*
* meta.tag ^slicing.discriminator.type = #pattern
* meta.tag ^slicing.discriminator.path = "system"
* meta.tag ^slicing.rules = #open
* meta.tag ^slicing.description = "Slice based on the meta.tag.system"
* meta.tag ^slicing.ordered = false
* meta.tag contains nsSlice 1..1
* meta.tag[nsSlice] from CaraPlatformNamespace
* meta.tag[nsSlice].code 1..1
* meta.tag[nsSlice].code = #cara:scp

* identifier 3..*
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice based on the identifier.system"
* identifier ^slicing.ordered = false
* identifier contains accountSlice 1..1 and scpSlice 1..1 and glnSlice 1..1
* identifier[accountSlice].system = "urn:cara:account"
* identifier[scpSlice].system = "urn:cara:scp"
* identifier[glnSlice].system = "urn:cara:gln"

* active 1..1

* telecom 0..4
* telecom ^slicing.discriminator.type = #pattern
* telecom ^slicing.discriminator.path = "system"
* telecom ^slicing.rules = #open
* telecom ^slicing.description = "Slice based on the telecom.system"
* telecom ^slicing.ordered = false
* telecom contains emailSlice 1..1 and phoneSlice 0..2 and faxSlice 0..1
* telecom[emailSlice].system = #email
* telecom[emailSlice].value 1..1
* telecom[phoneSlice].system = #phone
* telecom[phoneSlice].value 1..1
* telecom[faxSlice].system = #fax
* telecom[faxSlice].value 1..1

* name 0..1
* name.given 1..1
* name.family 1..1

* address 0..1
* address.line 1..2
* address.postalCode 1..1
* address.city 0..1
* address.country 0..1
