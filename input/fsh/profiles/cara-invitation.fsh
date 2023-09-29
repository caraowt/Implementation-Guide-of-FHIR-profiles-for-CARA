// extensions

Extension: CaraApplicationInvitationApplication
Id: cara-application-invitation-application
Title: "CARA - Application Invitation - Application"
Description: "The target of the invitation."
* value[x] only string

Extension: CaraApplicationInvitationMpiIdUrn
Id: cara-application-invitation-mpiIdUrn
Title: "CARA - Application Invitation - MPI-ID"
Description: "The MPI-ID of the patient who invited."
* value[x] only string

Extension: CaraApplicationInvitationFirstName
Id: cara-application-invitation-firstName
Title: "CARA - Application Invitation - First name"
Description: "The firstname of the patient who invited."
* value[x] only string

Extension: CaraApplicationInvitationLastName
Id: cara-application-invitation-lastName
Title: "CARA - Application Invitation - Last name"
Description: "The lastname of the patient who invited."
* value[x] only string

// resource

Profile: CaraApplicationInvitation
Parent: Basic
Id: cara-invitation
Title: "CARA - Application Invitation"
Description: "An invitation allowed a user to access to an application."

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

* code = CaraBasicResourceType#application-invitation-profile

* extension contains CaraApplicationInvitationApplication named application 1..1
* extension contains CaraApplicationInvitationMpiIdUrn named mpiIdUrn 1..1
* extension contains CaraApplicationInvitationFirstName named firstName 1..1
* extension contains CaraApplicationInvitationLastName named lastName 1..1

// example

Instance: ScpInvitation
InstanceOf: CaraApplicationInvitation
Description: "The Application Invitation to join the Alice Shared Care Plan."

* meta.tag[nsSlice] = FhirvaultNamespace#cara:authx
* identifier[accountSlice].system = "urn:cara:account"
* identifier[accountSlice].value = "urn:cara:account:25c19ea1-9228-4670-9a91-122a9b201032"
* extension[+].url = "https://terminology.cara.ch/StructureDefinition/ApplicationInvitation#application"
* extension[=].valueString = "shared-care-plan"
* extension[+].url = "https://terminology.cara.ch/StructureDefinition/ApplicationInvitation#mpiIdUrn"
* extension[=].valueString = "urn:cara:mpi_id:XXXX/YYYY"
* extension[+].url = "https://terminology.cara.ch/StructureDefinition/ApplicationInvitation#firstName"
* extension[=].valueString = "foo"
* extension[+].url = "https://terminology.cara.ch/StructureDefinition/ApplicationInvitation#lastName"
* extension[=].valueString = "bar"
