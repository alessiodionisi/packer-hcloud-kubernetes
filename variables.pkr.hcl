variable "token" {
  type      = string
  default   = "${env("HCLOUD_TOKEN")}"
  sensitive = true
}

variable "location" {
  type      = string
  default = "fsn1"
}

variable "image" {
  type      = string
  default = "debian-12"
}

variable "server_type" {
  type      = string
  default = "cax11"
}

variable "containerd_version" {
  type      = string
  default   = "1.7.5"
}

variable "runc_version" {
  type      = string
  default   = "1.1.9"
}

variable "cni_plugins_version" {
  type      = string
  default   = "1.3.0"
}

variable "crictl_version" {
  type      = string
  default   = "1.28.0"
}

variable "kubernetes_version" {
  type      = string
  default   = "1.28.1"
}
