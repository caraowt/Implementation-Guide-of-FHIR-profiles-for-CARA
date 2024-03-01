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

<div>
    <img 
      src="Client Authorization"
      alt="sequence-Client_Authorization.png">
</div>

The HTTP request **(1)** to IAM looks like this:

```
POST /realms/cara/protocol/openid-connect/token HTTP/1.1
Host: iam.cara.ch
Content-Type: application/x-www-form-urlencoded
Content-Length: 146

grant_type=client_credentials&client_id=tcu-bestclinic%2Fscp-importer&scope=ns%3Acara%3Aauthx.Reader%20ns%3Acara%3Ascp.Contributor
```

The mTLS certificate is used to authenticate the External System.

The HTTP response **(2)** from IAM looks like this:

```
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

<div>
    <img 
      src="Account URN Resolution"
      alt="sequence-Account_URN_Resolution.png">
</div>

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

<div>
    <img 
      src="Account URN Resolution"
      alt="sequence-Account_URN_Resolution.png">
</div>

The data is partitioned and the Account URN is used to identify the partition name **(1)**.
The partition name is the identifier of the Account URN.
For instance, given the Account URN `urn:cara:account:19776259-4d3e-4a1d-85e3-f1c6e48ec7f1`, the partition name is `19776259-4d3e-4a1d-85e3-f1c6e48ec7f1`.
The partition name must be included in the URL of the FHIR API.

To get the CarePlan resources located in the SCP Namespace, the HTTP request **(2)** to the FHIR Server looks like this:

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
- FHIR Server: Processes the FHIR operations called by the External System and returns the FHIR Result.

###### Getting Access Token

- The process begins with the External System requesting an Access Token from the Identity and Access Management (IAM) using the ITI-71 transaction.
- IAM is activated, processes the request, and sends back the Access Token to the External System.
- The External System receives the Access Token, and IAM is deactivated.

###### Resolving Account URN

- Next, the External System interacts with Account and Identifier Management (AIM) to resolve the Account Uniform Resource Name (URN) by providing the Master Patient Index ID (MPI-ID).
- AIM is activated and returns the AccountURN to the External System.
- AIM is then deactivated, marking the end of this interaction.

###### Calling FHIR Operations

- With the Access Token and AccountURN, the External System is now equipped to call a FHIR operation from the FHIR Server.
- The FHIR Server is activated, and it processes the request from the External System.
- The FHIR Result is sent back to the External System, and the FHIR Server is deactivated.

The endpoint for the FHIR Server depends on the environment:

| Environment | Endpoint                              | 
|-------------|---------------------------------------|
| Validation  | https://ws-fhir-mtls-val.cara.ch/fhir |
| Integration | https://ws-fhir-mtls-int.cara.ch/fhir |
| Production  | https://ws-fhir-mtls.cara.ch/fhir     |

The connection to the FHIR Server is secured with mTLS.

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
