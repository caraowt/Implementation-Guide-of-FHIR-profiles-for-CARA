The Platform encompassed two primary domains:

- User profiles within the platform.
- Shared Care Plan concepts.

### User Profile

Users on the CARA Platform fall into one of three categories: Patient Users, Healthcare Professionals, and Local Users.
Each category is characterized by distinct identification protocols and data handling practices.

**Patient Users:**
- Identification: Recognized through their listing in CARA’s Master Patient Index (MPI).
- Profile Basis: Profiles are primarily constructed from data within the MPI.

**Healthcare Professionals:**
- Identification: Identified via their registration in CARA’s Healthcare Professional Directory.
- Profile Basis: Profiles are predominantly formed from data in the Healthcare Professional Directory.

**Local Users:**
- Identification: Those not found in the MPI or Healthcare Professional Directory.
- Profile Basis: Profiles are chiefly built from data supplied by the Identity Provider.

#### Storage Limitations

The CARA Platform adopts a stringent approach to data storage to ensure user privacy and system efficiency:

- Profile Completeness: The platform abstains from storing comprehensive user profiles to safeguard privacy.
- Data Selection: Only essential operational data and information unavailable in the primary source systems (MPI, HPD, Identity Provider) are retained. This selective storage ensures that the platform remains agile and secure.

#### User Profile Elements

User profiles on CARA are enhanced with specific features that not only augment user interaction but also ensure operational efficiency.

##### Patient Favourites:

- Content: A user-curated list of MPI-IDs marked for easy and quick access.
- Purpose: Designed to streamline user experience by offering instant access to specific patient profiles, reducing the need for repetitive searches.

##### Registered Application Invitations:

- Content: A log of application invitations that the user has accepted.
- Functionality: Serves as a mechanism for intentional data sharing, enhancing collaborative interactions and data exchange among platform users.

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

Each SCP is structured with a dedicated Care Team and an array of specific Goals to optimize patient care.
The SCP is further enhanced by the addition of Observations and Notes, which provide additional context and insights.

##### Care Team Structure

**Healthcare Professionals:**
- Identification: Individuals listed in the Healthcare Professional Directory.
- Integration: Added to the Care Team by SCP holders or managers.
- Roles: Eligible to be assigned as SCP managers for enhanced oversight.

**Caregivers:**
- Identification: Platform Users not categorized as Healthcare Professionals.
- Integration: Invited to the Care Team by SCP holders or managers.

##### Goals and Parameters

**Goals:**
- Description: Outline the long-term desired health outcomes.
- Management: Administered by SCP holders or managers.

**Parameters:**
- Incorporation: Attached to Goals for quantitative progress assessment.
- Management: Overseen by SCP holders or managers.

#### Contributions to SCP

**Observations:**
- Definition: Data points or statements reflecting the patient’s health status.
- Types: Can be qualitative statements or quantitative measures.
- Contribution: Added by both SCP holders and Care Team members.

**Notes:**
- Definition: Qualitative insights not used for health status evaluation.
- Contribution: Can be added by SCP holders and Care Team members for additional context.
