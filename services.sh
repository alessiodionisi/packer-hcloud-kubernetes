set -x
set -e

mkdir -p /usr/local/lib/systemd/system

# containerd
curl -OL https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
mv containerd.service /usr/local/lib/systemd/system/containerd.service
systemctl daemon-reload
systemctl enable containerd --now

# kubelet
curl -OL https://raw.githubusercontent.com/kubernetes/release/v0.15.1/cmd/kubepkg/templates/latest/deb/kubelet/lib/systemd/system/kubelet.service
mv kubelet.service /usr/local/lib/systemd/system/kubelet.service
curl -OL https://raw.githubusercontent.com/kubernetes/release/v0.15.1/cmd/kubepkg/templates/latest/deb/kubeadm/10-kubeadm.conf
mkdir -p /usr/local/lib/systemd/system/kubelet.service.d
mv 10-kubeadm.conf /usr/local/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
sed -i "s:/usr/bin:/usr/local/bin:g" /usr/local/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload
systemctl enable kubelet --now
