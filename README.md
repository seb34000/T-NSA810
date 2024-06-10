[![Vulnerability ft trivy](https://github.com/seb34000/T-NSA810/actions/workflows/Vulnerability-scan.yaml/badge.svg)](https://github.com/seb34000/T-NSA810/actions/workflows/Vulnerability-scan.yaml)

# T-NSA810

Nous essayons de réduire les vulnérabilités dans ce projet. Nous avons mis en place un workflow de scan de vulnérabilités en utilisant Trivy. Le badge ci-dessus montre le statut du dernier scan.

Pour exécuter le projet, suivez ces étapes :
1. Assurez-vous que Docker et Docker Compose sont installés sur votre système.
2. Clonez le dépôt : `git clone https://github.com/seb34000/T-NSA810.git`
3. Naviguez vers le répertoire du projet : `cd T-NSA810`
4. Démarrez le projet en utilisant Docker Compose : `docker-compose up --build`

C'est tout ! Le projet devrait maintenant être opérationnel.

# Deploying the Application on Kubernetes using Minikube

This guide provides step-by-step instructions to deploy a sample application on Kubernetes using Minikube.

## Prerequisites

Ensure you have the following installed on your machine:

- [Docker](https://docs.docker.com/get-docker/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Argo CD CLI](https://argo-cd.readthedocs.io/en/stable/getting_started/#2-download-argo-cd-cli)

## Environment Variables

You will need to set the following environment variables:

- `GIT_USER`: Your GitHub username.
- `GIT_TOKEN`: Your GitHub personal access token with appropriate permissions to access the repository.

## Setup and Deployment Steps

1. **Clone the Repository**

    ```bash
    git clone https://github.com/yourusername/your-repo.git
    cd your-repo
    ```

2. **Prepare the Environment**

    ```bash
    export GIT_USER=your_github_username
    export GIT_TOKEN=your_github_token
    ```

3. **Run the Deployment Script**

    The provided script automates the deployment process. Save the script below as `kube-start.sh` and make it executable.

    ```bash
    chmod +x kube-start.sh
    sudo ./kube-start.sh
    ```

4. **Access the Argo CD UI**

    Once the script completes, you can access the Argo CD UI using the URL provided in the script output. It will look something like:

    ```
    http://<minikube-ip>:<node-port>
    ```

    You can log in using the username `admin` and the password `adminadmin`.

5. **Verify Deployment**

    You can verify that your application is running correctly by checking the Argo CD dashboard and using `kubectl` commands to inspect the deployed resources.

    ```bash
    kubectl get pods -n nsa
    ```

## Troubleshooting

- If you encounter issues with Minikube or Kubernetes, refer to their official documentation for troubleshooting tips:
  - [Minikube Troubleshooting](https://minikube.sigs.k8s.io/docs/handbook/debugging/)
  - [Kubernetes Troubleshooting](https://kubernetes.io/docs/tasks/debug/)

- Ensure Docker is running and you have sufficient resources allocated to Minikube (CPU, Memory).

## Cleanup

To delete the Minikube cluster and all deployed resources, run:

```bash
minikube delete
