The Platform encompassed two primary domains:

- User profiles within the platform.
- Shared Care Plan concepts.

### User Profile

Users on the CARA Platform fall into one of three categories: Patient Users, Healthcare Professionals, and Local Users.
Each category is characterized by distinct identification protocols and data handling practices.

**Patient Users:**
- Identification: Recognized through their listing in CARA’s Master Patient Index (MPI).
- Profile Basis: Profiles are primarily constructed from data within the MPI.
- Resource Profile: [CARA - Patient Profile](./StructureDefinition-cara-patient-profile.html)

**Healthcare Professionals:**
- Identification: Identified via their registration in CARA’s Healthcare Professional Directory.
- Profile Basis: Profiles are predominantly formed from data in the Healthcare Professional Directory.
- Resource Profile: [CARA - Healthcare Professional Profile](./StructureDefinition-cara-healthcare-professional-profile.html)
- 
**Local Users:**
- Identification: Those not found in the MPI or Healthcare Professional Directory.
- Profile Basis: Profiles are chiefly built from data supplied by the Identity Provider.
- Resource Profile: [CARA - Local Profile](./StructureDefinition-cara-local-profile.html)

#### Storage Limitations

The CARA Platform adopts a stringent approach to data storage to ensure user privacy and system efficiency:

- Profile Completeness: The platform abstains from storing comprehensive user profiles to safeguard privacy.
- Data Selection: Only essential operational data and information unavailable in the primary source systems (MPI, HPD, Identity Provider) are retained. This selective storage ensures that the platform remains agile and secure.

### Shared Care Plan

A Shared Care Plan (SCP) is a collaborative tool designed to facilitate the coordinated care of a patient by a multidisciplinary team of professionals and caregivers.
It serves as a centralized repository of information related to the patient's care, enhancing communication and collaboration among all stakeholders.

**Centralized Information Hub**

The SCP consolidates critical patient data, including observations, notes, and additional contextual information like history and contacts.
This centralization aids in the efficient management and tracking of the patient’s care relative to defined goals.

**Collaborative Space**

Designed to foster collaboration, the SCP enables real-time sharing of information among healthcare professionals, caregivers, and other stakeholders.
It ensures that all parties have access to up-to-date and accurate data, promoting informed decision-making.

**Integration with Third Parties**

The SCP is not only shareable but also integrative.
It is equipped to incorporate observations and data from third-party sources, ensuring a comprehensive view of the patient’s health and care journey.

#### Data Model

Each Shared Care Plan is structured with a dedicated Care Team and an array of specific Goals to optimize patient care.
The SCP is further enhanced by the addition of Observations and Notes, which provide additional context and insights.

A Shared Care Plan is represented by the [SCP - Care Plan](./StructureDefinition-scp-careplan.html) FHIR Profile.

##### Care Team Structure

- FHIR Profile: [SCP - SCP - Care Team](./StructureDefinition-scp-careteam.html)

**Healthcare Professionals:**
- Identification: Individuals listed in the Healthcare Professional Directory.
- Integration: Invited to the Care Team by SCP holders or managers.
- Roles: Eligible to be assigned as SCP managers for enhanced oversight.
- FHIR Profile: [SCP - Team Member - Practitioner](./StructureDefinition-scp-teammember-practitioner.html)

**Caregivers:**
- Identification: Platform Users not categorized as Healthcare Professionals nor Patients.
- Integration: Added to the Care Team by SCP holders or managers.
- FHIR Profile: [SCP - Team Member - Related Person](./StructureDefinition-scp-teammember-relatedperson.html)

**Organizations:**
- Identification: An organization listed in the Healthcare Professional Directory.
- Integration: Added to the Care Team by SCP holders or managers.
- FHIR Profile: [SCP - Team Member - Organization](./StructureDefinition-scp-teammember-organization.html)

**Organization Members:**
- Identification: Members of an organization added to the Care Team.

##### Goals and Parameters

**Goals:**
- Description: Outline the long-term desired health outcomes.
- Management: Administered by SCP holders or managers.
- FHIR Profile: [SCP - Goal](./StructureDefinition-scp-goal.html)

**Parameters:**
- Incorporation: Attached to Goals for quantitative progress assessment.
- Management: Overseen by SCP holders or managers.

#### Contributions to a Shared Care Plan

**Observations:**
- Definition: Data points or statements reflecting the patient’s health status.
- Types: Can be qualitative statements or quantitative measures.
- Contribution: Added by both SCP holders and Care Team members.
- FHIR Profiles:
  - [SCP - Observation](./StructureDefinition-scp-observation.html)
  - [SCP - External Observation](./StructureDefinition-scp-external-observation.html)

**Notes:**
- Definition: Qualitative insights not used for health status evaluation.
- Contribution: Added by both SCP holders and Care Team members.
- FHIR Profile: [SCP - Note](./StructureDefinition-scp-note.html)
