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

### Azure AI Search infrastructure

`infra/main.bicep` deploys the Azure AI Search service defined in
`infra/modules/search.bicep` into an existing resource group. Other infrastructure
modules remain scaffolds.

The default configuration uses the **Standard S2** tier with three replicas and
three partitions (nine billable search units), a system-assigned managed identity,
and Microsoft Entra ID authentication only (API keys are disabled). Public network
access is enabled, and the semantic ranker uses the usage-based standard plan.
Deployment creates a billable service.

With the Azure CLI and Bicep installed, compile the templates without deploying:

```bash
az bicep build --file infra/main.bicep --stdout
```

To deploy when ready, select the intended subscription and use an existing resource
group:

```bash
az deployment group create \
  --resource-group <resource-group-name> \
  --template-file infra/main.bicep \
  --parameters searchServiceName=<globally-unique-search-name>
```

The service name must contain 2-60 lowercase letters, digits, or single hyphens,
and must start and end with a letter or digit. If omitted, the template derives a
stable name from the resource group ID. Optional parameters include `location`,
`searchSku`, `searchReplicaCount`, `searchPartitionCount`, `searchHostingMode`,
`searchSemanticSearch`, `searchPublicNetworkAccess`, and `tags`. Capacity
combinations must be supported by the selected tier and service; Azure validates
them during deployment. New Basic services support up to three partitions and three
replicas, while older services can be limited to one partition. `HighDensity`
hosting is available only for Standard S3 with at most three partitions. A single
replica does not provide a production availability SLA. Semantic ranking requires a
supported region and tier; choose
`free` for the limited free quota, `standard` for usage-based billing, or
`disabled` to turn it off.

Deployment outputs expose the service ID, name, endpoint, and managed identity
principal ID. The service identity is for outbound access to other Azure resources;
it does not authorize applications to query the service. Assign callers
**Search Index Data Reader** for queries, **Search Index Data Contributor** for
document writes, and **Search Service Contributor** when index management is
required, scoped to the search service. No role assignments, indexes, or data
ingestion are created by these templates.

Setting `searchPublicNetworkAccess=Disabled` requires a private endpoint and DNS
configured separately; this template does not provision private networking.

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
