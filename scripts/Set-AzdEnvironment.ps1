param (
    [string]$ResourceGroupName,
    [string]$Location,
    [int[]]$AvailabilityZones, 
    [string]$VmSku = "Standard_D2_v4"
)

$Overrides = @{
  "eastus2" = @{"zones" = ("2", "3")}
  "westus2" = @{"zones" = @("3")}
  "eastus" = @{"zones" = ("2", "1")}
}

azd env set AZURE_RESOURCE_GROUP $ResourceGroupName
azd env set COMPANY_NAME "Zava"
azd env set AZURE_LOCATION $Location
azd env set AKS_NODE_POOL_VM_SIZE $VmSku
azd env set DEPLOY_AZURE_CONTAINER_REGISTRY "false"
azd env set DEPLOY_AZURE_OPENAI "true"
azd env set AZURE_OPENAI_LOCATION "swedencentral"
azd env set DEPLOY_AZURE_OPENAI_DALL_E_MODEL "false"
azd env set DEPLOY_AZURE_SERVICE_BUS "true"
azd env set DEPLOY_AZURE_COSMOSDB "true"
azd env set AZURE_COSMOSDB_ACCOUNT_KIND "MongoDB"
azd env set DEPLOY_OBSERVABILITY_TOOLS "false"
azd env set SOURCE_REGISTRY "ghcr.io/usepowershell"

if ($AvailabilityZones) {
    $zones = $AvailabilityZones -join ', '
    azd env set AKS_AVAILABILITY_ZONES $zones
}
elseif ($Overrides.Keys -contains $Location ) {
    $zones = $Overrides[$Location].zones -join ', '
    azd env set AKS_AVAILABILITY_ZONES $zones
}