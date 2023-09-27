// extentions

Extension: ScpContactRelationship
Id: scp-contact-relationship
Title: "SCP - Contact - Relationship"
Description: "The kind of relationship to the patient."
* value[x] only string

Extension: ScpContactComment
Id: scp-contact-comment
Title: "SCP - Contact - Comment"
Description: "Additional information about the contact person."
* value[x] only string

Extension: ScpContactEmergency
Id: scp-contact-emergency
Title: "SCP - Contact - Emergency"
Description: "Flag to identify emergency contacts of a Shared Care Plan."
* value[x] only boolean

// resource

Profile: ScpContact
Parent: Person
Id: scp-contact
Title: "SCP - Contact"
Description: "A contact person of a Shared Care Plan."

* meta.tag 1..*
* meta.tag ^slicing.discriminator.type = #pattern
* meta.tag ^slicing.discriminator.path = "system"
* meta.tag ^slicing.rules = #open
* meta.tag ^slicing.description = "Slice based on the meta.tag.system"
* meta.tag ^slicing.ordered = false
* meta.tag contains nsSlice 1..1
* meta.tag[nsSlice] from CaraPlatformNamespace
* meta.tag[nsSlice].code = #cara:scp

* identifier 1..*
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice based on the identifier.system"
* identifier ^slicing.ordered = false
* identifier contains accountSlice 1..1 and scpSlice 1..1
* identifier[accountSlice].system = "urn:cara:account"
* identifier[scpSlice].system = "urn:cara:scp"

* active 1..1

* telecom 1..1
* telecom ^slicing.discriminator.type = #pattern
* telecom ^slicing.discriminator.path = "system"
* telecom ^slicing.rules = #open
* telecom ^slicing.description = "Slice based on the telecom.system"
* telecom ^slicing.ordered = true
* telecom contains phoneSlice 1..1 and emailSlice 0..1
* telecom[emailSlice].system = #email
* telecom[emailSlice].value 1..1
* telecom[phoneSlice].system = #phone
* telecom[phoneSlice].value 1..1

* name 1..1
* name.given 1..1
* name.family 1..1

* extension contains ScpContactRelationship named relationship 0..1
* extension contains ScpContactComment named comment 0..1
* extension contains ScpContactEmergency named emergency 1..1
