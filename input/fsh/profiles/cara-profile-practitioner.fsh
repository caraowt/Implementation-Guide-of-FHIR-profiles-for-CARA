Profile: CaraHealthcareProfessionalProfile
Parent: Practitioner
Id: cara-healthcare-professional-profile
Title: "CARA - Healthcare Professional Profile"
Description: "The user profile of an Healthcare Professional in the CARA Platform."

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
* identifier contains accountSlice 1..1 and glnSlice 1..1
* identifier[accountSlice].system = "urn:cara:account"
* identifier[glnSlice].system = "urn:cara:gln"

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

Instance: BobProfile
InstanceOf: CaraHealthcareProfessionalProfile
Description: "The Healthcare Professional Profile of Bob, an Healthcare Professional."

* meta.tag[nsSlice] = FhirvaultNamespace#cara:authx
* identifier[accountSlice].system = "urn:cara:account"
* identifier[accountSlice].value = "urn:cara:account:25c19ea1-9228-4670-9a91-122a9b201032"
* identifier[glnSlice].system = "urn:cara:gln"
* identifier[glnSlice].value = "urn:cara:account:6468975461"
* active = true
* communication[preferedSlice].language = CaraLocale#de-CH
* communication[preferedSlice].preferred = true
* telecom[emailSlice].system = http://hl7.org/fhir/contact-point-system#"email"
* telecom[emailSlice].value = "bob@email.local"
