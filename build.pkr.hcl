source "hcloud" "source" {
  image = var.image
  location = var.location
  server_type = var.server_type
  snapshot_name = "kubernetes-${var.kubernetes_version}-${var.image}-%{ if substr(var.server_type, 0, 3) == "cax" }arm64%{ else }amd64%{ endif }-{{ timestamp }}"
  ssh_username  = "root"
  token = var.token
}

build {
  sources = ["source.hcloud.source"]

  provisioner "shell" {
    inline = [
      "apt update -y",
      "apt dist-upgrade -y"
    ]
  }

  provisioner "shell" {
    script = "binaries.sh"
    env = {
      CONTAINERD_VERSION = var.containerd_version
      RUNC_VERSION = var.runc_version
      CNI_PLUGINS_VERSION = var.cni_plugins_version
      CRICTL_VERSION = var.crictl_version
      KUBERNETES_VERSION = var.kubernetes_version
    }
  }

  provisioner "shell" {
    script = "services.sh"
  }

  provisioner "file" {
    content = <<EOT
overlay
br_netfilter
EOT
    destination = "/etc/modules-load.d/k8s.conf"
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
      "apt clean",
      "cloud-init clean"
    ]
  }
}
