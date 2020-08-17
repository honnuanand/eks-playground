#### Pre-Reqs ,  tools and cli install instrucitons 

1. [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) -  controls the Kubernetes cluster manager.

 
    ```bash
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    kubectl version --client
    ```
1. [tkg-cli](https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.0/vmware-tanzu-kubernetes-grid-10/GUID-install-tkg-set-up-tkg.html) -  The Tanzu Kubernetes Grid CLI using the instructions on the link. 
1. AWS [Cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
1. clusterawsadm  - from the TKG Downloads page and follow similar instructions like the tkg install. 
1. [terraform 0.12](https://learn.hashicorp.com/terraform/getting-started/install.html) or later. 
1. [k14s tools](https://k14s.io/)
1. k14s - [terraform plugin](https://github.com/k14s/terraform-provider-k14s/blob/develop/docs/install.md)
1. [kind](https://kind.sigs.k8s.io/docs/user/quick-start/) - k8s for your local machine