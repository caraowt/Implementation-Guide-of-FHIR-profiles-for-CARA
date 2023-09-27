Profile: CaraPatientProfile
Parent: Patient
Id: cara-patient-profile
Title: "CARA - Patient Profile"
Description: "The user profile of a Patient in the CARA Platform."

* meta.tag 1..*
* meta.tag ^slicing.discriminator.type = #pattern
* meta.tag ^slicing.discriminator.path = "system"
* meta.tag ^slicing.rules = #open
* meta.tag ^slicing.description = "Slice based on the meta.tag.system"
* meta.tag ^slicing.ordered = false
* meta.tag contains nsSlice 1..1
* meta.tag[nsSlice] from CaraPlatformNamespace
* meta.tag[nsSlice].code 1..1
* meta.tag[nsSlice].code = #cara:authx

* identifier 1..*
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice based on the identifier.system"
* identifier ^slicing.ordered = false
* identifier contains accountSlice 1..1
* identifier[accountSlice].system = "urn:cara:account"

* active 1..1

* communication 1..*
* communication ^slicing.discriminator.type = #pattern
* communication ^slicing.discriminator.path = "language"
* communication ^slicing.rules = #open
* communication ^slicing.description = "Slice based on the communication.coding"
* communication ^slicing.ordered = true
* communication contains preferedSlice 1..1
* communication[preferedSlice].language from CaraPlatformLocale (required)
* communication[preferedSlice].preferred 1..1
* communication[preferedSlice].preferred = true

* telecom 1..1
* telecom ^slicing.discriminator.type = #pattern
* telecom ^slicing.discriminator.path = "system"
* telecom ^slicing.rules = #open
* telecom ^slicing.description = "Slice based on the telecom.system"
* telecom ^slicing.ordered = true
* telecom contains emailSlice 1..1
* telecom[emailSlice].system = #email
* telecom[emailSlice].value 1..1

Instance: AliceProfile
InstanceOf: CaraPatientProfile
Description: "The Patient Profile of Alice, a patient."

* meta.tag[nsSlice] = FhirvaultNamespace#cara:authx
* identifier[accountSlice].system = "urn:cara:account"
* identifier[accountSlice].value = "urn:cara:account:11a41a24-e877-4301-b0a8-97853f386e78"
* active = true
* communication[preferedSlice].language = CaraLocale#fr-CH
* communication[preferedSlice].preferred = true
* telecom[emailSlice].system = http://hl7.org/fhir/contact-point-system#"email"
* telecom[emailSlice].value = "alice@email.local"
