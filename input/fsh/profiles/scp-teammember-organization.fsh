Profile: ScpTeamMemberOrganization
Parent: Organization
Id: scp-teammember-organization
Title: "SCP - Team Member - Organization"
Description: "The Team Member of a Shared Care Plan with the profile Organization."

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

* identifier 3..*
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice based on the identifier.system"
* identifier ^slicing.ordered = false
* identifier contains accountSlice 1..1 and scpSlice 1..1 and glnSlice 1..1
* identifier[accountSlice].system = "urn:cara:account"
* identifier[scpSlice].system = "urn:cara:scp"
* identifier[orgIdSlice].system = "urn:cara:org_id"

* active 1..1

* name 1..1