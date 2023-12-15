// extensions

Extension: ScpContextualDataIsManager
Id: scp-contextualdata-ismanager
Title: "SCP - Care Team - Manager"
Description: "Flag to identify managers of a Shared Care Plan."
* value[x] only boolean

// resource

Profile: ScpContextualData
Parent: Composition
Id: scp-contextualdata
Title: "SCP - Contextual Data"
Description: "The Contextual Data resource is used to capture the contextual information of a Shared Care Plan."

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

* identifier 2..*
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice based on the identifier.system"
* identifier ^slicing.ordered = false
* identifier contains accountSlice 1..1 and scpSlice 1..1
* identifier[accountSlice].system = "urn:cara:account"
* identifier[scpSlice].system = "urn:cara:scp"

* status 1..1
* status = #final

* type 1..1
* type = http://loinc.org#18776-5 "Plan of care note"

* section 5..5
* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "code"
* section ^slicing.rules = #open
* section ^slicing.description = "Slice based on the section.code"
* section ^slicing.ordered = false
* section contains socialHistorySlice 1..1 
    and medicalHistorySlice 1..1 
    and patientPrioritySlice 1..1
    and advanceDirectiveSlice 1..1 
    and contactsSlice 1..1
* section[socialHistorySlice].code from ScpContextualDataType
* section[socialHistorySlice].code = CaraLoincSelection#29762-2 "Social history"
* section[socialHistorySlice].text 1..1
* section[medicalHistorySlice].code from ScpContextualDataType
* section[medicalHistorySlice].code = CaraLoincSelection#11348-0 "Past medical history"
* section[medicalHistorySlice].text 1..1
* section[patientPrioritySlice].code from ScpContextualDataType
* section[patientPrioritySlice].code = CaraLoincSelection#29299-5 "Reason for visit"
* section[patientPrioritySlice].text 1..1
* section[advanceDirectiveSlice].code from ScpContextualDataType
* section[advanceDirectiveSlice].code = CaraLoincSelection#42348-3 "Advance directives"
* section[advanceDirectiveSlice].text 1..1
* section[contactsSlice].code from ScpContextualDataType
* section[contactsSlice].code = CaraSnomedSelection#70862002 "Contact person"
* section[contactsSlice].entry only Reference(ScpContact)
