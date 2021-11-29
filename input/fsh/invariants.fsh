////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-should-be-omitted
Description: "SHOULD be omitted for data minimization."
Expression:  "$this.length() = 0"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-shall-be-resource-uri
Description: "IDs SHALL use resource:# format"
Expression:  "$this.matches('^resource:[0-9]+$')"
Severity:    #error