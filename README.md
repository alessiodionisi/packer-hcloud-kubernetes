# Kubernetes image for Hetzner Cloud

This [Packer](https://www.packer.io) project creates an image to spin up [Kubernetes](https://kubernetes.io) clusters with [kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm) or [Kubernetes Cluster API](https://cluster-api.sigs.k8s.io) on [Hetzner Cloud](https://www.hetzner.com/cloud).

## Getting started

Set `HCLOUD_TOKEN` environment variable or `token` variable and run `packer build`, for example:

```shell
export HCLOUD_TOKEN=xxxx
packer build .
```

## Variables

| Name                  | Description                        | Default                             |
| --------------------- | ---------------------------------- | ----------------------------------- |
| `token`               | Hetzner Cloud token to access APIs | `HCLOUD_TOKEN` environment variable |
| `location`            | Hetzner Cloud location             | `fsn1`                              |
| `image`               | Hetzner Cloud base image           | `debian-12`                         |
| `server_type`         | Hetzner Cloud server type          | `cax11`                             |
| `containerd_version`  | containerd version                 | `1.7.6`                             |
| `runc_version`        | runc version                       | `1.1.9`                             |
| `cni_plugins_version` | cni plugins version                | `1.3.0`                             |
| `crictl_version`      | crictl version                     | `1.28.0`                            |
| `kubernetes_version`  | kubernetes version                 | `1.28.1`                            |
