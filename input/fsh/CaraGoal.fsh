Alias: $Goal = http://hl7.org/fhir/StructureDefinition/Goal

Profile:        Goal
Parent:         $Goal
Id:             goal
Title:          "Goal"
* extension contains ExpressedBy named expressed-by 0..1

Extension: ExpressedBy
Id: expressed-by
Title: "Expressed By"
Description: "String to indicate who expresssed this latest goal"
* value[x] only string
