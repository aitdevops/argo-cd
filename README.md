🚀 ArgoCD Setup for GKE
Welcome to the repository for setting up ArgoCD on Google Kubernetes Engine (GKE). This guide will help you install ArgoCD, configure it with a LoadBalancer, and retrieve the admin password. Follow the steps below to get started!

📋 Prerequisites
🛠️ A GKE cluster
🌐 kubectl configured to interact with your cluster
🗂️ A GitHub repository to store your ArgoCD configuration files
🛠️ Installation Steps
1. Install ArgoCD
Create Namespace for ArgoCD:

sh
Copy code
kubectl create namespace argocd
Apply ArgoCD Manifests:

sh
Copy code
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.7/manifests/install.yaml
Patch Service Type to LoadBalancer:

sh
Copy code
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
Retrieve Admin Password:

sh
Copy code
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
2. Install NGINX Ingress Controller
Add the Ingress NGINX Helm repository:

sh
Copy code
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
Install the NGINX Ingress controller:

sh
Copy code
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace
3. Install Cert-Manager
Add the Jetstack Helm repository:

sh
Copy code
helm repo add jetstack https://charts.jetstack.io
helm repo update
Install Cert-Manager:

sh
Copy code
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.5.3
Create a ClusterIssuer for Let's Encrypt:

yaml
Copy code
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: your-email@example.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx
Apply the ClusterIssuer:

sh
Copy code
kubectl apply -f cluster-issuer.yaml
🎯 Accessing the ArgoCD UI
Once you have retrieved the admin password, you can access the ArgoCD UI. Use the external IP provided by the LoadBalancer to log in.

📂 Repository Structure
This repository includes the following directories:

manifests/ - Contains ArgoCD application manifests
docs/ - Documentation and guides
🤝 Contributing
Feel free to contribute to this repository by submitting issues or pull requests. Let's work together to improve the ArgoCD setup process!

Happy deploying with ArgoCD on GKE! 🚀

Note:
Ensure to replace your-email@example.com with your actual email address in the ClusterIssuer configuration.
The instructions assume that Helm and kubectl are installed and configured to interact with your GKE cluster.





