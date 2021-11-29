# shcExemption

<!-- Feel free to modify this index page with your own awesome content! -->

## DRAFT

### Smart Health Card Exemptions

Jurisdictions may decide to distribute formal vaccination exemptions to individuals that can be used similarly to a [SMART Health Card] to show proof of their vaccination status. Individuals could use this digital copy of their exemption status, and the broad cateogrical reason for their exemption if necessary, for travel or...

A SMART Health Card Exemption contains only the information necessary to indicate an indivdiual's vaccination status. 

    * Information Included and Displayed:
        * Name
        * Date of Birth
        * Exemption Status
        * Expiration Date/Status: This IG is not designed for lifetime exemptions. Exemptions must expire within 365 days, after which the individual can reobtain an exemption if the jurisdication issuing exemptions wishes to re-issue an exemption.

### Scope

This [FHIR Implementation Guide](https://www.hl7.org/fhir/implementationguide.html) (IG) describes the clinical information necessary to create a [SMART Health Card] identifying vaccination exemptions for infectious diseases such as [COVID-19](https://www.cdc.gov/coronavirus/2019-ncov/index.html).

**The goal of this IG is to define the conformance criteria of FHIR resources for use specifically in [SMART Health Cards] exemptions.** This IG is not applicable to general-purpose FHIR endpoints like `[base]/Patient/:id/Immunization`, nor is it meant to describe the canonical representation of clinical data in electronic health record systems; these are governed by other IGs like [US Core](https://www.hl7.org/fhir/us/core/StructureDefinition-us-core-immunization.html).

Note that this IG is not directly related to the [SMART App Launch Framework](http://www.hl7.org/fhir/smart-app-launch/). The name comes from [SMART Health IT](https://smarthealthit.org/), who also developed the [SMART Health Card] framework that this IG supports. SMART App Launch and SMART Health Cards are designed to work well together (the former being one of multiple methods for issuing the latter), but they don't have a hard dependency with each other.

### Actors

The primary actors are:

1. **Issuers** who produce the FHIR resources described in this IG. These may be the entities responsible for giving vaccinations or reporting laboratory results, including health systems, pharmacies, clinical labs, and doctors offices.
1. **Holders** who receive a [SMART Health Card] from an Issuer (which contains the FHIR resources described in this IG), and may display it to a Verifier.
1. **Verifiers** who read and analyze the FHIR resources described in this IG.

Issuers and Verifiers are considered "implementers" of this IG.


### Use Cases

Our primary focus is on the use case of representing the minimal set of clinical data necessary to represent vaccination exemptions for verification purposes in a SMART Health Card. To meet these use cases, we provide profiles of a [FHIR Bundle](https://www.hl7.org/fhir/bundle.html) that describes the contents of [the `fhirBundle` element in a SMART Health Card](https://spec.smarthealth.cards/#data-model). We also provide profiles of the resources contained within this Bundle.

The SMART Health Cards Framework constrains the size of the FHIR payload embedded within a SMART Health Card to allow the entirety of the SMART Health Card to fit within [a single Version 22 QR code](https://spec.smarthealth.cards/#chunking). This IG is designed to support creating resources that fit within these size constraints. (While it is possible to generate a [denser QR code](https://www.qrcode.com/en/about/version.html), the [SMART Health Cards Framework] developers found that denser QR codes could be difficult to scan.) SMART Health Card payloads are compressed, so the precise number of available uncompressed bytes for the embedded FHIR Bundle is not knowable (the compression ratio depends on the specific content being compressed). In practice, we have found that bundles of resources conforming to the [data minimization profiles](profiles.html#data-minimization) in this IG do fit within the payload constraints.

Due to these size constraints and to preserve patient privacy, information that is not necessary for Verifiers SHALL NOT be included in SMART Health Cards. With respect to individuals' privacy, note that when a SMART Health Card is issued, it is [cryptographically signed](https://spec.smarthealth.cards/#signing-health-cards) by the Issuer. This means that the contents, including the FHIR Bundle, cannot be changed without invalidating the signature. It is therefore critical for Issuers to exclude any information that could represent a privacy risk to a patient when presenting their SMART Health Card to a Verifier.

**Types of Exemptions:**

    * Generic: An exemption that is issued to any patient that requires one, regardless of the reason or intent for obtaining an exemption.
    * Medical: An exemption that is issued to a patient with a medical reason that prevents them from receiving a vaccination. The exact medical reason SHALL NOT be documented in the SHC Exemption to protect patient privacy.
    * Religious: An exemption that is issued to a patient with sincerely held religious beliefs that prevent them from receiving a vaccination. The exact religion SHALL NOT be documented in the SHC Exemption to protect patient privacy.
    * Vaccine-Not-Available: An exemption that is issued to a patient who is unable to access vaccination services, most likely due to accessibility or availability challenges.

#### Use case 1: Uniform Exemption

A jurisdiction only issues generic exemptions from vaccines, without the need to identify the reason for the exemption.

#### Use case 2: Specific Exemption Types

A jurisdiction issues different types of exemptions from vaccines like medical, religious, or accessibility contraints that prevent vaccination and needs to identify which exemption an individual holds.

### Innappropriate Use Cases for Exemptions

An exemption SHALL NOT be used for:
    * An instance in which another more specific SHC could be used; an exmeption is not intended to replace other SHCs
    * To indicate current or prior infection with the same disease for which a SHC could be issued. A lab test result or antibody titer lab test should be used if available
    * Medical conditions that are not related to the infectious disease documented in the SHC in a way that identifies the condition


### Example Use Case and Implementation

Province A's Health Department issues two types of exemptions: medical and vaccine-not-available. The dep need to differentiate between the two in SHC's. 

**Place Holder** 

### Terminology Bindings

This IG uses [extensible binding](http://hl7.org/fhir/r4/valueset-binding-strength.html), meaning the concept in this element SHALL be from the specified value set if any of the codes within the value set can apply to the concept being communicated. If the value set does not cover the concept (based on human review), alternate codings (or, data type allowing, text) may be included instead.

This degree of strength was selected to maintain as much uniformity across exemption developers as posisble, while still allowing flexibility to accommodate local requirements for vaccination exemptions.

### Author Contact Information

This FHIR Implementation Guide was initially developed by [VCI](https://vci.org), and is currently [an HL7 project](https://confluence.hl7.org/display/PHWG/SMART+Health+Cards+-+Vaccination+and+Testing+IG+Project+Page) sponsored by the [Public Health Work Group](https://confluence.hl7.org/display/PHWG/Public+Health+Work+Group).

Please direct questions or comments about this IG to the channels listed [here](contact.html).

----
