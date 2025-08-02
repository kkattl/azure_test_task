az login --use-device-code

$subId = (az account show --query id -o tsv).Trim()

$sp = az ad sp create-for-rbac `
        --name "mysp$(Get-Date -Format yyyyMMddHHmmss)" `
        --role Contributor `
        --scopes "/subscriptions/$subId" `
        --output json | ConvertFrom-Json

$dir = "$HOME/.azure"
if (!(Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }

$sp | Add-Member -NotePropertyName subscriptionId -NotePropertyValue $subId -PassThru `
    | ConvertTo-Json -Depth 5 | Out-File "$dir/sp.json"


Write-Host "Path to sp: $dir/sp.json"
