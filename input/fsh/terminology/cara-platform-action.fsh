CodeSystem: CaraPlatformOperation
Id: cara-platform-operation
Title: "CARA - Platform Operation"
Description: "The Operations of the CARA Platform."
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #batch "Batch"
* #create "Create"
* #delete "Delete"
* #history "History"
* #patch "Patch"
* #read "Read"
* #search "Search"
* #transaction "Transaction"
* #update "Update"
* #vread "Version Read"

ValueSet: CaraPlatformAction
Id: cara-platform-action
Title: "CARA - Platform Action"
Description: "The Permission Actions of the CARA Platform."
* include codes from system CaraPlatformOperation
