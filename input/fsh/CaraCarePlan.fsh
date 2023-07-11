Profile:        CaraCarePlan
Parent:         CarePlan
Id:             careplan
Title:          "CARA Care Plan"
Description:    "A Care Plan tailored to the needs of CARA with advanced directives"
* extension contains SocialData named socialdata 0..1
* extension contains HistoricalData named historicaldata 0..1
* extension contains PatientPriorities named patientpriorities 0..1

Extension: SocialData
Id: social-data
Title: "Social Data"
Description: "Used to describe the social background of a patient affiliated to CARA"

Extension: HistoricalData
Id: historical-data
Title: "Historical Data"
Description: "Used to describe the historical background of a patient affiliated to CARA"

Extension: PatientPriorities
Id: patient-priorities
Title: "Patient Priorities"
Description: "Used to describe the priorities of a patient with regard to his SCP"
