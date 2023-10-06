// extentions

Extension: CaraResourceAccessPolicyPrincipal
Id: cara-resource-access-policy-principal
Title: "CARA - Resource Access Policy - Principal"
Description: "Expression to identify the principal."
* value[x] only string

// resource

Profile: CaraResourceAccessPolicy
Parent: Permission
Id: cara-resource-access-policy
Title: "CARA - Resource Access Policy"
Description: "An Access Policy of the namespace's resource."

* meta.tag 1..*
* meta.tag ^slicing.discriminator.type = #pattern
* meta.tag ^slicing.discriminator.path = "system"
* meta.tag ^slicing.rules = #open
* meta.tag ^slicing.description = "Slice based on the meta.tag.system"
* meta.tag ^slicing.ordered = false
* meta.tag contains nsSlice 1..1
* meta.tag[nsSlice] from CaraPlatformNamespace
* meta.tag[nsSlice].code 1..1

* status 1..1
* status = PermissionStatus#active

* combining 1..1
* combining = PermissionRuleCombining#deny-unless-permit

* rule 1..*


* rule.type 1..1
* rule.type = ConsentProvisionType#permit

* rule.data 0..*
* rule.data.expression 1..1
* rule.data.expression.language 1..1
* rule.data.expression.language = urn:ietf:bcp:13#text/fhirpath"
* rule.data.expression.expression 1..1

* rule.activity 1..*
* rule.activity.extension contains CaraResourceAccessPolicyPrincipal named principal 1..*
* rule.activity.action 0..*
* rule.activity.action from CaraPlatformAction
