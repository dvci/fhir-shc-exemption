## SMART Health Card Exemptions

Please note that **conveying "vaccination exemption status" is beyond the [SMART Health Cards] (SHCs) design intent.** However, some jurisdictions may wish to pursue an formal exemption option for their constituents. [VCI](https://vci.org) has developed this [FHIR Implementation Guide](https://www.hl7.org/fhir/implementationguide.html) (IG) to describe the relevant policy and technical considerations.

<br>

### SHC design principles

The [SHC specification](https://spec.smarthealth.cards) is focused on facilitating the sharing of digitally signed "immutable clinical facts," such as the record of a specific vaccine dose or lab result.

SHCs accomplish this by balancing information content (i.e., details that a verifier needs in order to make a decision) with user privacy (i.e., to avoid over-sharing, and to avoid sharing sensitive information). For example, the [SHC: Vaccination & Testing IG](https://vci.org/ig/vaccination-and-testing) includes the following section:

<div class="well" markdown="1">

##### Privacy by design

Special attention is payed in this IG to protecting the privacy of Holders.

The design of the SMART Health Card specification results in the following characteristics of issued SMART Health Cards:

1. The contents cannot be changed (without re-issuing the entire SMART Health Card).
2. The entirety of the data within the SMART Health Card is transmitted from the Holder to the Verifier whenever a SMART Health Card is presented.

**Therefore, information that is not strictly necessary for a legitimate Verifier use case SHALL NOT be included in SMART Health Cards.**

For more information, please see [the data minimization and privacy section on the Profiles page](profiles.html#data-minimization-and-privacy).
</div>

A SMART Health Card Exemption contains only the information necessary to indicate an indivdiual's vaccination status:

* Name
* Date of Birth
* Exemption Status
* Expiration Date/Status: This IG is not designed for lifetime exemptions. Exemptions must expire within 365 days, after which the individual can reobtain an exemption if the jurisdication issuing exemptions wishes to re-issue an exemption.

<br>

### Actors

In order to describe these considerations, it is necessary to first establish the primary actors in the typical SHC workflow:

1. **Issuers** who produce the FHIR resources described in this IG.
1. **Holders** who receive a [SMART Health Card] from an Issuer (which contains the FHIR resources described in this IG), and may display it to a Verifier.
1. **Verifiers** who read and analyze the FHIR resources described in this IG.

Issuers and Verifiers are considered "implementers" of this IG. Additionally, "wallet applications" used by Holders to store digital versions of their SHC are also considered implementers.

<br>

### Policy Considerations

**Do vaccination exemption SHCs provide utility to these actors?**

A key policy question is whether an "exempt" individual is treated differently from an otherwise-unvaccinated individual. For example, does a "vaccination exempt" individual have more lenient testing or quarantine requirements (compared with an otherwise-unvaccinated individual) upon arrival at a travel destination? If not, then the vaccination exemption SHC will not provide utility to the actors in the SHC workflow.

If "vaccination exempt" individuals are treated differently, does the type of exemption that individual qualifies for (medical, religious, or accessility-based) have an impact on what they can or cannot do? If the type of exemption does not matter, then the jurisdiction may need to consider if they should issue specific types of exemptions for the purpose of interoperability or a singular, blanket exemption.

For example, for real-world COVID-19 travel use cases, the answer to whether exempt individuals are treated differently than non-exempt, unvaccinated individuals has been "no" (with a strong basis in public health and risk mitigation, when "exempt" does not imply lower-risk).

For other vaccines required for travel, the answer may be "yes".

<div class="well" markdown="1">

Recommendation: Policymakers should consider the utility of issuing vaccination exemption SHCs by asking whether unvaccinated individuals with an exemption would have different access to travel or public spaces than those without an exemption.

</div>

<br>

### Interoperability Considerations

**Is interoperability between jurisdictions realistic?**

The two, primary interoperability concerns are:

1. Policy interoperability, meaning that a vaccination exemption SHC produced in Jurisdiction A is actionable in Jurisdiction B.
1. Technical interoperability, meaning that Jurisdiction B can computably read/understand a vaccination exemption SHC produced by an Issuer in Jurisdiction A.

Due to variation in vaccination exemption policies, it is unlikely that jurisdictions will achieve policy interoperability without significant coordination. There is therefore not a use case for a universally interoperable vaccination exemption SHC in the absence of such coordination, and the specifics of vaccination exemption policy are beyond the scope of this IG.

<span style="color:red"> @Max there's more on policy interoperability below. I debated on where to place it. I think we could either move it up here or link to it below... </span>

Technical interoperability may be achieved by mutual agreement to follow the technical approach described below.

**Is interoperability between actors necessary?**

Yes. For example, wallet applications used by Holders must understand how to read/display vaccination exemption SHCs to facilitate the presentation of these SHCs by the holders. Likewise, Verifiers must know what to expect in a vaccination exemption SHC so they are prepared to read and understand the contents of the SHC.

Note: There is a robust ecosystem of software for issuing, holding, validating, and verifying SHCs for vaccination status and lab test results. There is not (yet) such an ecosystem for vaccination exemption SHCs, and such an ecosystem cannot develop without an open standard describing how these SHCs are constructed. Without this ecosystem, jurisdictions implementing vaccination exemption SHCs will need to provide the technology for all actors themselves. Therefore, even without policy interoperability, there are benefits to all implementing jurisdictions in achieving technical interoperability so a software ecosystem can develop.


<div class="well" markdown="1">

Recommendation: Jurisdictions should follow the technical approach described in this IG to ensure technical interoperability.

</div>

**Should vaccination exemption SHC include the underlying reason for the exemption?**

SHCs were originally designed to communicate COVID-19 vaccination or lab results, which are relatively well-understood and generally non-sensitive in the context of a global pandemic response. So for vaccine and lab result verification, SHCs mitigate the challenge of managing different vaccination/testing policies in different jurisdictions by conveying the raw *inputs* to these policies (e.g., "negative COVID PCR test on 2021-10-08"), rather than high-level conclusions (e.g., "is safe to travel until 2021-10-10"). Even so, VCI has been very careful to produce data models that minimize the information shared in a SMART Health Card vaccine or lab result. The flexibility gained by sharing "raw" inputs in non-privacy-sensitive domains like COVID-19 vaccinations and lab results is a good trade-off.

When it comes to exemptions, the privacy analysis is much more challenging: some reasons for an exemption may be quite sensitive and outside the scope of information generally shared in the context of everyday life. Public health policy should not put individuals in a situation where they are asked to share information about their behavior challenges, religious affiliation, research participation, etc. in the course of everyday life.

*Note: It doesn't help use an "unpublished data dictionary" with opaque codes for the different exemption reasons; given the scope of adoption of SHCs, any obfuscated information will inevitably be reverse engineered and de-obfuscated.*

<div class="well" markdown="1">

Recommendation: SMART Health Cards should represent exemptions as the broad categories listed above, rather than naming the specific condition that is the cause for an exemption.

</div>


### Reasons for Exemptions and Why They Should Be Included

Jurisdictions designing exemption policies may have various reasons for issuing exemptions to some of their population. A key policy question is whether an individual is treated differently based on the *nature* of the exemption and whether an exemption will be recognized in another jurisdiction. For example, jurisdiction could provide exemptions for reasons as diverse as:

* Life-threatening allergic reaction to COVID vaccine
* Behavior challenges that make vaccination difficult
* Participation in a research trial where an experimental vaccine may have already been given
* Membership in a religious community that does not permit vaccination
* *(etc.)*

Current policies for travel or participation in public gatherings do not differentiate treatment of individuals based on their exemption reason, meaning that the only information a verifier needs to know is, "does this individual have an exemption".

An important consideration though, is whether an exemption will be recognized in another jurisdiction that does not accept the same variety of exemptions. For example, within the United States there are 6 states that do not recognize religious exemptions from vaccinations to attend public schools. There are 35 states that do not accept philosophical exemptions from vaccinations to attend public schools or day cares. (https://www.ncsl.org/research/health/school-immunization-exemption-state-laws.aspx)

A general exemption issued in Michigan may not be recognized in neighboring Indiana because Michigan allows both religious and philosophical exemptions, while Indiana only accepts religious exemptions. If the exemption does not denote that they received a religious exemption rather than a philosophical one, which is note recognized in Indiana, it may make their exemption and anyone else's from a state with similar policies void. 

But policies change over time. A helpful approach here is to have specific policy identifiers (URLs) so policies can be versioned and can evolve over time.

:::info
:arrow_right: To promote reuse and streamline workflows, policies should be aggregated at the highest level possible. National-level exemption policies are a good near-term target in places where vaccine exemptions are an important part of the verification workflow.
:::

Whatever the level of policy aggregation, an Exemption represented in a SMART Health Card should be able to point at the policy behind it.

:::success
:bulb: SMART Health Cards should represent exemptions by reference to a versioned or dated policy document that's openly published on the web in human-readable form.
:::

To balance the need to protect individual privacy, public health, and interoperability, this implementation guide allows for three types of exemptions:

* Medical: An exemption that is issued to a patient with a medical reason that prevents them from receiving a vaccination. The exact medical reason SHALL NOT be documented in the SHC Exemption to protect patient privacy.
* Religious: An exemption that is issued to a patient with sincerely held religious beliefs that prevent them from receiving a vaccination. The exact religion SHALL NOT be documented in the SHC Exemption to protect patient privacy.
* Vaccine-Not-Available: An exemption that is issued to a patient who is unable to access vaccination services, most likely due to accessibility or availability challenges.

<br>

### Innappropriate Use Cases for Exemptions

An exemption SHALL NOT be used for:

* An instance in which another more specific SHC could be used; an exmeption is not intended to replace other SHCs
* To indicate current or prior infection with the same disease for which a SHC could be issued. A lab test result or antibody titer lab test should be used if available
* Medical conditions that are not related to the infectious disease documented in the SHC in a way that identifies the condition

<br>

### Implementation

There are two possible approaches to modeling a vaccination exemption:

1. Provide the medical condition(s) responsible for the exemption
2. Provide a generic medical exemption without condition-specific details

While (1) is technically possible, it make put Holders in a position where they have to disclose a sensitive medical condition (e.g. pregnancy) to a Verifier in order to use their exemption. The second approach is therefore preferable.

Unlike vaccination and testing results (where the clinical data includes effective dates that a verifier can use in evaluating a person against published criteria such as a definition of "fully vaccinated" or "recently tested"), exemptions are by nature variable. Some are short-lived and some are long-lived, and you don't always know how long-lived -- e.g.

* "allergic to all COVID-19 vaccines" may change when new vaccines are introduced into the market
* "participating in a research study" may change when a participant withdraws, or when  the study ends

:::info
:arrow_right: To allow for policy revisions, any exemptions issued should be time-limited, and the duration should be based on the use case driving issuance (not based on or revealing the specific cause of the exemption).
:::

:::success
:bulb: SMART Health Cards should represent exemptions with an `exp`  ("expires at") timestamp, populated with a consistent issuer-supplied interval.
:::

<br>

### Technical Recommendations


1. Model vaccine exemptions with an `exp` claim for some fixed time interval (e.g., a month from the time of issuance) <span style="color:red">(are we leaving exp length open to jurisdictions?) </span> to mitigate the effects of policy changes.
1. Model vaccine exemptions with a top-level `https://smarthealth.cards#exemption` type
2. Model vaccination exemptions with a FHIR `Condition` resource where `.category` is populated and `.code` is not.
3. Model `Condition.category` with a FHIR Coding that includes
    * `system`:  Public URL of a jurisdictional policy.
        * E.g. `https://travel.gc.ca/travel-covid/travel-restrictions/exemptions`
    * `code`: Fixed value independent of exemption *reason*
      * e.g., `vaccine-exemption`
    * `version`: Date of most recent update to the policy at time of issuance.
      * E.g. `2021-10-08`
5. Model `Condition.recordedDate` as an optional field)
5. Model `Condition.recorder.display` as an optional field

This IG uses [extensible binding](http://hl7.org/fhir/r4/valueset-binding-strength.html), meaning the concept in this element SHALL be from the specified value set if any of the codes within the value set can apply to the concept being communicated. If the value set does not cover the concept (based on human review), alternate codings (or, data type allowing, text) may be included instead.

This degree of strength was selected to maintain as much uniformity across exemption developers as posisble, while still allowing flexibility to accommodate local requirements for vaccination exemptions.

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
                      "code": "vaccine-exemption",
                      // ^^ fixed value, independenty of the exemption reason
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

#### Example QR:
![Example QR](https://hackmd.io/_uploads/Sk9WG404Y.png)


#### Relationship with SMART App Launch Framework

Note that this IG is not directly related to the [SMART App Launch Framework](http://www.hl7.org/fhir/smart-app-launch/). The name comes from [SMART Health IT](https://smarthealthit.org/), who also developed the [SMART Health Card] framework that this IG supports. SMART App Launch and SMART Health Cards are designed to work well together (the former being one of multiple methods for issuing the latter), but they don't have a hard dependency with each other.

The SMART Health Cards Framework constrains the size of the FHIR payload embedded within a SMART Health Card to allow the entirety of the SMART Health Card to fit within [a single Version 22 QR code](https://spec.smarthealth.cards/#chunking). This IG is designed to support creating resources that fit within these size constraints. (While it is possible to generate a [denser QR code](https://www.qrcode.com/en/about/version.html), the [SMART Health Cards Framework] developers found that denser QR codes could be difficult to scan.) SMART Health Card payloads are compressed, so the precise number of available uncompressed bytes for the embedded FHIR Bundle is not knowable (the compression ratio depends on the specific content being compressed). In practice, we have found that bundles of resources conforming to the [data minimization profiles](profiles.html#data-minimization) in this IG do fit within the payload constraints.

Due to these size constraints and to preserve patient privacy, information that is not necessary for Verifiers SHALL NOT be included in SMART Health Cards. With respect to individuals' privacy, note that when a SMART Health Card is issued, it is [cryptographically signed](https://spec.smarthealth.cards/#signing-health-cards) by the Issuer. This means that the contents, including the FHIR Bundle, cannot be changed without invalidating the signature. It is therefore critical for Issuers to exclude any information that could represent a privacy risk to a patient when presenting their SMART Health Card to a Verifier.

Note that SMART Health Cards are typically not meant to be the source of truth for clinical data.

<br>

<span style="color:red"> ### Author Contact Information </span>


