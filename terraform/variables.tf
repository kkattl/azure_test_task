variable "sp_path"{
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "location" {
     type = string
}

variable "prefix" {
     type = string
}

#network

variable "vnet_address_space" {
    type = list(string)
}

variable "private_subnet_address_space" {
    type = list(string)
}

variable "public_subnet_address_space" {
    type = list(string)
}

#vm

variable "admin_username" {
    type = string
}

variable "ssh_vm1_public_key_path" {
    type = string
}

variable "ssh_vm2_public_key_path" {
    type = string
}

variable "vm_size" {
    type = string
}

variable "image_publisher" {
    type = string
}

variable "image_offer" {
    type = string
}

variable "image_sku" {
    type = string
}

variable "image_version" {
    type = string
}

variable "vm_os_disk_caching" {
    type = string
}

variable "vm_os_disk_storage_account_type" {
    type = string
}

#sg

variable "vm1_allowed_ports" {
    type = list(number)
}

variable "vm2_allowed_ports" {
    type = list(number)
}