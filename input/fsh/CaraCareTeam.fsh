Alias:          $CareTeam = http://hl7.org/fhir/StructureDefinition/CareTeam

Profile:        CareTeam
Parent:         $CareTeam
Id:             care-team
Title:          "Care Team"
Description:    "The care team is comprised of the patient, his legal representatives, healthcare professionals contributing to his shared care plan and externals."

* participant
  * extension contains Comment named comment 0..1

Extension: Comment
Id: comment
Title: "Comment"
Description: "Used to describe the social background of a patient affiliated to CARA"
* value[x] only string