# README

# Pacman Demo Project Team 1

---

## Team members:

---

- Carlos Catalán.
- Alberto Valle.
- Sergio Velázquez.
- Alan Ortega.

## Project Background

---

There is a company that had build a web video game using micro-services  solutions and deployed them on many virtual machines that are using many resources.

We build this solution to integrate and automate the project using CI/CD tools, Terraform to build the infrastructure, GitHub for version control and branching model, Azure tools as Kubernetes Cluster and container registry, GitHub Actions to run automated process using pipelines and Vault to allocated secrets and passwords.

## Infrastructure

---

This project uses the [pacman-project](https://github.com/font/k8s-example-apps).

Image of the infra.

Some details about the infra

## Pipelines

---

Diagram of the pipelines

Description of each pipeline

## Technologies justification

---

We build the infrastructure on cloud because users can scale services to fit their needs, customize applications and access cloud services from anywhere with an internet connection, cloud infrastructure scales on demand to support fluctuating workloads, cloud-based applications and data are accessible from virtually any internet-connected device, the user only pay for the resources they use.

![https://i.imgur.com/rJWQIbs.png](https://i.imgur.com/rJWQIbs.png)

We decided to use Microsoft Azure because is one of tools that we have more experience working with, also Microsoft Azure offers more than 200 products and cloud services designed to help us bring new solutions to our applications, we build the Kubernetes cluster and the Azure Container Registry. With Microsoft Azure we can store all the resources in the same environment and it's easy to handle them. The Microsoft Azure documentation is one of the most complete.

![https://i.imgur.com/FwjLRp6.jpg](https://i.imgur.com/FwjLRp6.jpg)

For orchestration we worked with Helm Chart because it provide the ability to leverage Kubernetes packages through the click of a button or single CLI command. Helm charts are built atop Kubernetes and benefit from its cluster architecture. The main benefit of this approach is the ability to consider scalability from the start.

![https://i.imgur.com/LSoswd8.png](https://i.imgur.com/LSoswd8.png)

On this project we used infrastructure as a code with Terraform that is an open source tool created by HashiCorp and written in the Go programming language. Terraform applies to multi-cloud scenarios, it can create configuration file templates to define, provision, and configure ECS resources in a repeatable and predictable manner, reducing deployment and management errors resulting from human intervention. In addition, Terraform can deploy the same template multiple times to create the same development, test, and production environment.

![https://i.imgur.com/l4iN4np.png](https://i.imgur.com/l4iN4np.png)

For Version Control System we are using GitHub because there is a excellent documentation, is one of the largest coding communities around right now, GitHub keep track of all the changes that have  been pushed to the repository, we can have a version history of our code so that previous version are not lost with every iteration.

GitHub Actions makes it easy to automate all your software workflows. Build, test, and deploy your code right from GitHub. Make code reviews, branch management, and issue triaging work the way you want. Kick off workflows with GitHub events like push, issue creation, or a new release. Combine and configure actions for the services you use, built and maintained by the community.

![https://i.imgur.com/f3urqAi.png](https://i.imgur.com/f3urqAi.png)

We are using Vault because supports most of the major cloud platforms. HashiCorp Vault can provide consolidated secrets management for the entire organization. Using the KV (key/value) storage backend, Vault can help organize secrets by department, team, business unit, application, or any other way that makes sense for the respective organization. Vault policies can be created to ensure that the principle of least privilege is followed, and access to secrets is only provided to individuals, teams, or applications that need them for business functions. Additionally, once the secrets are written to Vault, they can be accessed through Vault's UI, CLI, or API, making it simple for the retrieval of secrets.

![https://i.imgur.com/tgl4pZl.png](https://i.imgur.com/tgl4pZl.png)

The team chose this tool because Ansible **automates and simplifies repetitive, and complex operations**. Everybody likes it because it brings **huge time savings** when we install packages or configure large numbers of servers.

Its architecture is simple and effective. It works by connecting to your nodes and pushing small programs to them. These programs make the system comply with a desired state, and, when they have finished their tasks, they are deleted.

Ansible **works over SSH** and doesn't require any daemons, special servers, or libraries to work. A text editor and a command line tool are usually enough to get your work done.

# How to

# Configure Azure

Create service principal

```bash
az ad sp create-for-rbac --role="Owner" --scopes="/subscriptions/<subscription_id>"
```

Clone the GitHub Repository:

```bash
git clone https://github.com/carloscatalanl/retrogame-devops.git
```

## Deploy Terraform Backend:

```bash
./deploy-backend.sh
```

Run the Pipelines on this order:

1. **Deploy QA Infrastructure in Azure**
2. **Deploy Infrastructure in Azure**
3. **Deploy Vault Infrastructure in Azure**

Enter to you Github actions, then click on the workflow and finally click on "Run workflow"

![https://i.imgur.com/x28beC4.png](https://i.imgur.com/x28beC4.png)

The secrets that you have to set are the next:

- 

## Build and push Docker Image

- Login into container registry
    
    ```
    docker login containerregistrypacman.azurecr.io
    ```
    
- Build Docker image
    
    ```
    docker build -t pacman-app .
    ```
    
- Tag image
    
    ```
    docker tag pacman-app containerregistrypacman.azurecr.io/pacman-app
    ```
    
- Push image
    
    ```
    docker push containerregistrypacman.azurecr.io/pacman-app
    ```
    

## Conect to Kubernetes Cluster

- Run the following commands
    
    ```
    az account set --subscription <subscription_id>az aks get-credentials --resource-group <resource_group_name> --name <kubernetes_cluster_name>
    ```
    
    ## Run in K8s Cluster
    
- Create namespace
    
    ```
    kubectl create namespace pacman
    ```
    
- In k8s/db
    
    ```
    kubectl -n pacman apply -f .
    ```
    
- In k8s/app
    
    ```
    kubectl -n pacman apply -f .
    ```
    
- Get all in pacman ns
    
    ```
    kubectl -n pacman get all
    ```
    

## Run in Helm Chart

- Create namespace
    
    ```
    kubectl create namespace pacman
    ```
    
- In helm/
    
    ```
    helm install retropacmanapp . -n pacman
    ```