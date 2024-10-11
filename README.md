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

### to deploy kubernetes nodes in cluster:

```
watch "kubectl get all"
```

[looping of "get all"](https://github.com/jrmreis/rancher-vagrant/blob/main/returnOfGetAll.txt)
