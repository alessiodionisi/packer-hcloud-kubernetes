# Kubernetes image for Hetzner Cloud

This [Packer](https://www.packer.io) project creates an image to spin up [Kubernetes](https://kubernetes.io) clusters with [kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm) or [Kubernetes Cluster API](https://cluster-api.sigs.k8s.io) on [Hetzner Cloud](https://www.hetzner.com/cloud).

## Features

- All requirements to setup a Kubernetes cluster with `kubeadm`
- [containerd](https://containerd.io) as container runtime
- AMD64 and ARM64 support
- IPv4/IPv6 dual-stack networking support
- Integrity of downloaded files verified with `sha256sum`
- Images used by `kubeadm` pulled as building step

## Getting started

Set `HCLOUD_TOKEN` environment variable or `token` variable and run `packer build`, for example:

```shell
export HCLOUD_TOKEN=xxxx
packer build .
```

## Variables

| Name                                 | Description                        | Default                             |
| ------------------------------------ | ---------------------------------- | ----------------------------------- |
| `cni_plugins_version`                | cni plugins version                | `1.3.0`                             |
| `containerd_version`                 | containerd version                 | `1.7.6`                             |
| `crictl_version`                     | crictl version                     | `1.28.0`                            |
| `image`                              | Hetzner Cloud base image           | `debian-12`                         |
| `kubernetes_release_tooling_version` | kubernetes release tooling version | `0.15.1`                            |
| `kubernetes_version`                 | kubernetes version                 | `1.28.2`                            |
| `location`                           | Hetzner Cloud location             | `fsn1`                              |
| `runc_version`                       | runc version                       | `1.1.9`                             |
| `server_type`                        | Hetzner Cloud server type          | `cax11`                             |
| `token`                              | Hetzner Cloud token to access APIs | `HCLOUD_TOKEN` environment variable |
