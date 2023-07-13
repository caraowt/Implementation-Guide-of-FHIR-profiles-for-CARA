Profile:        CaraPatient
Parent:         Patient
Id:             cara-patient
Title:          "CARA Patient"
Description:    "This profile extension is used to ensure the fields of the master patient index are properly used throughout the implementation."
* extension contains CountryOfBirth named birthCountry 0..1

Extension:  CountryOfBirth
Id: country-of-birth
Title: "Country of Birth"
Description: "This field is used to render the country of birth of the patient"
* value[x] only CodeableConcept
* valueCodeableConcept from http://hl7.org/fhir/ValueSet/country