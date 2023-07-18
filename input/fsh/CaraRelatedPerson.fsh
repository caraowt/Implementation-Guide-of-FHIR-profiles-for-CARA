Alias: $RelatedPerson = http://hl7.org/fhir/StructureDefinition/RelatedPerson

Profile:        RelatedPerson
Parent:         $RelatedPerson
Id:             related-person
Title:          "Related Person"
Description:    "This profile is used to add externals to a care team."
* extension contains IsContact named isContact 0..1
* extension contains IsEmergency named isEmergency 0..1

Extension: IsContact
Id: isContact
Title: "Is Contact"
Description: "This boolean will enable to differentiate an external to a simple contact of the patient"
* value[x] only boolean

Extension: IsEmergency
Id: isEmergency
Title: "Is Emergency"
Description: "This boolean will determine wether a contact should be called if an emergency was performed on a patient"
* value[x] only boolean

