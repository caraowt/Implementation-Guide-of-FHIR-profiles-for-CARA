// extentions

Extension: ScpCareteamParticipantIsManager
Id: scp-careteam-participant-ismanager
Title: "SCP - Care Team - Manager"
Description: "Flag to identify managers of a Shared Care Plan."
* value[x] only boolean

Extension: ScpCareteamParticipantIsCoordinator
Id: scp-careteam-participant-iscoordinator
Title: "SCP - Care Team - Coordinator"
Description: "Flag to identify coordinators of a Shared Care Plan."
* value[x] only boolean

Extension: ScpCareteamParticipantComment
Id: scp-careteam-participant-comment
Title: "SCP - Care Team - Comment"
Description: "Human readable comment of a participant."
* value[x] only string

// resource

Profile: ScpCareTeam
Parent: CareTeam
Id: scp-careteam
Title: "SCP - Care Team"
Description: "The Care Team of a Shared Care Plan."

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

* participant ^slicing.discriminator.type = #value
* participant ^slicing.discriminator.path = "member"
* participant ^slicing.rules = #open
* participant ^slicing.description = "Slice based on the participant.member"
* participant ^slicing.ordered = false
* participant contains healthcareProfessionalSlice 0..* and caregiverSlice 0..*
* participant[healthcareProfessionalSlice].member only Reference(ScpTeamMemberPractitioner)
* participant[caregiverSlice].member only Reference(ScpTeamMemberRelatedPerson)
* participant.role from ScpParticipantRole (required)

* participant.extension contains ScpCareteamParticipantIsManager named ismanager 1..1
* participant.extension contains ScpCareteamParticipantIsCoordinator named iscoordinator 1..1
* participant.extension contains ScpCareteamParticipantComment named comment 1..1

* subject 1..1
* subject only Reference(CaraPatientProfile)

* status 1..1
