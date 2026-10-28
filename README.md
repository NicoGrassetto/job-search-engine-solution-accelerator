# Job Search Engine Solution Accelerator

<h2>
  <img src=".github/assets/solution-overview.png" alt="" width="28" height="28" align="left">
  Solution Overview
</h2>

### Solution architecture

<h2>
  <img src=".github/assets/get-started.png" alt="" width="28" height="28" align="left">
  Get started
</h2>


### Azure Container Registry infrastructure

The registry defaults to the **Standard** tier with public network access enabled.
The admin account and anonymous pulls are disabled; use Microsoft Entra ID
authentication, including managed identities for applications, rather than shared
admin credentials.

Authorization uses registry-wide RBAC (`LegacyRegistryPermissions`), not
repository-level ABAC. ARM-audience authentication tokens remain accepted for
compatibility with Azure tooling, and image export is enabled. Trusted Azure
services and ACR Tasks cannot bypass network restrictions. There is no IP
allowlist; authenticated clients can reach the public endpoint from any IP.

The registry uses Microsoft-managed encryption keys and has no managed identity of
its own. Dedicated data endpoints, automatic untagged-manifest retention,
quarantine, and legacy Docker Content Trust policies are not enabled. The template
omits the legacy `zoneRedundancy` setting: Azure provides automatic zone redundancy
for all tiers in [supported regions](https://learn.microsoft.com/azure/container-registry/zone-redundancy).
No geo-replicas, diagnostic settings, webhooks, build Tasks, repository tokens, or
artifact-cache rules are provisioned.

The main template accepts `containerRegistryName`, `containerRegistrySku`
(`Basic`, `Standard`, or `Premium`), and `containerRegistryPublicNetworkAccess`
(`Enabled` or `Disabled`). The registry also uses the shared `location` and `tags`
parameters. Names must be globally unique and contain 5-50 alphanumeric characters;
if omitted, a stable name is derived from the resource group ID.

For example, to deploy both services with an explicitly named registry:

```bash
az deployment group create \
  --resource-group <resource-group-name> \
  --template-file infra/main.bicep \
  --parameters containerRegistryName=<globally-unique-registry-name>
```

Outputs expose `containerRegistryId`, `containerRegistryName`, and
`containerRegistryLoginServer`. Use the login server hostname when tagging images.
Assign **AcrPull** to application managed identities and **AcrPush** to image
publishers, scoped to the registry. No role assignments, container images, or
Container Apps integrations are created by these templates.

Setting `containerRegistryPublicNetworkAccess=Disabled` blocks public image access.
Private image access requires the **Premium** tier plus a separately provisioned
private endpoint and DNS; this template does not provision private networking.
To deploy only the registry without the billable Search service, deploy
`infra/modules/container-registry.bicep` directly with its required `name` parameter.

<h2>
  <img src=".github/assets/business-scenario.png" alt="" width="28" height="28" align="left">
  Business scenario
</h2>

<h2>
  <img src=".github/assets/supporting-documentation.png" alt="" width="28" height="28" align="left">
  Supporting documentation
</h2>



## Responsible AI Transparency FAQ
Please refer to [Transparency FAQ](./docs/TRANSPARENCY_FAQ.md) for responsible AI transparency details of this solution accelerator.

## Disclaimers

To the extent that the Software includes components or code used in or derived from Microsoft products or services, including without limitation Microsoft Azure Services (collectively, “Microsoft Products and Services”), you must also comply with the Product Terms applicable to such Microsoft Products and Services. You acknowledge and agree that the license governing the Software does not grant you a license or other right to use Microsoft Products and Services. Nothing in the license or this ReadMe file will serve to supersede, amend, terminate or modify any terms in the Product Terms for any Microsoft Products and Services.

You must also comply with all domestic and international export laws and regulations that apply to the Software, which include restrictions on destinations, end users, and end use. For further information on export restrictions, visit https://aka.ms/exporting.

You acknowledge that the Software and Microsoft Products and Services (1) are not designed, intended or made available as a medical device(s), and (2) are not designed or intended to be a substitute for professional medical advice, diagnosis, treatment, or judgment and should not be used to replace or as a substitute for professional medical advice, diagnosis, treatment, or judgment. Customer is solely responsible for displaying and/or obtaining appropriate consents, warnings, disclaimers, and acknowledgements to end users of Customer’s implementation of the Online Services.

You acknowledge the Software is not subject to SOC 1 and SOC 2 compliance audits. No Microsoft technology, nor any of its component technologies, including the Software, is intended or made available as a substitute for the professional advice, opinion, or judgement of a certified financial services professional. Do not use the Software to replace, substitute, or provide professional financial advice or judgment.

BY ACCESSING OR USING THE SOFTWARE, YOU ACKNOWLEDGE THAT THE SOFTWARE IS NOT DESIGNED OR INTENDED TO SUPPORT ANY USE IN WHICH A SERVICE INTERRUPTION, DEFECT, ERROR, OR OTHER FAILURE OF THE SOFTWARE COULD RESULT IN THE DEATH OR SERIOUS BODILY INJURY OF ANY PERSON OR IN PHYSICAL OR ENVIRONMENTAL DAMAGE (COLLECTIVELY, “HIGH-RISK USE”), AND THAT YOU WILL ENSURE THAT, IN THE EVENT OF ANY INTERRUPTION, DEFECT, ERROR, OR OTHER FAILURE OF THE SOFTWARE, THE SAFETY OF PEOPLE, PROPERTY, AND THE ENVIRONMENT ARE NOT REDUCED BELOW A LEVEL THAT IS REASONABLY, APPROPRIATE, AND LEGAL, WHETHER IN GENERAL OR IN A SPECIFIC INDUSTRY. BY ACCESSING THE SOFTWARE, YOU FURTHER ACKNOWLEDGE THAT YOUR HIGH-RISK USE OF THE SOFTWARE IS AT YOUR OWN RISK.
