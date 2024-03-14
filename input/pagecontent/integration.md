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

#### Client Authentication

An external system may access the CARA Platform via a Technical User.
The Technical User is a user account with a _client certificate_ and a _client id_.

The _client certificate_ is used to authenticate the Technical User.
The _client id_ is used to identify the Authorization Client ([IUA]).

The external system must request an Access Token from the CARA Platform’s Authorization Server ([IUA]).
The Access Token is issued based on the _client certificate_ and a _client id_.

<figure>
    <img 
      src="sequence-Client_Authorization.png"
      alt="Client Authorization">
    <figurecaption>Client Authorization</figurecaption>
</figure>

The HTTP request **(1)** to IAM looks like this:

```HTTP
POST /realms/cara/protocol/openid-connect/token HTTP/1.1
Host: iam.cara.ch
Content-Type: application/x-www-form-urlencoded
Content-Length: 146

grant_type=client_credentials&client_id=tcu-bestclinic%2Fscp-importer&scope=ns%3Acara%3Aauthx.Reader%20ns%3Acara%3Ascp.Contributor
```

The mTLS certificate is used to authenticate the External System.

The HTTP response **(2)** from IAM looks like this:

```HTTP
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length 1430

{
    "access_token": "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJuOGlxX3VmWGt1N25lZVN0U0tRZDR4RC1aSEprY0NtaG1aX2Z0eDhjMmUwIn0.eyJleHAiOjE3MDkzMDMyODAsImlhdCI6MTcwOTMwMjk4MCwianRpIjoiN2U5OWI1MTMtZThiMi00N2M5LWI4Y2EtYjczNzU0Zjg0NWY4IiwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6OTEwNC9yZWFsbXMvY2FyYSIsInN1YiI6ImNlOWEwNDZhLWM1NDYtNDg2Yy05Y2UwLTRkNzcxM2ExMjBjYSIsInR5cCI6IkJlYXJlciIsImF6cCI6InRjdS1iZXN0Y2xpbmljL3NjcC1pbXBvcnRlciIsInNjb3BlIjoiY2FyYS1wbGF0Zm9ybSBuczpjYXJhOmF1dGh4LlJlYWRlciBuczpjYXJhOnNjcC5Db250cmlidXRvciIsImNsaWVudEhvc3QiOiIxNzIuMjMuMC4xIiwiY2FyYTplaWRVcm4iOiJ1cm46Y2FyYTplX2lkOnNhLmNlOWEwNDZhLWM1NDYtNDg2Yy05Y2UwLTRkNzcxM2ExMjBjYSIsImNhcmE6b3JnSWRVcm4iOiJ1cm46Y2FyYTpvcmdfaWQ6Mi4xNi43NTYuNS4zMC4xLjE3OCIsImNhcmE6cm9sZXMiOlsiVEVDSE5JQ0FMX1VTRVIiXSwiY2FyYTphY2NvdW50VXJuIjoidXJuOmNhcmE6YWNjb3VudDpiZXN0Y2xpbmljL3NjcC1pbXBvcnRlciIsImNsaWVudEFkZHJlc3MiOiIxNzIuMjMuMC4xIiwiY2xpZW50X2lkIjoidGN1LWJlc3RjbGluaWMvc2NwLWltcG9ydGVyIn0.ruyz98rIW5gQMIE9ZoiBZGPvGk55Bkb8Okqlho0Uro7ZYwzvvRru2DGl8CYuoGClhs61nMe7PFHYmvPSjMjkAEEazxRSB-zg0zIrraOcbdUac26t7b8_dzhZCjyuzcqq_wEqNqsa5nxQ-BhOgySKYY5qLHMQL0XBqSp3Z3OXT4XKGQnEXZIHDw5Vx0OHm2pE8eV5lBI6ZQhpRxJucZpZ7tRacDfEwR5BGUmdRmvuubcEjMz_A95YLQ6ZBMetnatIFFCvxp6drH1hAwv0_2gijiMhTQshNkoE5S0PjFzktgI_8gLOE1K1qptIIxZ95DqT3LSmJJPj0dZZkaHNa9F9dw",
    "expires_in": 300,
    "refresh_expires_in": 0,
    "token_type": "Bearer",
    "not-before-policy": 0,
    "scope": "cara-platform ns:cara:authx.Reader ns:cara:scp.Contributor"
}
```

