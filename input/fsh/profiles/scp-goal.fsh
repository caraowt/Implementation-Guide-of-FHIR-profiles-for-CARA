// extensions

Extension: ScpGoalTargetStatus
Id: scp-goal-target-status
Title: "SCP - Goal - Target Status"
Description: "Flag to identify the statis of a target."
* value[x] only Coding
* valueCoding from ScpObservationLifecycle

// resource

Profile: ScpGoal
Parent: Goal
Id: scp-goal
Title: "SCP - Goal"
Description: "The Goal of a Shared Care Plan."

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

* lifecycleStatus 1..1
* lifecycleStatus from ScpObservationLifecycle (required)

* category.coding 1..1
* category.coding from ScpGoalType (required)

* description 1..1
* description.text 1..1
* description.coding 0..0

* target 0..3
* target ^slicing.discriminator.type = #pattern
* target ^slicing.discriminator.path = "detailCodeableConcept"
* target ^slicing.rules = #open
* target ^slicing.description = "Slice based on the target.detailCodeableConcept"
* target ^slicing.ordered = false
* target contains codeSlice 1..1 and rangeSlice 0..1
* target[codeSlice].detail[x] only CodeableConcept
* target[codeSlice].detail[x] from ScpTargetType (required)
* target[codeSlice].detail[x] 1..1
* target[rangeSlice].detail[x] only Range
* target.extension contains ScpGoalTargetStatus named status 1..1
