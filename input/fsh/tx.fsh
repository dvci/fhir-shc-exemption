CodeSystem: VaccinationExemptionCodeSystem
Id: vaccination-exemption-code-system
Title: "Vaccination Exemption Code System"
Description: "Codes representing vaccination exemptions"
* #vaccination-exemption "Generic vaccination exemption"
* #medical-vaccination-exemption "Medical vaccination exemption"
* #vaccine-not-available "The vaccine was not available for the patient"

ValueSet: VaccinationExemptionValueSet
Id: vaccination-exemption-value-set
Title: "Vaccination Exemption Value Set"
Description: "Value set of codes representing vaccination exemptions"
* include codes from system VaccinationExemptionCodeSystem