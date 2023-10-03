Profile: ScpCarePlan
Parent: CarePlan
Id: scp-careplan
Title: "SCP - Care Plan"
Description: "The Care Plan of a Shared Care Plan."

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

* identifier 2..*
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice based on the identifier.system"
* identifier ^slicing.ordered = false
* identifier contains accountSlice 1..1 and scpSlice 1..1
* identifier[accountSlice].system = "urn:cara:account"
* identifier[scpSlice].system = "urn:cara:scp"

* status 1..1
* status from ScpCarePlanStatus (required)

* created 1..1

* intent 1..1
* intent = #directive

* subject 1..1
* subject only Reference(CaraPatientProfile)

* careTeam 1..1
* careTeam only Reference(ScpCareTeam)