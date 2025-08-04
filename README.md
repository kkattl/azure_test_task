1. Create a service principal
```bash
cd scripts
pwsh ./sp_creation.ps1
```
2. Create infrastructure
```bash
cd ../terraform
terraform init
terraform apply
```
3. Create inventory for ansible
```bash
pwsh ../scripts/generate_inventory.ps1
```
4. Change `ansible/roles/mysql_config/vars/main.yml.example` on `ansible/roles/mysql_config/vars/main.yml` and add your own data
5. Change `ansible/roles/deploy_eschool/vars/main.yml.example` on `ansible/roles/deploy_eschool/vars/main.yml` and add your own data

6. Run ansible playbook
```bash
cd ../ansible
ansible-playbook -i inventory.ini vm_setting_up.yml
```


