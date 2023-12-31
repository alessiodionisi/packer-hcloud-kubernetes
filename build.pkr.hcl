locals {
  image_name = "kubernetes-${var.kubernetes_version}-${var.image}-%{ if substr(var.server_type, 0, 3) == "cax" }arm64%{ else }amd64%{ endif }-{{ timestamp }}"
}

source "hcloud" "source" {
  image = var.image
  location = var.location
  server_type = var.server_type
  snapshot_name = local.image_name
  snapshot_labels = {
    caph-image-name = local.image_name
  }
  ssh_username  = "root"
  token = var.token
}

build {
  sources = ["source.hcloud.source"]

  provisioner "shell" {
    inline = [
      "apt update -y",
      "apt dist-upgrade -y",
      "apt install -y socat conntrack",
    ]
  }

  provisioner "shell" {
    script = "binaries.sh"
    env = {
      CNI_PLUGINS_VERSION = var.cni_plugins_version
      CONTAINERD_SANDBOX_IMAGE = var.containerd_sandbox_image
      CONTAINERD_VERSION = var.containerd_version
      CRICTL_VERSION = var.crictl_version
      KUBERNETES_VERSION = var.kubernetes_version
      RUNC_VERSION = var.runc_version
    }
  }

  provisioner "file" {
    content = <<EOT
overlay
br_netfilter
EOT
    destination = "/etc/modules-load.d/k8s.conf"
  }

  provisioner "shell" {
    inline = [
      "modprobe overlay",
      "modprobe br_netfilter",
    ]
  }

  provisioner "file" {
    content = <<EOT
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
EOT
    destination = "/etc/sysctl.d/k8s.conf"
  }

  provisioner "shell" {
    inline = [
      "sysctl --system",
    ]
  }

  provisioner "shell" {
    script = "services.sh"
    env = {
      CONTAINERD_VERSION = var.containerd_version
      KUBERNETES_RELEASE_TOOLING_VERSION = var.kubernetes_release_tooling_version
    }
  }

  provisioner "shell" {
    inline = [
      "kubeadm config images pull --kubernetes-version ${var.kubernetes_version}",
    ]
  }

  provisioner "shell" {
    inline = [
      "apt clean",
      "cloud-init clean"
    ]
  }
}
