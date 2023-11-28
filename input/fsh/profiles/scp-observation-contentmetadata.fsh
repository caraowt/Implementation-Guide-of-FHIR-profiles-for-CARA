// @Name: Content Metadata
// @Description: Content Metadata extension containing sub-extensions for urn, mimeType and filename

Extension: ScpObservationContentMetadata
Id: content-metadata
Title: "Document Metadata"
Description: "Metadata corresponding to an uploaded Document."
* insert ExtensionContext(Procedure)
* extension contains
    contentUrn 1..1 MS and
    mimeType 1..1 MS and
    filename 1..1 MS
* extension[contentUrn].value[x] only Identifier
* extension[contentUrn].value[x].system = "urn:cara:content"
* extension[mimeType].valueString only string
* extension[filename].valueString only string

* insert DocumentExtension (
    contentUrn,
    "ContentUrn",
    "The CaraUrn corresponding to a Document in the Document Storage.")
* insert DocumentExtension (
    mimeType,
    "MimeType",
    "The MimeType of the saved Document referenced by ContentUrn.")
* insert DocumentExtension (
    filename,
    "Filename",
    "The name of the file.")

RuleSet: ExtensionContext(path)
* ^context[+].type = #element
* ^context[=].expression = "{path}"

// The strings defined for shorthand definition should not be quoted, and any comma must be escaped with a backslash.
RuleSet: DocumentExtension(path, short, definition)
* extension[{path}] ^short = {short}
* extension[{path}] ^definition = {definition}