The Authorization Endpoint depends on the environment:

| Environment | Endpoint                                                          |
|-------------|-------------------------------------------------------------------|
| Validation  | https://iam-val.cara.ch/realms/cara/protocol/openid-connect/token |
| Integration | https://iam-int.cara.ch/realms/cara/protocol/openid-connect/token |
| Production  | https://iam.cara.ch/realms/cara/protocol/openid-connect/token     |


The grant type is always client_credentials; it is used to request an Access Token based on the client certificate.

The client ID is provided by CARA and is used to identify the IAM (Identity and Access Management) Client.

The scope is a list of permissions that the External System is requesting.
For example, ns:cara:scp.Reader requests authorization to read data located in the Shared Care Plan namespace.
The association of namespace and permission is defined for each IAM Client.

The provided Access Token, once decoded, looks like this:

```json
{
  "exp": 1709303280,
  "iat": 1709302980,
  "jti": "7e99b513-e8b2-47c9-b8ca-b73754f845f8",
  "iss": "https://iam.cara.ch/realms/cara",
  "sub": "ce9a046a-c546-486c-9ce0-4d7713a120ca",
  "typ": "Bearer",
  "azp": "tcu-bestclinic/scp-importer",
  "scope": "cara-platform ns:cara:authx.Reader ns:cara:scp.Contributor",
  "cara:eidUrn": "urn:cara:e_id:sa.ce9a046a-c546-486c-9ce0-4d7713a120ca",
  "cara:orgIdUrn": "urn:cara:org_id:2.16.756.5.30.1.178",
  "cara:roles": [ "TECHNICAL_USER" ],
  "cara:accountUrn": "urn:cara:account:bestclinic/scp-importer"
}
```

Then encoded Access Token must be included in the HTTP Request to access the Resource Server.
The inclusion must follow the IHE transaction [ITI-72].

#### Account URN Resolution

As explained earlier, the Account URN is used to identify the partition name.
The Account URN concept is not an interoperability standard.
However, a resolution API is provided to resolve the Account URN from the MPI-ID.
The API is part of the Account and Identifier Management (AIM) system, also named _authx_.

<figure>
    <img 
      src="sequence-Account_URN_Resolution.png"
      alt="Account URN Resolution">
    <figurecaption>Account URN Resolution</figurecaption>
</figure>

The Open API is defined available there: [openapi.authx.yaml](./openapi.authx.yaml).

The HTTP request **(1)** to AIM looks like this:

```HTTP
POST /api/v1/query/get-account-urn-from-mpi-id-urn HTTP/1.1
Host: iam.cara.ch
Content-Type: application/json
Authorization: Bearer <ACCESS_TOKEN>
Content-Length: 85

{
    "mpiIdUrn": "urn:cara:mpi_id:1.1.1.99.1/e2d9dbec-9f49-4944-8b6b-790e88d2bd0f"
}
```

The HTTP response **(2)** from AIM looks like this:

```HTTP
HTTP/1.1 200 OK
Content-Type: application/json

{
    "accountUrn": "urn:cara:account:19776259-4d3e-4a1d-85e3-f1c6e48ec7f1"
}
```

The Authorization Endpoint depends on the environment:

| Environment | Endpoint                                                                       |
|-------------|--------------------------------------------------------------------------------|
| Validation  | https://ws-authx-mtls-val.cara.ch/api/v1/query/get-account-urn-from-mpi-id-urn |
| Integration | https://ws-authx-mtls-int.cara.ch/api/v1/query/get-account-urn-from-mpi-id-urn |
| Production  | https://ws-authx-mtls.cara.ch/api/v1/query/get-account-urn-from-mpi-id-urn     |

The `mpiIdUrn` represents the MPI-ID (Master Patient Index ID) of the patient as a URN (Uniform Resource Name).
This means the value always starts with the prefix `urn:cara:mpi_id:`, followed by the actual MPI-ID.
The two components of the MPI-ID must be separated by a slash (`/`), for example, `<OID>/<UUID>`.

