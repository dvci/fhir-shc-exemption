////////////////////////////////////////////////////////////////////////////////////////////////////

RuleSet: common-bundle-rules

* id ^short = "Should be omitted"
* id ^definition = "It is not necessary to provide an `id` for Bundles profiled in this IG. This element SHOULD be omitted for data minimization reasons."
* id ^comment = "n/a"
* id obeys vc-should-be-omitted

* type  = #collection
* type MS
* entry ^slicing.discriminator.type = #type
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #closed
* entry ^slicing.description = "Slicing based on the profile conformance of the entry"
* entry and entry.resource MS

* insert id-should-not-be-populated(entry.)

RuleSet: common-bundle-dm-rules

* id 0..0
* identifier 0..0
* meta 0..0
* timestamp 0..0
* implicitRules 0..0
* language 0..0
* total 0..0
* link 0..0
* signature 0..0

RuleSet: bundleSliceDM(sliceName)
* entry[{sliceName}].id 0..0
* entry[{sliceName}].extension 0..0
* entry[{sliceName}].modifierExtension 0..0
* entry[{sliceName}].link 0..0
* entry[{sliceName}].search 0..0
* entry[{sliceName}].request 0..0
* entry[{sliceName}].response 0..0

* entry[{sliceName}].fullUrl 1..1
* entry[{sliceName}].fullUrl MS
* entry[{sliceName}].fullUrl ^short = "Locally unique identifier like resource:0"
* entry[{sliceName}].fullUrl ^definition = "Identifier for the contained resource that is locally unique within this Bundle. The identifier SHALL use `resource:#` format, where `#` is an integer incremented from 0 to _n_ within the Bundle."
* entry[{sliceName}].fullUrl ^comment = "n/a"
* entry[{sliceName}].fullUrl obeys vc-shall-be-resource-uri

RuleSet: bundleDM
// These have to come afterwards or the slice-specific constraints aren't applied
* entry.id 0..0
* entry.extension 0..0
* entry.modifierExtension 0..0
* entry.link 0..0
* entry.search 0..0
* entry.request 0..0
* entry.response 0..0

* entry.fullUrl 1..1
* entry.fullUrl MS
* entry.fullUrl ^short = "Locally unique identifier like resource:0"
* entry.fullUrl ^definition = "Identifier for the contained resource that is locally unique within this Bundle. The identifier SHALL use `resource:#` format, where `#` is an integer incremented from 0 to _n_ within the Bundle."
* entry.fullUrl ^comment = "n/a"


RuleSet: bundleSliceAD(sliceName)
* entry[{sliceName}].fullUrl 1..1
* entry[{sliceName}].fullUrl MS
* entry[{sliceName}].fullUrl ^short = "Locally unique identifier like resource:0"
* entry[{sliceName}].fullUrl ^definition = "Identifier for the contained resource that is locally unique within this Bundle. The identifier SHALL use `resource:#` format, where `#` is an integer incremented from 0 to _n_ within the Bundle."
* entry[{sliceName}].fullUrl ^comment = "n/a"
* entry[{sliceName}].fullUrl obeys vc-shall-be-resource-uri

RuleSet: bundleAD
// These have to come afterwards or the slice-specific constraints aren't applied
* entry.fullUrl 1..1
* entry.fullUrl MS
* entry.fullUrl ^short = "Locally unique identifier like resource:0"
* entry.fullUrl ^definition = "Identifier for the contained resource that is locally unique within this Bundle. The identifier SHALL use `resource:#` format, where `#` is an integer incremented from 0 to _n_ within the Bundle."
* entry.fullUrl ^comment = "n/a"

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: SHCVaccinationExemptionBundleFallback
Parent: Bundle
Id: shc-vaccination-exemption-bundle-fallback
Title: "Vaccination Exemption Bundle - Fallback"
Description: "The bundle of resources that represents the patient identification and clinical content of a SMART Health Card for a vaccination exemption."

* insert common-bundle-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    patient 1..1 MS and
    exemption 1..* MS // and
    // vaccineReaction 0..*

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only shc-patient-general-ad
* entry[patient].resource 1..1
* insert bundleSliceAD(patient)


* entry[exemption] ^short = "Exemption"
* entry[exemption] ^definition = "Exemption"
* entry[exemption].resource only SHCVaccinationExemptionFallbackProfile
* entry[exemption].resource 1..1
* insert bundleSliceAD(exemption)

////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////