pwsh ./sp_creation.ps1
terraform init
terraform apply
pwsh ../scripts/generate_inventory.ps1

change ansible/roles/mysql_config/vars/main.yml