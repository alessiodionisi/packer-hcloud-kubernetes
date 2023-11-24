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

// https://github.com/containerd/containerd/releases
variable "containerd_version" {
  type      = string
  default   = "1.7.9"
}

variable "containerd_sandbox_image" {
  type = string
  default = "registry.k8s.io/pause:3.9"
}

// https://github.com/opencontainers/runc/releases
variable "runc_version" {
  type      = string
  default   = "1.1.10"
}

// https://github.com/containernetworking/plugins/releases
variable "cni_plugins_version" {
  type      = string
  default   = "1.3.0"
}

// https://github.com/kubernetes-sigs/cri-tools/releases
variable "crictl_version" {
  type      = string
  default   = "1.28.0"
}

// https://github.com/kubernetes/kubernetes/releases
variable "kubernetes_version" {
  type      = string
  default   = "1.28.4"
}

// https://github.com/kubernetes/release/releases
variable "kubernetes_release_tooling_version" {
  type      = string
  default   = "0.16.4"
}
