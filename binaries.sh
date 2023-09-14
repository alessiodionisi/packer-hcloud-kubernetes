set -x
set -e

# variables
ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then ARCH=arm64; fi

# containerd
curl -OL https://github.com/containerd/containerd/releases/download/v$CONTAINERD_VERSION/containerd-$CONTAINERD_VERSION-linux-$ARCH.tar.gz
curl -OL https://github.com/containerd/containerd/releases/download/v$CONTAINERD_VERSION/containerd-$CONTAINERD_VERSION-linux-$ARCH.tar.gz.sha256sum
sha256sum -c containerd-$CONTAINERD_VERSION-linux-$ARCH.tar.gz.sha256sum
tar --no-overwrite-dir -C /usr/local -xzf containerd-$CONTAINERD_VERSION-linux-$ARCH.tar.gz
rm -f containerd-$CONTAINERD_VERSION-linux-$ARCH.tar.gz containerd-$CONTAINERD_VERSION-linux-$ARCH.tar.gz.sha256sum
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml
sed -i "s:SystemdCgroup = false:SystemdCgroup = true:g" /etc/containerd/config.toml
# sed -i "s#registry.k8s.io/pause:3.8#registry.k8s.io/pause:3.9#g" /etc/containerd/config.toml

# runc
curl -OL https://github.com/opencontainers/runc/releases/download/v$RUNC_VERSION/runc.$ARCH
curl -OL https://github.com/opencontainers/runc/releases/download/v$RUNC_VERSION/runc.sha256sum
sha256sum -c --ignore-missing runc.sha256sum
mv runc.$ARCH /usr/local/sbin/runc
chmod +x /usr/local/sbin/runc
rm -f runc.sha256sum

# cni-plugins
curl -OL https://github.com/containernetworking/plugins/releases/download/v$CNI_PLUGINS_VERSION/cni-plugins-linux-$ARCH-v$CNI_PLUGINS_VERSION.tgz
curl -OL https://github.com/containernetworking/plugins/releases/download/v$CNI_PLUGINS_VERSION/cni-plugins-linux-$ARCH-v$CNI_PLUGINS_VERSION.tgz.sha256
sha256sum -c cni-plugins-linux-$ARCH-v$CNI_PLUGINS_VERSION.tgz.sha256
mkdir -p /opt/cni/bin
tar --no-overwrite-dir -C /opt/cni/bin -xzf cni-plugins-linux-$ARCH-v$CNI_PLUGINS_VERSION.tgz
rm -f cni-plugins-linux-$ARCH-v$CNI_PLUGINS_VERSION.tgz cni-plugins-linux-$ARCH-v$CNI_PLUGINS_VERSION.tgz.sha256

# crictl
curl -OL https://github.com/kubernetes-sigs/cri-tools/releases/download/v$CRICTL_VERSION/crictl-v$CRICTL_VERSION-linux-$ARCH.tar.gz
curl -OL https://github.com/kubernetes-sigs/cri-tools/releases/download/v$CRICTL_VERSION/crictl-v$CRICTL_VERSION-linux-$ARCH.tar.gz.sha256
tr -d "\n\r" < crictl-v$CRICTL_VERSION-linux-$ARCH.tar.gz.sha256 > crictl.sha256
rm -f crictl-v$CRICTL_VERSION-linux-$ARCH.tar.gz.sha256
mv crictl.sha256 crictl-v$CRICTL_VERSION-linux-$ARCH.tar.gz.sha256
echo " crictl-v$CRICTL_VERSION-linux-$ARCH.tar.gz" >> crictl-v$CRICTL_VERSION-linux-$ARCH.tar.gz.sha256
sha256sum -c crictl-v$CRICTL_VERSION-linux-$ARCH.tar.gz.sha256
tar --no-overwrite-dir -C /usr/local/bin -xzf crictl-v$CRICTL_VERSION-linux-$ARCH.tar.gz
rm -f crictl-v$CRICTL_VERSION-linux-$ARCH.tar.gz crictl-v$CRICTL_VERSION-linux-$ARCH.tar.gz.sha256

# kubeadm
curl -OL https://dl.k8s.io/release/v$KUBERNETES_VERSION/bin/linux/$ARCH/kubeadm
curl -OL https://dl.k8s.io/release/v$KUBERNETES_VERSION/bin/linux/$ARCH/kubeadm.sha256
echo " kubeadm" >> kubeadm.sha256
sha256sum -c kubeadm.sha256
mv kubeadm /usr/local/bin/kubeadm
chmod +x /usr/local/bin/kubeadm
rm -f kubeadm.sha256

# kubelet
curl -OL https://dl.k8s.io/release/v$KUBERNETES_VERSION/bin/linux/$ARCH/kubelet
curl -OL https://dl.k8s.io/release/v$KUBERNETES_VERSION/bin/linux/$ARCH/kubelet.sha256
echo " kubelet" >> kubelet.sha256
sha256sum -c kubelet.sha256
mv kubelet /usr/local/bin/kubelet
chmod +x /usr/local/bin/kubelet
rm -f kubelet.sha256

# kubectl
curl -OL https://dl.k8s.io/release/v$KUBERNETES_VERSION/bin/linux/$ARCH/kubectl
curl -OL https://dl.k8s.io/release/v$KUBERNETES_VERSION/bin/linux/$ARCH/kubectl.sha256
echo " kubectl" >> kubectl.sha256
sha256sum -c kubectl.sha256
mv kubectl /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl
rm -f kubectl.sha256
