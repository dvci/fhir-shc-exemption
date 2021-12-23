
Profile: SHCVaccinationExemptionFallbackProfile
Id: shc-vaccination-exemption-fallback-profile
Parent: Observation
Title: "Vaccination Exemption Profile - Fallback"
Description: "Profile for representing an exemption from vaccination."

* code.coding.system 1..1 MS
* code.coding.system ^short = "Public URL of jurisdictional policy"
* code.coding.system ^definition = "Public URL of jurisdictional policy. Issuers SHALL include a single URL that outlines the relevant exemption policies."

* code.coding.code = #vaccination-exemption
* code.coding.code ^short = "Fixed value independent of exemption reason"

* code.coding.version 1..1 MS
* code.coding.version ^short = "Date of the most recent exemption policy change at the time of issuance"

* subject 1..1 MS


Profile: SHCVaccinationExemptionPrimaryProfile
Id: shc-vaccination-exemption-primary-profile
Parent: Observation
Title: "Vaccination Exemption Profile - Primary"
Description: "Profile for representing an exemption from vaccination."

* code.coding.system 1..1 MS
* code.coding.system ^short = "Public URL of jurisdictional policy"
* code.coding.system ^definition = "Public URL of jurisdictional policy. Issuers SHALL include a single URL that outlines the relevant exemption policies."

* code.coding.code = #vaccination-exemption
* code.coding.code ^short = "Fixed value independent of exemption reason"

* code.coding.version 1..1 MS
* code.coding.version ^short = "Date of the most recent exemption policy change at the time of issuance"

* subject 1..1 MS