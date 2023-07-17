Alias: $Goal = http://hl7.org/fhir/StructureDefinition/Goal

Profile:        Goal
Parent:         $Goal
Id:             goal
Title:          "Goal"
* extension contains ExpressedBy named expressed-by 0..1
* target 0..*
  * extension contains ReasonReference named reason-reference 0..*

Extension: ExpressedBy
Id: expressed-by
Title: "Expressed By"
Description: "String to indicate who expresssed this latest goal"
* value[x] only string

Extension: ReasonReference
Id: reason-reference
Title: "Reason Reference"
Description: "The reason behind the goals"
* value[x] only string