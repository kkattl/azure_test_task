$tfJson = terraform output -json | ConvertFrom-Json

$vm1_pub_ip  = $tfJson.vm1_public_ip.value
$vm2_priv_ip = $tfJson.vm2_private_ip.value

$ansDir = "../ansible"

@"
[vm1_main]
vm1 ansible_host=$vm1_pub_ip ansible_user=adminazure ansible_ssh_private_key_file=~/.ssh/id_ed25519

[vm2_db]
vm2 ansible_host=$vm2_priv_ip ansible_user=adminazure ansible_ssh_private_key_file=~/.ssh/vagrant_id_ed25519 ansible_ssh_common_args="-o ProxyJump=adminazure@$vm1_pub_ip"
"@ | Out-File "$ansDir/inventory.ini" -Encoding utf8

