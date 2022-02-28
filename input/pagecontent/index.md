### Summary

[SMART Health Cards] (SHCs) focus on sharing "immutable clinical facts" like the record of a specific vaccine dose or lab result. Our data models have been designed to balance information content (i.e., details that a verifier needs in order to make a decision) with user privacy (i.e., to avoid over-sharing, and to avoid sharing sensitive information).

Beyond simply requiring proof of vaccination or lab results, some jurisdictions are developing policies that assign an "exemption" status to individuals who can't or shouldn't or otherwise won't receive a vaccine. There is interest in developing an interoperable way to share these exemption details with verifiers.

<span class="label label-danger">Please Note</span> **Conveying "exemption status" is beyond the [SMART Health Cards] design intent.** Additionally, conveying the clinical (or other relevant) facts behind an exemption raises significant privacy concern. As some jurisdictions may wish to move ahead in this space, [VCI](https://vci.org) has developed this [FHIR Implementation Guide](https://www.hl7.org/fhir/implementationguide.html) (IG) to describe the relevant policy and technical considerations.

----

### Policy considerations

#### Utility in differentiating between exemptions and "not vaccinated"

Vaccination policies vary widely by jurisdiction. Exemption policies will vary even more widely. A key policy question is whether an "exempt" individual is treated differently from an otherwise-unvaccinated individual. For example, does a "vaccine exempt" individual have more lenient testing or quarantine requirements (compared with an otherwise-unvaccinated individual) upon arrival at a travel destination? In real-world travel use cases, the answer has been predominantly "no" (with a strong basis in public health and risk mitigation, when "exempt" does not imply lower-risk).

<span class="label label-success">Policy Recommendation</span> For international travel, an interoperable approach to exemptions may not be needed.

#### Utility in differentiating among reasons for exemption

In jurisdictions designing exemption policies, there are various potential reasons for an exemption. A key policy question is whether an individual is treated differently based on the *nature* of the exemption. For example, a jurisdiction might provide exemptions for reasons as diverse as:

* Life-threatening allergic reaction to COVID vaccine
* Disabilities that make vaccination difficult
* Participation in a research trial where an experimental vaccine may have already been given
* Membership in a religious community that does not permit vaccination
* *(etc, etc)*

<span class="label label-success">Policy Recommendation</span> Convey the most general exemption status that meets real-world needs. Typically this will be a general "is exempt" status without any specifics, or one of the limited list of more specific statuses listed below (in short: medical or vaccine not available). Other categories of exemptions (e.g., religious or philosophical) should be grouped into the generic `vaccination-exemption` type of exemption.

While policy differences may make interoperability across jurisdictions a challenge, there are general cases where more specificity than a generic "all exemptions" type has utility. For example, if Jurisdiction A allows for both medical and non-medical exemptions while Jurisdiction B only allows for medical exemptions, then if these two jurisdictions wish to coordinate to allow for mutual reciprocity of exemptions, Jurisdiction A would need to differentiate between the two types of exemptions. Jurisdiction A should do this by using a "medical exemption" (e.g., `medical-vaccination-exemption`) type for medical exemptions, and a generic type (e.g., `vaccination-exemption`) for all other exemption reasons.

#### Preserving privacy: why treat exemptions differently?

The data associated with a COVID-19 vaccine or lab results are relatively well-understood and generally non-sensitive in the context of a global pandemic response. So for vaccine and lab result verification, SMART Health Cards mitigates the challenge of managing different policies in different jurisdictions by conveying the raw *inputs* to these policies (e.g., "negative COVID PCR test on 2021-10-08"), rather than high-level conclusions (e.g., "is save to travel until 2021-10-10"). Even so, VCI has been very careful to produce data models that minimize the information shared in a SMART Health Card vaccine or lab result. The flexibility gained by sharing "raw" inputs in non-privacy-sensitive domains like COVID-19 vaccines lab results is a good trade-off.

When it comes to exemptions, the privacy analysis is much more challenging: some reasons for an exemption may be quite sensitive and outside the scope of information generally shared in the context of everyday life. Public health policy should not put individuals in a situation where they are asked to share information about their behavior problems, religious affiliation, research participation (etc.) in the course of everyday life.

*Note: It doesn't help to use an "unpublished data dictionary" with opaque codes for the different exemption reasons; the community will (and should!) tear apart their QRs, compare them, and reverse engineer the data dictionary in short order.*

<span class="label label-warning">Technical Recommendation</span> SMART Health Cards should represent exemptions as a broad category, rather than naming the specific condition that is the cause for an exemption. These categories should be no more specific than "medical exemption" or "vaccine not available", and in some cases a generic "vaccination exemption" status will be sufficient.

#### Managing exemption policies that can change over time

One challenge of managing exemption policies is that they will evolve over time, and may evolve differently in different jurisdictions. A helpful approach here is to have specific policy identifiers (URLs) so policies can be versioned and can evolve over time.

<span class="label label-success">Policy Recommendation</span> To promote reuse and streamline workflows, policies should be aggregated at the highest level possible. National-level exemption policies are a good near-term target in places where vaccine exemptions are an important part of the verification workflow.

Whatever the level of policy aggregation, an Exemption represented in a SMART Health Card should be able to point at the policy behind it.

<span class="label label-warning">Technical Recommendation</span> SMART Health Cards should represent exemptions by reference to a versioned or dated policy document that's openly published on the web in human-readable form.

Unlike vaccination and testing results (where the clinical data includes effective dates that a verifier can use in evaluating a person against published criteria such as a definition of "fully vaccinated" or "recently tested"), exemptions are by nature variable. Some are short-lived and some are long-lived, and you don't always know how long-lived -- e.g.,

* "allergic to all COVID-19 vaccines" may change when new vaccines are introduced into the market
* "participating in a research study" may change when a participant withdraws, or when  the study ends

<span class="label label-success">Policy Recommendation</span> To allow for policy revisions, any exemptions issued should be time-limited, and the duration should be based on the use case driving issuance (not based on or revealing the specific cause of the exemption).

<span class="label label-warning">Technical Recommendation</span> SMART Health Cards should represent exemptions with an `exp` ("expires at") timestamp, populated with a consistent issuer-supplied interval.

----

### Technical recommendations

#### Actors

The primary actors in the typical SHC workflow are:

1. **Issuers** who produce the FHIR resources described in this IG.
1. **Holders** who receive a [SMART Health Card] from an Issuer (which contains the FHIR resources described in this IG), and may display it to a Verifier.
1. **Verifiers** who read and analyze the FHIR resources described in this IG.

Issuers and Verifiers are considered "implementers" of this IG. Additionally, "wallet applications" used by Holders to store digital versions of their SHC are also considered implementers.

#### Use Cases

The primary focus of this IG is representing the minimal set of data necessary to represent vaccination exemptions for verification purposes in a SMART Health Card. To meet these use cases, we provide profiles of a [FHIR Bundle](https://www.hl7.org/fhir/bundle.html) that describes the contents of [the `fhirBundle` element in a SMART Health Card](https://spec.smarthealth.cards/#data-model). We also identify profiles of the resources contained within this Bundle.

##### Use case 1: Uniform Exemption

A jurisdiction only issues generic exemptions from vaccines, without the need to identify the reason for the exemption.

##### Use case 2: Specific Exemption Types

A jurisdiction issues different types of exemptions from vaccines like medical or accessibility constraints that prevent vaccination and needs to identify which exemption an individual holds.

These types of exemptions may include:

- **Generic** (`vaccination-exemption`): An exemption that is issued to any patient that requires one, regardless of the reason or intent for obtaining an exemption.
* **Medical** (`medical-vaccination-exemption`): An exemption that is issued to a patient with a medical reason that prevents them from receiving a vaccination, such as contraindications or safety concerns based on the patient's medical history. The exact medical reason for the exemption SHALL NOT be documented in the SHC Exemption to protect patient privacy.
- **Vaccine not available** (`vaccine-not-available`): An exemption that is issued to a patient who is unable to access vaccination services, most likely due to accessibility or availability challenges.

##### Out of scope

This IG SHALL NOT be used for:

- Use cases in which another more specific SHC could be used; an exemption is not intended to replace other SHCs.
- To indicate current or prior infection with the same disease for which a SHC could be issued. A lab test result or antibody titer lab test should be used if available.
- Medical conditions that are not related to the infectious disease documented in the SHC in a way that identifies the condition.

#### Privacy by design

As mentioned above, the [SHC specification](https://spec.smarthealth.cards) is focused on facilitating the sharing of digitally signed "immutable clinical facts," such as the record of a specific vaccine dose or lab result.

SHCs accomplish this by balancing information content (i.e., details that a verifier needs in order to make a decision) with user privacy (i.e., to avoid over-sharing, and to avoid sharing sensitive information). For example, the [SHC: Vaccination & Testing IG](https://vci.org/ig/vaccination-and-testing) includes the following section:

<div class="well" markdown="1">
**Privacy by design**

Special attention is payed in this IG to protecting the privacy of Holders.

The design of the SMART Health Card specification results in the following characteristics of issued SMART Health Cards:

1. The contents cannot be changed (without re-issuing the entire SMART Health Card).
2. The entirety of the data within the SMART Health Card is transmitted from the Holder to the Verifier whenever a SMART Health Card is presented.

**Therefore, information that is not strictly necessary for a legitimate Verifier use case SHALL NOT be included in SMART Health Cards.**
</div>

We recommend that **to preserve patient privacy, information that is not necessary for Verifiers *SHALL NOT* be included in SMART Health Cards.** If sensitive information were included in a SMART Health Card, it cannot be removed by the patient without invalidating the SMART Health Card,[^signature] and this information would be exposed to the Verifier anytime the patient presented their SMART Health Card. It is therefore critical for Issuers to exclude any information that could represent a privacy risk to a patient when presenting their SMART Health Card to a Verifier.

[^signature]: Once a SMART Health Card is issued, it is not possible to remove or edit any of the included information without without invalidating the [cryptographic signature](https://spec.smarthealth.cards/#signing-health-cards), which will cause the SMART Health Card to be flagged as invalid by verification apps.

#### Size constraints

The SMART Health Cards Framework constrains the size of the FHIR payload embedded within a SMART Health Card to allow the entirety of the SMART Health Card to fit within [a single Version 22 QR code](https://spec.smarthealth.cards/#chunking). This IG is designed to support creating resources that fit within these size constraints. (While it is possible to generate a [denser QR code](https://www.qrcode.com/en/about/version.html), the [SMART Health Cards Framework] developers found that denser QR codes could be difficult to scan.) SMART Health Card payloads are compressed, so the precise number of available uncompressed bytes for the embedded FHIR Bundle is not knowable (the compression ratio depends on the specific content being compressed).

#### Additional Technical Recommendations

1. Model vaccine exemptions with an `exp` claim for some fixed time interval (e.g., a month from the time of issuance) to mitigate the effects of policy changes.
1. Model vaccine exemptions with a top-level `https://smarthealth.cards#exemption` type
1. Model vaccination exemptions with a FHIR `Condition` resource where `.category` is populated and `.code` is not.
1. Model `Condition.category` with a FHIR Coding that includes
    * `system`:  Public URL of a jurisdictional policy.
        * E.g. `https://travel.gc.ca/travel-covid/travel-restrictions/exemptions`
    * `code`: Fixed value independent of exemption *reason* (or at most differentiating between medical, vaccine not available, or general exemptions)
      * e.g., `vaccination-exemption`, `medical-vaccination-exemption`, or `vaccine-not-available`
    * `version`: Date of most recent update to the policy at time of issuance.
      * E.g. `2021-10-08`
1. Model `Condition.recordedDate` as an optional field
1. Model `Condition.recorder.display` as an optional field

#### Example JWS Payload (annotated with comments)

```js
{
  "iss": "https://spec.smarthealth.cards/examples/issuer",
  "nbf": 1633642949,
  "exp": 1634247749,
  // ^^ This expiration time is one week later than
  // the issuance (nbf) time, so the credential lives
  // for a limited duration.
  "vc": {
    "type": [
      "https://smarthealth.cards#health-card",
      "https://smarthealth.cards#covid19",
      "https://smarthealth.cards#exemption"
    ],
    "credentialSubject": {
      "fhirVersion": "4.0.1",
      "fhirBundle": {
        "resourceType": "Bundle",
        "type": "collection",
        "entry": [
          {
            "fullUrl": "resource:0",
            "resource": {
              "resourceType": "Patient",
              "name": [
                {
                  "family": "Anyperson",
                  "given": [
                    "John",
                    "B."
                  ]
                }
              ],
              "birthDate": "1951-01-20"
            }
          },
          {
            "fullUrl": "resource:1",
            "resource": {
              "resourceType": "Condition",
              "category": [
                {
                  "coding": [
                    {
                      "system": "https://travel.gc.ca/travel-covid/travel-restrictions/exemptions",
                      // ^^ URL to a jurisdiction's public policy
                      "code": "vaccination-exemption",
                      // ^^ String indicating exemption; SHOULD be from VaccinationExemptionValueSet
                      "version": "2021-10-06"
                      // ^^ from the policy web page's "last modified" date
                    }
                  ]
                }
              ],
              "subject": {
                "reference": "resource:0"
              },
              "recordedDate": "2021-06-20",
              // ^^ Optional date of initial recording, while
              // the top-level JWS `nbf` and `exp` are required
              "recorder": {
                "display": "Province of Quebec"
                // ^^ Optional, if conveying a recorder is important
              }
            }
          }
        ]
      }
    }
  }
}
```

##### Example QR

<div><img src="https://hackmd.io/_uploads/Sk9WG404Y.png" style="max-width: 600px;"></div>

{% include markdown-link-references.md %}

<script>
// Move Markdown TOC below well
/*
var ref = document.querySelector('.well');
var el = document.querySelector('div.markdown-toc');
ref.parentNode.insertAfter(el, ref);
*/
</script>