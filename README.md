# 🚀 ArgoCD Setup for aitdevops-site

Welcome to the repository that manages Continuous Deployment (CD) for the aitdevops project. This guide will help you install ArgoCD in GKE and retrieve the admin password, configure it with an Ingress Controller & Cert-Manager. Follow the steps below to get started!

## 📋 Prerequisites

- 🛠️ A GKE cluster
- 🌐 `kubectl` configured to interact with your cluster
- 🗂️ A GitHub repository to store your ArgoCD configuration files

## 🛠️ Installation Steps

### 1. Install ArgoCD

1. **Create Namespace for ArgoCD**:
    ```sh
    kubectl create namespace argocd
    ```

2. **Apply ArgoCD Manifests**:
    ```sh
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    ```

3. **Patch Service Type to LoadBalancer**:
    ```sh
    kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
    ```

4. **Retrieve Admin Password**:
    ```sh
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
    ```

### 2. Install NGINX Ingress Controller

1. **Create the Ingress NGINX Namespace**:
    ```sh
    kubectl create namespace ingress-nginx
    ```

2. **Apply the NGINX Ingress Controller Manifests**:
    ```sh
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml -n ingress-nginx
    ```

3. **Verify the NGINX Ingress Controller Installation**:
    ```sh
    kubectl get pods -n ingress-nginx
    ```

### 3. Install Cert-Manager

1. **Create the Cert-Manager Namespace**:
    ```sh
    kubectl create namespace cert-manager
    ```

2. **Install Cert-Manager CRDs**:
    ```sh
    kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.crds.yaml
    ```

3. **Apply the Cert-Manager Installation Manifests**:
    ```sh
    kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml -n cert-manager
    ```

## 🎯 Accessing the ArgoCD UI

Once you have retrieved the admin password, you can access the ArgoCD UI. Use the external IP provided by the LoadBalancer to log in.

## 📂 Repository Structure

This repository includes the following directories:

- `argo-apps/` - Contains ArgoCD application manifests
- `backend/` - Contains backend microservices manifests
- `frontend/` - Contains frontend manifests
- `cluster-configs/` - Contains ingress&cert-manager manifests

## 🤝 Contributing

Feel free to contribute to this repository by submitting issues or pull requests. Let's work together to improve the ArgoCD setup process!

---

Happy deploying with ArgoCD on GKE! 🚀

---

### Note:
- Ensure to replace `rajeevkoppisetti21@gmail.com` with your actual email address in the ClusterIssuer configuration.
- The instructions assume that `kubectl` is installed and configured to interact with your GKE cluster.
