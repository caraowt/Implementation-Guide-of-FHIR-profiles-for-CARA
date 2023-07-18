Alias:          $CarePlan = http://hl7.org/fhir/StructureDefinition/CarePlan
Alias:          $Appointment =  http://hl7.org/fhir/StructureDefinition/Appointment
Alias:          $CommunicationRequest =  http://hl7.org/fhir/StructureDefinition/CommunicationRequest
Alias:          $DeviceRequest =  http://hl7.org/fhir/StructureDefinition/DeviceRequest
Alias:          $MedicationRequest =  http://hl7.org/fhir/StructureDefinition/MedicationRequest
Alias:          $NutritionOrder =  http://hl7.org/fhir/StructureDefinition/NutritionOrder
Alias:          $Task =  http://hl7.org/fhir/StructureDefinition/Task
Alias:          $ServiceRequest =  http://hl7.org/fhir/StructureDefinition/ServiceRequest
Alias:          $VisionPrescription =  http://hl7.org/fhir/StructureDefinition/VisionPrescription
Alias:          $RequestGroup =  http://hl7.org/fhir/StructureDefinition/RequestGroup

Profile:        CarePlan
Parent:         $CarePlan
Id:             careplan
Title:          "Care Plan"
Description:    "A Care Plan tailored to the needs of CARA with advanced directives"
* extension contains SocialData named socialData 0..1
* extension contains HistoricalData named historicalData 0..1
* extension contains PatientPriorities named patientPriorities 0..1
* extension contains AnticipateDirectivesExist named anticipateDirectivesExist 0..1
* extension contains AnticipateDirectivesInEHR named anticipateDirectivesInEhr 0..1
* extension contains AnticipateDirectivesLocation named anticipateDirectivesLocation 0..1
* activity 0..*
  * extension contains AttentionPoint named attentionPoint 0..1

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
Title: "Existence of Advance Directives"
Description: "This field is used to indicate whether a patient has advanced directives"
* value[x] only boolean

Extension: AnticipateDirectivesInEHR
Id: anticipate-directives-ehr
Title: "Advance Directives in EHR"
Description: "The anticipate directives are in the EHR of the patient. This field is present and is a boolean"
* value[x] only boolean

Extension: AnticipateDirectivesLocation
Id: anticipate-directives-location
Title: "Advance Directives Location"
Description: "This field is used to indicate where the advance directives are if they exist and are not located in the EHR."
* value[x] only string

Extension: AttentionPoint
Id: attention-point
Title: "Attention Point"
Description: "Attention Point on the observation"
* value[x] only boolean

Extension: ShowNote
Id: showNote
Title: "Show note in SCP monitoring screen"
Description: "Notes are by default not shown in the SCP monitoring screen. However a member of the SCP interprofessional team can choose to disclose it to the rest of the team."
* value[x] only boolean