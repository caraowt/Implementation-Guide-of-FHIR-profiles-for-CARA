Profile:        CaraCarePlan
Parent:         CarePlan
Id:             careplan
Title:          "CARA Care Plan"
Description:    "A Care Plan tailored to the needs of CARA with advanced directives"
* extension contains SocialData named socialdata 0..1
* extension contains HistoricalData named historicaldata 0..1
* extension contains PatientPriorities named patientpriorities 0..1
* activity 0..1
  * extension contains AttentionPoint named attention-point 0..1

Extension: SocialData
Id: social-data
Title: "Social Data"
Description: "Used to describe the social background of a patient affiliated to CARA"
* value[x] only string

Extension: HistoricalData
Id: historical-data
Title: "Historical Data"
Description: "Used to describe the historical background of a patient affiliated to CARA"
* value[x] only string

Extension: PatientPriorities
Id: patient-priorities
Title: "Patient Priorities"
Description: "Used to describe the priorities of a patient with regard to his SCP"
* value[x] only string

Extension: AnticipateDirectivesExist
Id: anticipate-directives-exist
Title: "Existence of AD"
Description: "This field is used to indicate whether a patient has advanced directives"
* value[x] only boolean

Extension: AnticipateDirectivesInEPR
Id: anticipate-directives-epr
Title: "Advance Directives in EHR"
Description: "The anticipate directives are in the EHR of the patient. This field is present "
* value[x] only boolean

Extension: AttentionPoint
Id: attention-point
Title: "Attention Point"
Description: "Attention Point on the observation"
* value[x] only boolean