The connection to the AIM is secured with mTLS.

#### FHIR Operations

As explained earlier, the CARA Platform offers a RESTful FHIR API to access data.

<figure>
    <img 
      src="sequence-FHIR_Operation.png"
      alt="FHIR Operations">
    <figurecaption>FHIR Operations</figurecaption>
</figure>

The data is partitioned and the Account URN is used to identify the partition name **(1)**.
The partition name is the identifier of the Account URN.
For instance, given the Account URN `urn:cara:account:19776259-4d3e-4a1d-85e3-f1c6e48ec7f1`, the partition name is `19776259-4d3e-4a1d-85e3-f1c6e48ec7f1`.
The partition name must be included in the URL of the FHIR API.

The format of the URL path is `/fhir/<partition-name>`, e.g. `/fhir/19776259-4d3e-4a1d-85e3-f1c6e48ec7f1`.
Therefore, to get active CarePlan resources located in the SCP Namespace, the HTTP request **(2)** to the FHIR Server looks like this:

```HTTP
GET /fhir/19776259-4d3e-4a1d-85e3-f1c6e48ec7f1/CarePlan?status=active&_tag=https%3A%2F%2Fterminology.cara.ch%2FCodeSystem%2Ffhirvault-namespace%7Ccara%3Ascp HTTP/1.1
Host: ws-fhir-mtls.cara.ch
Accept: application/fhir+json
Authorization: Bearer <ACCESS_TOKEN>
Content-Length: 85
```

The HTTP response **(3)** from the FHIR Server looks like this:

```HTTP
HTTP/1.1 200 OK
Content-Type: application/fhir+json;charset=UTF-8

{
    "resourceType": "Bundle",
    "id": "72738ded-a46e-4ec9-a9f0-de9c9778c23c",
    "meta": {
        "lastUpdated": "2024-03-01T15:24:54.223+00:00"
    },
    "type": "searchset",
    "total": 1,
    "link": [
        {
            "relation": "self",
            "url": "http://localhost:9051/fhir/19776259-4d3e-4a1d-85e3-f1c6e48ec7f1/CarePlan?_tag=https%3A%2F%2Fterminology.cara.ch%2FCodeSystem%2Ffhirvault-namespace%7Ccara%3Ascp&status=active"
        }
    ],
    "entry": [
        {
            "fullUrl": "http://localhost:9051/fhir/19776259-4d3e-4a1d-85e3-f1c6e48ec7f1/CarePlan/55a1101d-ee7a-4743-badc-21210748b70f",
            "resource": {
                "resourceType": "CarePlan",
                "id": "55a1101d-ee7a-4743-badc-21210748b70f",
                "meta": {
                    "versionId": "2",
                    "lastUpdated": "2024-03-01T15:24:46.497+00:00",
                    "source": "#1htZYWE93lKOVrVW",
                    "profile": [
                        "https://terminology.cara.ch/StructureDefinition/ScpCarePlan"
                    ],
                    "tag": [
                        {
                            "system": "https://terminology.cara.ch/CodeSystem/fhirvault-namespace",
                            "version": "1.0.0",
                            "code": "cara:scp",
                            "display": "Shared Care Plan"
                        }
                    ]
                },
                "identifier": [
                    {
                        "system": "urn:cara:scp",
                        "value": "urn:cara:scp:55a1101d-ee7a-4743-badc-21210748b70f"
                    },
                    {
                        "system": "urn:cara:account",
                        "value": "urn:cara:account:19776259-4d3e-4a1d-85e3-f1c6e48ec7f1"
                    },
                    {
                        "system": "urn:cara:mpi_id",
                        "value": "urn:cara:mpi_id:1.1.1.99.1/e2d9dbec-9f49-4944-8b6b-790e88d2bd0f"
                    }
                ],
                "status": "active",
                "intent": "directive",
                "subject": {
                    "reference": "Patient/4b674019-9358-4065-ac9f-7a98d405f0d7"
                },
                "created": "2024-03-01T15:24:44+00:00",
                "careTeam": [
                    {
                        "reference": "CareTeam/55a1101d-ee7a-4743-badc-21210748b70f"
                    }
                ],
                "goal": [
                    {
                        "reference": "Goal/f8c5f81b-0fc1-4260-b68f-2fa9c2f352c2"
                    }
                ]
            },
            "search": {
                "mode": "match"
            }
        }
    ]
}
```

