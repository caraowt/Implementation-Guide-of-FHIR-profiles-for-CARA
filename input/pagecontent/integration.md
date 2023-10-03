### Introduction

The integration with the CARA Platform leverages on IHE Profiles for security.
The platform uses the [IUA] Profile provided by IHE for basic authorization activities.
It also employs the [ATNA] Profile to establish secure nodes and applications.
An Identity And Access Management System is in place to embody the Authorization Server role outlined in the [IUA] Profile.
External Systems are required to register with the CARA Platform.
This registration results in the issuance of a client certificate for authenticating the Technical Users.
A client id is also provided to identify the Authorization Client ([IUA]).

Access to the CARA Platform necessitates an Access Token.
The Access Token must be issued from the CARA Platform’s Authorization Server ([IUA]), aligning with the IHE transaction [ITI-71].
External Systems have the option to introspect the Access Token, as per IHE transaction [ITI-102].
The Access Token is to be included in the HTTP Request to access the Resource Server ([IUA]), following the IHE transaction [ITI-72].
The Access Token is valid for a limited duration.
A refresh is needed by the External System before the token expires.

External Systems access data via the RESTful FHIR API.
The CARA Platform’s FHIR configuration employs data partitioning.
To access data, External Systems need to identify the partition name.
Every user is associated with a FHIR Vault, a specific data partition.
The partition is identified using the Account URN, the platform’s user identifier.
The Access Token determines authorization policies at this level.
The CARA Platform offers a secure API to resolve the Account URN from the MPI-ID.
Flexibility for data handling is ensured with options to create additional partitions for specific use cases.

### Sequences

#### Technical User

An external system may access the CARA Platform via a Technical User.
The Technical User is a user account with a client certificate and a client id.

##### Access and Data Retrieval Workflow in CARA Platform

<div>
    <img 
      src="sequence-Access and Data Retrieval Workflow in CARA Platform.png"
      alt="sequence-Access and Data Retrieval Workflow in CARA Platform.png">
</div>

###### Entities Involved

- External System: Initiates the processes by requesting an Access Token and then proceeds to resolve AccountURN and call FHIR operations.
- Identity And Access Management (IAM): Responds to the Access Token request and provides it to the External System.
- Account and Identifier Management (AIM): Helps in resolving the AccountURN by utilizing the provided MPI-ID.
- FHIR Vault: Processes the FHIR operations called by the External System and returns the FHIR Result.

###### Getting Access Token

- The process begins with the External System requesting an Access Token from the Identity and Access Management (IAM) using the ITI-71 transaction.
- IAM is activated, processes the request, and sends back the Access Token to the External System.
- The External System receives the Access Token, and IAM is deactivated.

The HTTP request to IAM looks like this:

```
POST /realms/cara/protocol/openid-connect/token HTTP/1.1
Host: iam.cara.ch
Content-Type: application/x-www-form-urlencoded
Content-Length: 54

grant_type=client_credentials&client_id=bestclinic-tcu
```

The mTLS certificate is used to authenticate the External System.

###### Resolving Account URN

- Next, the External System interacts with Account and Identifier Management (AIM) to resolve the Account Uniform Resource Name (URN) by providing the Master Patient Index ID (MPI-ID).
- AIM is activated and returns the AccountURN to the External System.
- AIM is then deactivated, marking the end of this interaction.

###### Calling FHIR Operations

- With the Access Token and AccountURN, the External System is now equipped to call a FHIR operation from the FHIR Vault.
- The FHIR Vault is activated, and it processes the request from the External System.
- The FHIR Result is sent back to the External System, and the FHIR Vault is deactivated.

##### Patient Data Processing and Observation Integration Workflow

<div>
    <img 
      src="sequence-Patient Data Processing and Observation Integration Workflow.png" 
      alt="sequence-Patient Data Processing and Observation Integration Workflow.png">
</div>

###### Access Token issuance

- External System issues an Access Token with ([ITI-71]).
    - External System must provide a client id issued by CARA.
    - External System must initiate an mTLS connection with the client certificate issued by CARA.
- External System must include the Access Token in the HTTP Requests to the FHIR Vault ([ITI-72]).

###### Identifiers resolution

- External System resolves the MPI-ID of the Patient from its local identifier ([ITI-45]).
    - The transaction PIXV3 Query [ITI-45] is not covered by this implementation guide.
- External System resolves the AccountURN of the Patient from the MPI-ID from the Account and Identifier Management (AIM).
- External System must extract the Partition Name from the AccountURN.
    - `urn:cara:account:alice_1234` → `alice_1234`

###### Get and process the Shared Care Plan context

- External System must fetch the context of a Shared Care Plan: CarePlan, CareTeam, Goals.
    - One FHIR Operation ([FHIR Search]) is enough to get all the resources.
- External System must identify its organization in the care team.
    - The GLN of the External System's organization must match the GLN (`Organization.identifier`) of the Care Team's organization.
- External System must analyze the candidate observations to identify the ones that are relevant to Shared Care Plan.
    - External System must identify the observations that match the Goal Type (`goal.category`) of active Goals (`goal.lifecycleStatus`).
    - External System must identify the observations that match the Target Type (`goal.target.detailCode`) of active Goals (`goal.target.extention.status`).
- External System must evaluate the attention point for quantitative observations.
    - When the metric value of an observation doesn't fit the range of a target, then the observation must be flagged as an attention point.

###### Create and transfer observations to the Shared Care Plan

- External System must create Observation resource.
    - External System must set a UUID (`Observation.id`).
      - External System may override Observation resource when the UUID is already used. 
    - External System must set the reference of the matching Organization (`Observation.performer`).
- External System must push the Observation resources with FHIR Batch operations.
    - External System must handle the retry on error.
    - External System must handle the rate limit exceptions.

[IUA]: https://profiles.ihe.net/ITI/IUA/index.html
[ITI-71]: https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71
[ITI-72]: https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72
[ITI-102]: https://profiles.ihe.net/ITI/IUA/index.html#3102-introspect-token-iti-102
[ITI-103]: https://profiles.ihe.net/ITI/IUA/index.html#3103-get-authorization-server-metadata-iti-103
[ATNA]: https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html
[ITI-19]: https://profiles.ihe.net/ITI/TF/Volume2/ITI-19.html#3.19
[ITI-45]: https://profiles.ihe.net/ITI/TF/Volume2/ITI-45.html
[FHIR Search]: https://hl7.org/fhir/http.html#search
[FHIR Batch]: https://hl7.org/fhir/http.html#transaction
