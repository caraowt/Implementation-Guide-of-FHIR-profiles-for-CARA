// extentions

Extension: ScpObservationInterestedPartyUrn
Id: scp-observation-interested-party
Title: "SCP - Observation - Interested Party Urn"
Description: "identifier of a party with an interest in the observation."
* value[x] only string

Profile: ScpObservation
Parent: Observation
Id: scp-observation
Title: "SCP - Observation"
Description: "The Observation of a Shared Care Plan."

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
* code from ScpGoalType (required)

* value[x] only string
* valueString 1..1

* effective[x] only instant
* effectiveInstant 1..1

* interpretation 0..1
* interpretation ^slicing.discriminator.type = #pattern
* interpretation ^slicing.discriminator.path = "coding"
* interpretation ^slicing.rules = #open
* interpretation ^slicing.description = "Slice based on the interpretation.coding"
* interpretation ^slicing.ordered = false
* interpretation contains attentionPointSlice 0..1 and metricHighSlice 0..1
* interpretation[attentionPointSlice].coding = ObservationInterpretation#AA
* interpretation[metricHighSlice].coding = ObservationInterpretation#HH

* performer 1..1
* performer only Reference(CaraPatientProfile or ScpTeamMemberPractitioner or ScpTeamMemberRelatedPerson)

* component 0..3
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.description = "Slice based on the component.code"
* component ^slicing.ordered = false
* component contains atomicSlice 0..2 and compositeSlice 0..1
* component[atomicSlice].code from ScpTargetType
* component[atomicSlice].value[x] only Quantity
* component[atomicSlice].valueQuantity 1..1
* component[compositeSlice].code from ScpTargetType
* component[compositeSlice].value[x] 0..0

* extension contains ScpObservationInterestedPartyUrn named interestedPartyUrn 0..1