The endpoint for the FHIR Server depends on the environment:

| Environment | Endpoint                              | 
|-------------|---------------------------------------|
| Validation  | https://ws-fhir-mtls-val.cara.ch/fhir |
| Integration | https://ws-fhir-mtls-int.cara.ch/fhir |
| Production  | https://ws-fhir-mtls.cara.ch/fhir     |

The connection to the FHIR Server is secured with mTLS.

#### Shared Care Plan

The Shared Care Plan (SCP) is a specific use case of the CARA Platform.
The SCP is a FHIR resource that represents a care plan shared between multiple healthcare providers.
The SCP is located in the SCP Namespace.
The SCP is profile based and is defined by the [SCP - Care Plan](./StructureDefinition-scp-careplan.html).

To get access to an SCP, the External System must be part of the Care Team as an active [SCP - Team Member - Organization](./StructureDefinition-scp-teammember-organization.html).
Moreover, the OID of the TCU (Technical User) must match the OID of the organization in the SCP.

Presently, Primary Systems are expected to fetch the SCP context to be able to manage efficiently their Observation resources.

The journey to access the SCP is as follows:

1. Authenticate the TCU with the CARA Platform.
2. Resolve the Account URN from the MPI-ID.
3. Fetch the SCP context.
4. Contribute to the SCP.

The first two steps are already explained in the previous sequences.

The third step is to fetch the SCP resources, so that the External System can contribute efficiently to the SCP.
The SCP context can be fetched in two FHIR operations.
The first one fetch the CarePlan and the associated Goals.
The second one fetch the CareTeam and the associated members.

The forth step is to contribute to the SCP.
Based on the SCP context, the External System can contribute to the SCP by creating Observations.

##### Fetch the CarePlan and Goals

The following HTTP request fetch an active Shared Care Plan and its associated Goals:

```HTTP
GET /fhir/19776259-4d3e-4a1d-85e3-f1c6e48ec7f1/CarePlan?_profile=https://terminology.cara.ch/StructureDefinition/ScpCarePlan&_tag=https%3A%2F%2Fterminology.cara.ch%2FCodeSystem%2Ffhirvault-namespace%7Ccara:scp&_include=CarePlan:goal&status=active HTTP/1.1
Host: ws-fhir-mtls.cara.ch
Authorization: Bearer <ACCESS_TOKEN>
```

The URL path is composed of the partition name (i.e. `19776259-4d3e-4a1d-85e3-f1c6e48ec7f1`) and the resource type (i.e. `CarePlan`).

The parameters are as follows:

| Parameter | Value                                                                | Description                                     |
|-----------|----------------------------------------------------------------------|-------------------------------------------------|
| _profile  | https://terminology.cara.ch/StructureDefinition/ScpCarePlan          | The FHIR profile of the CarePlan.               |
| _tag      | https://terminology.cara.ch/CodeSystem/fhirvault-namespace\|cara:scp | The FHIR tag to specify the SCP Namespace.      |
| _include  | CarePlan:goal                                                        | Include the Goals associated with the CarePlan. |
| status    | active                                                               | The status of the CarePlan.                     |

One of the key pieces of information in the response are the codes for the Goals and their associated Targets.
This allows the Primary System to determine whether its existing observations can be connected to the SCP.

##### Fetch the CareTeam and Members

The following HTTP request fetch an active Shared Care Plan and its associated Goals:

```HTTP
GET /fhir/19776259-4d3e-4a1d-85e3-f1c6e48ec7f1/CareTeam?_profile=https://terminology.cara.ch/StructureDefinition/ScpCareTeam&_tag=https%3A%2F%2Fterminology.cara.ch%2FCodeSystem%2Ffhirvault-namespace%7Ccara:scp&_include=CareTeam:participant&status=active HTTP/1.1
Authorization: Bearer <ACCESS_TOKEN>
```

The URL path is composed of the partition name (i.e. `19776259-4d3e-4a1d-85e3-f1c6e48ec7f1`) and the resource type (i.e. `CareTeam`).

