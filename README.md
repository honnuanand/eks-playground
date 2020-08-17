# eks-playground
After the eks cluster is provisioned extract the kubeconfig using 

`$ aws eks --region us-west-2 update-kubeconfig --name eksquatro --kubeconfig kubeconfig`

#### IF you want to create a DNS Zone and delegation run the create script in the `dns-zone` folder

### Install certmanager

```bash
cd certmanager
./create-certmanager.sh
```


### Install Nginx Ingress

```bash
cd ..
cd nginx-ingress
./create-nginx-ingress.sh
```

### Install External DNS 

```bash
cd ..
cd nginx-external-dns
./create-external-dns.sh
```