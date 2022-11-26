variable "gcp_auth_file" {
  type        = string
  description = "GCP authentication file"
}

variable "gcp_project" {
  type        = string
  description = "GCP project name"
}

variable "gcp_region" {
  type        = string
  description = "GCP region"
}

variable "gcp_zone" {
  type        = string
  description = "GCP zone"
}

variable "prefix_display_name" {
  description = "Prefix for resources display names"
  default     = ""
  type        = string
}

variable "network-subnet-cidr" {
  type        = string
  description = "The CIDR for the network subnet"
  default     = "10.0.2.0/24"
}

variable "ingress_allowed_tcp" {
  description = "List of allowed TCP ingress ports"
  type        = list(number)
  default     = [22, 443, 80, 300, 3000]
}

variable "ingress_allowed_udp" {
  description = "List of allowed UDP ingress ports"
  type        = list(number)
  default     = [51820, 20560, 27015, 7777, 8080, 9876, 9877, 27015, 27016]
}

variable "os_image" {
  type        = string
  description = "Ubuntu Minimal - 22.04 - Jammy - LTS"
  default     = "ubuntu-os-cloud/ubuntu-minimal-2204-lts"
}

variable "vm_instance_type" {
  type        = string
  description = "VM instance type"
  default     = "e2-micro"
}

variable "ssh_public_key_path" {
  description = "Public key signature of the ssh key pair"
  type        = string
}

variable "user" {
  type    = string
  default = "ubuntu"
}

variable "cloudflare_instance_name" {
  type    = string
  default = "compute0"
}

variable "cloudflare_api_token" {
  description = "The Cloudflare API token."
  type        = string
}

variable "cloudflare_zone_id" {
  description = "The DNS zone to use."
  type        = string
}
