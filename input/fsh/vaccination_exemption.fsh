Profile: SHCVaccinationExemptionFallbackProfile
Id: shc-vaccination-exemption-fallback-profile
Parent: Condition
Title: "Vaccination Exemption Profile - Fallback"
Description: "Profile for representing an exemption from vaccination."

* category.coding.system 1..1 MS
* category.coding.code = #vaccination-exemption
* category.coding.version 1..1 MS

* subject 1..1 MS