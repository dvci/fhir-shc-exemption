////////////////////////////////////////////////////////////////////////////////////////////////////

CodeSystem: VaccinationExemptionCodeSystem
Id: vaccination-exemption-code-system
Title: "Vaccination Exemption Code System"
Description: "Code system to indicate which type of vaccination exemption an individual received."

* #medical-vaccination-exemption "An exemption that is issued to a patient with a medical reason that prevents them from receiving a vaccination. The exact medical reason SHALL NOT be documented in the SHC Exemption to protect patient privacy."
* #religious-vaccination-exemption "An exemption that is issued to a patient with a genuinely held religious ideology that prevents them from receiving a vaccination. The exact religious faith SHALL NOT be documented in the SHC Exemption to protect patient privacy."
* #vaccine-not-available-exemption "An exemption that is issued to a patient who is unable to access vaccination services, most likely due to accessibility challenges or supply shortages in an area."



ValueSet:    VaccinationExemption
Id:          vaccination-exemption
Title: "Vaccination Exemption Codes"
Description: "Codes to indicate which type of vaccination exemption an individual received."

* include codes from system VaccinationExemptionCodeSystem

////////////////////////////////////////////////////////////////////////////////////////////////////
