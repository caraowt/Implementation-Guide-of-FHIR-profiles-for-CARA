// extensions

Extension: ScpNoteInterestedPartyUrn
Id: scp-note-interested-party
Title: "SCP - Note - Interested Party Urn"
Description: "identifier of a party with an interest in the note."
* value[x] only string

// resource

Profile: ScpNote
Parent: Observation
Id: scp-note
Title: "SCP - Note"
Description: "The Note of a Shared Care Plan."

* meta.tag 1..*
* meta.tag ^slicing.discriminator.type = #value
* meta.tag ^slicing.discriminator.path = "system"
* meta.tag ^slicing.rules = #open
* meta.tag ^slicing.description = "Slice based on the meta.tag.system"
* meta.tag ^slicing.ordered = false
* meta.tag contains nsSlice 1..1
* meta.tag[nsSlice] from CaraPlatformNamespace (required)
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

* code 1..1
* code from ScpNoteType (required)

* value[x] only string
* valueString 1..1

* effective[x] only instant
* effectiveInstant 1..1

* performer 1..1
* performer only Reference(CaraPatientProfile or ScpTeamMemberPractitioner or ScpTeamMemberRelatedPerson)

* extension contains ScpNoteInterestedPartyUrn named interestedPartyUrn 0..1
