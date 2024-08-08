# 🚀 ArgoCD Setup for GKE

Welcome to the repository for setting up ArgoCD on Google Kubernetes Engine (GKE). This guide will help you install ArgoCD, configure it with a LoadBalancer, and retrieve the admin password. Follow the steps below to get started!

## 📋 Prerequisites

- 🛠️ A GKE cluster
- 🌐 `kubectl` configured to interact with your cluster
- 🗂️ A GitHub repository to store your ArgoCD configuration files

## 🛠️ Installation Steps

1. **Create Namespace for ArgoCD**:
    ```sh
    kubectl create namespace argocd
    ```

2. **Apply ArgoCD Manifests**:
    ```sh
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.7.2/manifests/install.yaml
    ```

3. **Patch Service Type to LoadBalancer**:
    ```sh
    kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
    ```

4. **Retrieve Admin Password**:
    ```sh
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
    ```

## 🎯 Accessing the ArgoCD UI

Once you have retrieved the admin password, you can access the ArgoCD UI. Use the external IP provided by the LoadBalancer to log in.

## 📂 Repository Structure

This repository includes the following directories:

- `manifests/` - Contains ArgoCD application manifests
- `docs/` - Documentation and guides

## 🤝 Contributing

Feel free to contribute to this repository by submitting issues or pull requests. Let's work together to improve the ArgoCD setup process!


---

Happy deploying with ArgoCD on GKE! 🚀