The parameters are as follows:

| Parameter | Value                                                                | Description                                            |
|-----------|----------------------------------------------------------------------|--------------------------------------------------------|
| _profile  | https://terminology.cara.ch/StructureDefinition/ScpCareTeam          | The FHIR profile of the CareTeam.                      |
| _tag      | https://terminology.cara.ch/CodeSystem/fhirvault-namespace\|cara:scp | The FHIR tag to specify the SCP Namespace.             |
| _include  | CarePlan:goal                                                        | Include the participants associated with the CareTeam. |
| status    | active                                                               | The status of the CareTeam.                            |

The most crucial detail in the response is the reference to the FHIR Organization linked to the SCP.
This reference is utilized to assign the performer for the Observation resources.

##### Create Observations

FHIR provides many ways to manage resources.
However, the usage of FHIR Batch operation is encouraged to manage Observations.

The following HTTP request defines a FHIR batch creating one Observation resource:

```HTTP
PUT /fhir/19776259-4d3e-4a1d-85e3-f1c6e48ec7f1 HTTP/1.1
Host: ws-fhir-mtls.cara.ch
Content-Type: application/json
Authorization: Bearer <ACCESS_TOKEN>

{
    "resourceType": "Bundle",
    "type": "batch",
    "entry": [
        {
            "fullUrl": "Observation/e9bead6e-92a2-410b-975a-b000f01ae39e",
            "request": {
                "method": "PUT",
                "url": "Observation/e9bead6e-92a2-410b-975a-b000f01ae39e"
            }
            "resource": {
                "resourceType": "Observation",
                "id": "e9bead6e-92a2-410b-975a-b000f01ae39e",
                "meta": {
                    "profile": [
                        "https://terminology.cara.ch/StructureDefinition/ScpObservationExternal"
                    ],
                    "tag": [
                        {
                            "system": "https://terminology.cara.ch/CodeSystem/fhirvault-namespace",
                            "version": "1.0.0",
                            "code": "cara:scp",
                            "display": "Shared Care Plan"
                        }
                    ]
                },
                "identifier": [
                    {
                        "system": "urn:cara:account",
                        "value": "urn:cara:account:19776259-4d3e-4a1d-85e3-f1c6e48ec7f1"
                    }
                ],
                "status": "final",
                "effectiveInstant": "2024-03-14T15:41:06.332Z",
                "code": {
                    "coding": [
                        {
                            "system": "https://terminology.cara.ch/CodeSystem/scp-custom-goal-type",
                            "version": "1.0.0",
                            "code": "breathing",
                            "display": "Breathing"
                        }
                    ]
                },
                "performer": [
                    {
                        "reference": "Organization/11cd469d-2ebd-40cb-816c-85fa9d52b62c"
                    }
                ],
                "valueString": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                "interpretation": [
                    {
                        "coding": [
                            {
                                "system": "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation",
                                "code": "AA",
                                "display": "Critical abnormal"
                            }
                        ]
                    }
                ]
            }
        }
    ]
}
```

Three information are important in this request:

- The Namespace is specified in the Observation resource, c.f. the tag `https://terminology.cara.ch/CodeSystem/fhirvault-namespace`
- The declaration of the FHIR profile `https://terminology.cara.ch/StructureDefinition/ScpObservationExternal`
- The reference to the Organization that is contributing to the SCP, c.f. the performer `Organization/11cd469d-2ebd-40cb-816c-85fa9d52b62c`

[ITI-71]: https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71
[ITI-72]: https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72
[ITI-102]: https://profiles.ihe.net/ITI/IUA/index.html#3102-introspect-token-iti-102
[ITI-103]: https://profiles.ihe.net/ITI/IUA/index.html#3103-get-authorization-server-metadata-iti-103
[ATNA]: https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html
[ITI-19]: https://profiles.ihe.net/ITI/TF/Volume2/ITI-19.html#3.19
[ITI-45]: https://profiles.ihe.net/ITI/TF/Volume2/ITI-45.html
[FHIR Search]: https://hl7.org/fhir/http.html#search
[FHIR Batch]: https://hl7.org/fhir/http.html#transaction
