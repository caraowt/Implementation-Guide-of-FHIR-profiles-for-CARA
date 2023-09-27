### Authorization

The integration with the CARA Platform leverages IHE Profiles for security.
The platform uses the IUA Profile provided by IHE for basic authorization activities.
It also employs the ATNA Profile from IHE to establish secure nodes and applications.
An Identity And Access Management System is in place to embody the Authorization Server (IUA) role outlined in the IUA Profile.

External Systems are required to register with the CARA Platform.
This registration results in the issuance of a client certificate for authenticating the Secure Application (ATNA) and Authorization Client (IUA).
A client key is also provided to identify the Authorization Client (IUA).

Access to the CARA Platform necessitates an Access Token.
The Access Token must be issued from the CARA Platform’s Authorization Server (IUA), aligning with the IHE transaction ITI-71.
External Systems have the option to introspect the Access Token, as per IHE transaction ITI-102.
The Access Token is to be included in the HTTP Request to access the Resource Server (IUA), following the IHE transaction ITI-72.

The Access Token is valid for a limited duration.
A refresh is needed by the External System before the token expires.

### Usage

External Systems access data via the RESTful FHIR API.
The API's security is enhanced by the IUA and ATNA Profiles.

The CARA Platform’s FHIR configuration employs data partitioning.
To access data, External Systems need to identify the partition name.

Every user is associated with a FHIR Vault, a specific data partition.
The partition is identified using the Account URN, the platform’s user identifier.
Authorization policies at this level are determined by the Access Token.

The CARA Platform offers a secure API to resolve the Account URN from the MPI-ID.
Flexibility for data handling is ensured with options to create additional partitions for specific use cases.
