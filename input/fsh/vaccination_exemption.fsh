Profile: SHCVaccinationExemptionFallbackProfile
Id: shc-vaccination-exemption-fallback-profile
Parent: Condition
Title: "Vaccination Exemption Profile - Fallback"
Description: "Profile for representing an exemption from vaccination. This is a \"fallback\" profile; see [here](http://build.fhir.org/ig/HL7/fhir-shc-vaccination-ig/profiles.html) for more information about primary vs. fallback profiles."

* category from VaccinationExemptionValueSet (extensible)
* category.coding.code 1..1 MS
* category.coding.code ^short = "String indicating exemption; SHOULD be from VaccinationExemptionValueSet"
* category.coding.system 1..1 MS
* category.coding.system ^short = "URL to a web page with the jurisdiction's public policy"
* category.coding.version 1..1 MS
* category.coding.version ^short = "the \"last modified\" date or version number of the policy at the URL in `system`"

* subject 1..1 MS