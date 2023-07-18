Alias: $Goal = http://hl7.org/fhir/StructureDefinition/Goal
Alias: $Patient = http://hl7.org/fhir/StructureDefinition/Patient
Alias: $Practitioner = http://hl7.org/fhir/StructureDefinition/Practitioner
Alias: $RelatedPerson = http://hl7.org/fhir/StructureDefinition/RelatedPerson

Profile:        Goal
Parent:         $Goal
Id:             goal
Title:          "Goal"
Description:    "The purpose of a Goal is to track a topic around the Shared Care Plan with its associated list of goals."
* extension contains ExpressedBy named expressedBy 0..1
* extension contains ReasonReference named reasonReference 0..1

Extension: ExpressedBy
Id: expressed-by
Title: "Expressed By"
Description: "String to indicate who expresssed this latest goal"
* value[x] only Reference($Patient or $Practitioner or $RelatedPerson)

Extension: ReasonReference
Id: reason-reference
Title: "Reason Reference"
Description: "The reason behind the goals"
* value[x] only string
