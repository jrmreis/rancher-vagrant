## Prerequisites:

### Install VirtualBox:

```
sudo apt update
```

```
curl https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor > oracle_vbox_2016.gpg
curl https://www.virtualbox.org/download/oracle_vbox.asc | gpg --dearmor > oracle_vbox.gpg
sudo install -o root -g root -m 644 oracle_vbox_2016.gpg /etc/apt/trusted.gpg.d/
sudo install -o root -g root -m 644 oracle_vbox.gpg /etc/apt/trusted.gpg.d/
```

```
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
```

```
sudo apt update
sudo apt install -y linux-headers-$(uname -r) dkms
sudo apt install virtualbox-7.0 -y
```

```
wget https://download.virtualbox.org/virtualbox/7.0.0/Oracle_VM_VirtualBox_Extension_Pack-7.0.0.vbox-extpack
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-7.0.0.vbox-extpack
```

[Fonte: Gcore](https://gcore.com/learning/how-to-install-virtualbox-on-ubuntu/)


### Install Vagrant:



### Install Rancher (rke):



### to create VMs:

```
vagrant up
```

### show VMs status:

```
vagrant status
```
> [!NOTE]
> Current machine states:
>
> kmaster                   running (virtualbox)
> kworker1                  running (virtualbox)
> 
> This environment represents multiple VMs. The VMs are all listed
> above with their current state. For more information about a specific
> VM, run `vagrant status NAME`.


### get in the VMs by vagrant ssh cmd:

```
vagrant ssh kmaster
```

### show ip needed on rke cluster yaml file:

```
ip a show enp0s8
```

### check cluster.yaml file:

```
cat cluster.yaml
```

````
cluster_name: rkelearning
network:
  plugin: canal
  options:
    canal_iface: enp0s8
nodes:
    - address: 192.168.15.16
      user: vagrant
      role:
        - controlplane
        - etcd
        - worker
      ssh_key_path: /home/joel/learn-vagrant-docker-container/rke1-learning/RKE1-setup/.vagrant/machines/kmaster/virtualbox/private_key
    - address: 192.168.15.20
      user: vagrant
      role:
        - worker
      ssh_key_path: /home/joel/learn-vagrant-docker-container/rke1-learning/RKE1-setup/.vagrant/machines/kworker1/virtualbox/private_key
````

### edit cluster.yaml file:

```
subl cluster.yml 
```

### to create kubernetes cluster with rancher:

```
rke up 
```
[Tipical start-up Log](https://github.com/jrmreis/rancher-vagrant/blob/main/stdClusterLog.txt)


### to copy kubernetes config cluster:

```
cp kube_config_cluster.yml ~/.kube/config
```

### to check kubernetes nodes in cluster:

```
kubectl get node
```
```
NAME            STATUS   ROLES                      AGE   VERSION
192.168.15.14   Ready    controlplane,etcd,worker   17m   v1.30.4
192.168.15.15   Ready    worker                     17m   v1.30.4

```

### to deploy in kubernetes nodes in the cluster:

```
kubectl apply -f deployment.yaml
```

### to monitor kubernetes deployment in cluster nodes:

```
watch "kubectl get all"
```

[looping of "get all"](https://github.com/jrmreis/rancher-vagrant/blob/main/returnOfGetAll.txt)

### to open site nodes at browser:

```
http://192.168.15.14:30003/
```
[App is running at node and port explicit in cluster.yml](https://github.com/jrmreis/rancher-vagrant/blob/main/Captura%20de%20tela%20de%202024-10-13%2022-02-01.png)

### to roll back, follow the cmd below:

```
kubectl rollout undo deployment <>
```
[more info in Kubernetes docs](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/kubectl_rollout_undo/)

[other reference](https://learnk8s.io/kubernetes-rollbacks)

### to remove the kubernete cluster:

```
rke remove
```
