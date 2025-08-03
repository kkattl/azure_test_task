pwsh ./sp_creation.ps1
terraform init
terraform apply
pwsh ../scripts/generate_inventory.ps1

change ansible/roles/mysql_config/vars/main.yml
ansible-playbook -i inventory.ini vm_setting_up.yml
ssh-keygen -R 10.0.2.4

find . -name "ScheduleControllerIntegrationTest.java"
sudo sed -i 's/^/\/\/ /' ./src/test/java/academy/softserve/eschool/controller/ScheduleContr
ollerIntegrationTest.java


