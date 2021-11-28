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

## QA and Production deployment

![https://i.imgur.com/ZJKwyfq.png](https://i.imgur.com/ZJKwyfq.png)

In these pipelines test, build, tag and push the docker image of the project. Then, restart the app pod and pull the latest version of the image.

- Test
    - Verify if docker is already installed
    - (Pending QA team test)
- Release
    - Build docker image
    - Tag docker image
    - Push docker image into ACR (QA or Production)
- Deploy
    - Restart app pod and pull the latest image

## QA and Production infrastructure

![https://i.imgur.com/gLPYXFQ.png](https://i.imgur.com/gLPYXFQ.png)

- Terraform
    - Init
    - Format
    - Validate
    - Plan
    - Apply (Deploy) Terraform infrastructure
- Release
    - Build docker image
    - Tag docker image
    - Push docker image into ACR (QA or Production)
- Helm
    - Install Helm
    - Run Helm deploy

## Vault deployment

![https://i.imgur.com/ACRqKQk.png](https://i.imgur.com/ACRqKQk.png)

- Deploy Vault
    - Init
    - Format
    - Validate
    - Plan
    - Apply (Deploy) Terraform infrastructure
    - Get public ip from Terraform output
    - Run Ansible playbook

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

---

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

## Deploy Infrastructure pipelines.

Set the secrets on Github Actions.

The secrets that you have to set are the next:

- ACR_PASSWORD: Azure Container Registry Password.
- ACR_PASSWORD_TEST: Azure Container Registry Password for the QA environment.
- ACR_SERVER: Azure Container Registry Server.
- ACR_SERVER_TEST: Azure Container Registry Server for the QA environment.
- ACR_USER: Azure Container Registry User.
- ACR_USER_TEST: Azure Container Registry User for the QA environment.
- AZ_CREDS: Azure Credentials.

Run the Pipelines on this order:

1. **Deploy QA Infrastructure in Azure**
2. **Deploy Infrastructure in Azure**
3. **Deploy Vault Infrastructure in Azure**

Enter to you Github actions, then click on the workflow and finally click on "Run workflow"

![https://i.imgur.com/x28beC4.png](https://i.imgur.com/x28beC4.png)

## Vault configuration

---

## Database Secret Engine

---

Click [here](https://learn.hashicorp.com/tutorials/vault/database-mongodb) for more documentation.

Enter to you vault address:

```bash
http://<vault_ip>:8200/ui
```

Enter the number of key shares and key threshold and click on initialialize:

![https://i.imgur.com/hU5dQQY.png](https://i.imgur.com/hU5dQQY.png)

Scroll down and click on Download keys:

![https://i.imgur.com/TOccgx7.png](https://i.imgur.com/TOccgx7.png)

After that click on "Continue to Unseal" button.

Enter the keys one by one, remember not to use the keys_base64:

![https://i.imgur.com/rryNdCw.png](https://i.imgur.com/rryNdCw.png)

After enter the 3 keys, enter the root token that is in the downloaded file and click on Sign In:

![https://i.imgur.com/PSpdsOR.png](https://i.imgur.com/PSpdsOR.png)

Now we are inside Vault.

1. Select **Enable new engine**.
    
    ![https://i.imgur.com/JJoD6E3.png](https://i.imgur.com/JJoD6E3.png)
    
2. Select **Databases** from the list, and then click **Next**.
    
    ![https://i.imgur.com/Cb7xSaa.png](https://i.imgur.com/Cb7xSaa.png)
    

Enter `mongodb` in the **Path** field.

![https://i.imgur.com/UK5WOrM.png](https://i.imgur.com/UK5WOrM.png)

Click **Enable Engine** to complete.

## Configure MongoDB secrets engine:

Select **Create connection** in the **Connections** tab for `mongodb`.

![https://i.imgur.com/a4NgocQ.png](https://i.imgur.com/a4NgocQ.png)

1. Select **MongoDB** from the **Database plugin** drop-down list.
2. Enter `pacman` in the **Connection Name** field.
3. Enter the following in the **Connection url** field:

```bash
mongodb://{{username}}:{{password}}@<EXTERNAL-IP-MONGODB-POD>:27017/admin?tls=false
```

Enter `mdbadmin` in the **Username** and `hQ97T9JJKZoqnFn2NXE` in the **Password** text fields.

![https://i.imgur.com/Hybqw3B.png](https://i.imgur.com/Hybqw3B.png)

Click on **Create database** button. When prompted, click **Rotate and enable** to continue.

![https://i.imgur.com/uRIr8R7.png](https://i.imgur.com/uRIr8R7.png)

## Create a new role:

---

Select **mongodb**.

![https://i.imgur.com/aWVlXng.png](https://i.imgur.com/aWVlXng.png)

Select the **Overview** tab.

![https://i.imgur.com/kB0cVMU.png](https://i.imgur.com/kB0cVMU.png)

Select **Create new**.

![https://i.imgur.com/JYPuukI.png](https://i.imgur.com/JYPuukI.png)

1. Enter `tester` in the **Role name** field.
2. Enter `pacman` in the **Database name** field.
3. Select **dynamic** from the **Type of role** drop-down list.

Slide the toggle switch for **Generated credential's Time-to-Live (TTL)** and **Generated credential's maximum Time-to-Live (Max TTL)** to set the value to 1 hour and 24 hours respectively.

Enter the following in the **Creation statement** field.

```bash
{
  "db": "admin",
  "roles": [
    {
      "role": "readWrite"
    },
    {
      "role": "readWrite",
      "db": "pacman"
    }
  ]
}
```

Click **Create Role** to complete.

When you return to the **pacman** configuration page, the `tester` role is added to the **Allowed roles** list.

![https://i.imgur.com/d6MHodB.png](https://i.imgur.com/d6MHodB.png)

Now, it is ready to dynamically generate database credentials to connect with the `mongodb` database.

Select the role and click on Generate credentials:

![https://i.imgur.com/EmyRLHm.png](https://i.imgur.com/EmyRLHm.png)

This presents the generated lease. Click on the *copy to clipboard* icon to copy the generated username and password.

![https://i.imgur.com/C2UTwdt.png](https://i.imgur.com/C2UTwdt.png)

## Connect to the MongoDB database using the Vault generated credentials.

Enter to pod with the following command:

```bash
kubectl exec --stdin --tty <mongo_pod> -n pacman -- /bin/bash
```

Run the following command on the mongodb pod:

```bash
mongo --username <username> --password <password>
```

Run the command:

```bash
show dbs;
use pacman
show collections 
db.highscore.find()
```

Now you are connected with the dynamic credentials.

## Approle and policies:

---

Click [here](https://learn.hashicorp.com/tutorials/vault/approle?in=vault/auth-methods) for more documentation.

Connect by SSH to your Vault VM

```bash
ssh user@ip
```

Export the token:

```bash
export VAULT_TOKEN="example_tokken"
```

```bash
vault write auth/approle/role/pacman token_policies="mongodb-kv-policy" \
    token_ttl=1h token_max_ttl=4h
```

Read the pacman role you created to verify.

```bash
vault read auth/approle/role/pacman
```

**Get RoleID and SecretID**

Execute the following command to retrieve the RoleID for the pacman role.

```bash
vault read auth/approle/role/pacman/role-id

Key        Value
---        -----
role_id    a670cd07-b82b-9703-c84a-89d803581205
```

Execute the following command to generate a SecretID for the pacman role.

```bash
vault write -force auth/approle/role/pacman/secret-id

Key                   Value
---                   -----
secret_id             b989e923-e3df-3c3e-c803-7fbc1296683d
secret_id_accessor    a1a7ca7d-d8d2-6651-d25a-18a57619c2c9
secret_id_ttl         0s
```

**Login with RoleID & SecretID**

To login, use the `auth/approle/login` endpoint by passing the RoleID and SecretID.

```bash
vault write auth/approle/login role_id="a670cd07-b82b-9703-c84a-89d803581205" \
    secret_id="b989e923-e3df-3c3e-c803-7fbc1296683d"

Key                     Value
---                     -----
token                   s.UfPk7BZGMuvwKS7GvXKzUhzd
token_accessor          KATistlM4vuKJgp45A2tSboB
token_duration          1h
token_renewable         true
token_policies          ["default" "mongodb-kv-policy"]
identity_policies       []
policies                ["default" "mongodb-kv-policy"]
token_meta_role_name    pacman
```

Enable KV Secret engine V2 by clicking on **Enable New Engine**

![https://i.imgur.com/4yjDfe6.png](https://i.imgur.com/4yjDfe6.png)

Then click on KV and next:

![https://i.imgur.com/vi8B11j.png](https://i.imgur.com/vi8B11j.png)

After that click on Enable engine:

![https://i.imgur.com/9yXUteE.png](https://i.imgur.com/9yXUteE.png)

Then create a new Secret by clicking on **Create secret +:**

![https://i.imgur.com/O4iNtEG.png](https://i.imgur.com/O4iNtEG.png)

Enter `secret/mongodb` as "Path for this secret" and the next data as secret data:

- user: mdbadmin
- password: hQ97T9JJKZoqnFn2NXE

![https://i.imgur.com/KOIm3E6.png](https://i.imgur.com/KOIm3E6.png)

Then click on save button.

Export the generated approle token 

```bash
export APP_TOKEN="s.UfPk7BZGMuvwKS7GvXKzUhzd"
```

Verify that you can access the secrets at `secret/mongodb`.

```bash
VAULT_TOKEN=$APP_TOKEN vault kv get kv/secret/mongodb
```

# Vault Agent

---

Click [here](https://medium.com/@zippoobbiz/inject-vault-secret-with-agent-3333c99c2ee9) for more documentation:

First download the repo and install with helm

```bash
helm repo add hashicorp https://helm.releases.hashicorp.com
helm install vault hashicorp/vault -n pacman
```

Unseal the vault-o pod:

```bash
kubectl exec -ti vault-0 -n pacman -- vault operator init
kubectl exec -ti vault-0 -n pacman -- vault operator unseal
```

> Remember to run the command kubectl exec -ti vault-0 -- vault operator unseal the requested times and write the keys.
> 

Run the command and enter the root token:

```bash
Forkubectl exec -ti vault-0 -n pacman -- vault login
```

Get inside the pod:

```bash
kubectl exec --stdin --tty vault-0 -n pacman -- /bin/sh
```

Create file on /home/vault/vault-config.hcl

```bash
pid_file = "./pidfile"

vault {
        address = "http://13.89.111.24:8200"
}

auto_auth {
        method "approle" {
            mount_path = "auth/approle"
            config = {
                role_id_file_path = "/tmp/role-id"
                secret_id_file_path = "/tmp/secret-id"
                remove_secret_id_file_after_reading = false
            }
        }

        sink "file" {
                config = {
                        path = "/tmp/.vault-token"
                }
        }
}

template {
  source      = "/home/vault/dbcredential.kv.ctmpl"
  destination = "/home/vault/db.credential"
}
```

Create the file /home/vault/dbcredential.kv.ctmpl with the following content:

```bash
{{ with secret "kv/data/secret/mongodb" }}
User={{ .Data.data.user }};Database={{ .Data.data.password }};
{{ end }}
```

> You have to enter the pad to your kv secrets and the name of the secrets in this format {{ .Data.data.user }}
> 

Export your vault VM address 

```bash
export VAULT_ADDR=http://<vault_vm_address>:8200
```

Finally run the following command and you have the agent running:

```bash
vault agent -config=/home/vault/vault-config.hcl
```

> The next section is optional, these task are included on the pipelines.
> 

## Build and push Docker Image

---

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
    

## Connect to Kubernetes Cluster

---

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
    

## Ansible

---

### Pre requirements:

- Having already built the VM and set the Public IP

### Start

First, create a playbook named *vault-configure.yml* to install **Vault** in the VM:

```bash
---
  - name: Install & Configure Vault
    hosts: all
    become: yes

    vars:
      vault_version: 1.9.0
      directories:
        - /etc/vault
        - /var/lib/vault/data
      directoriesOwner:
        - /etc/vault
        - /var/lib/vault
      unseal_keys_dir_output: /home/keys
      root_token_dir_output: /home/token
    
    tasks:
      - name: Get Apt Key from Hashicorp
        ansible.builtin.apt_key:
          url: https://apt.releases.hashicorp.com/gpg
          state: present

      - name: Add Repository from Hashicorp Release {{ ansible_lsb.codename }}
        ansible.builtin.apt_repository:
          update_cache: yes
          repo: "deb [arch=amd64] https://apt.releases.hashicorp.com {{ ansible_lsb.codename }} main"
          state: present
          

      - name: Update repositories cache and install Unzip & "vault" package
        apt:
          update_cache: yes
          name: "{{ item }}"
        loop:
          - vault
          - unzip
          
      - name: Download Vault binary
        uri:
          dest: /home
          url: "https://releases.hashicorp.com/vault/{{vault_version}}/vault_{{vault_version}}_linux_amd64.zip"
          

      - name: Extract vault*.zip" into /usr/local/bin/
        ansible.builtin.unarchive:
          remote_src: yes
          src: "/home/vault_{{vault_version}}_linux_amd64.zip"
          dest: /usr/local/bin/

      - name: Remove Vault zip
        ansible.builtin.file:
          path: "/home/vault_{{vault_version}}_linux_amd64.zip"
          state: absent

      - name: Create two directories for Vault
        ansible.builtin.file:
          path: "{{item}}"
          state: directory
          mode: '0755'
          recurse: yes
        with_items: "{{ directories }}"

      - name: Create vault user
        ansible.builtin.user:
          name: vault
          home: /etc/vault
          groups:
            - sudo
          shell: /bin/false
          system: yes
      
      - name: Give ownership to Vault of binaries+
        ansible.builtin.file:
          path: "{{item}}"
          state: directory
          recurse: yes
          owner: vault
          group: vault
          mode: '0766'
        with_items: "{{ directoriesOwner }}"

      - name: Copy vault service file
        ansible.builtin.copy:
          src: "{{item.src}}"
          dest: "{{item.dest}}"
          owner: vault
          group: vault
          mode: '0766'
        with_items:
          - { src: './vault.service', dest: '/etc/systemd/system/vault.service' }
          - { src: './config.hcl', dest: '/etc/vault/config.hcl' }

      - name: Export IP to ansible
        ansible.builtin.lineinfile:
          path: /etc/environment
          insertafter: EOF
          state: present
          line: 'VAULT_ADDR="http://{{ inventory_hostname }}:8200"' 

      - name: Remove Vault data
        ansible.builtin.file:
          path: /var/lib/vault/data
          state: absent
          force: yes

      - name: Start Vault Service
        ansible.builtin.systemd:
          state: started
          daemon_reload: yes
          name: vault
          enabled: yes
```

Second, create config file:

```bash
disable_cache = true
disable_mlock = true
ui = true
listener "tcp" {
   address          = "0.0.0.0:8200"
   tls_disable      = 1
}
storage "file" {
   path  = "/var/lib/vault/data"
 }

api_addr         = "https://0.0.0.0:8200"
max_lease_ttl         = "10h"
default_lease_ttl    = "10h"
cluster_name         = "vault"
raw_storage_endpoint     = true
disable_sealwrap     = true
disable_printable_check = true
```

Then, create *vault.service* file:

```bash
Unit]
Description="HashiCorp Vault - A tool for managing secrets"
Documentation=https://www.vaultproject.io/docs/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/vault/config.hcl

[Service]
User=vault
Group=vault
ProtectSystem=full
ProtectHome=read-only
PrivateTmp=yes
PrivateDevices=yes
SecureBits=keep-caps
AmbientCapabilities=CAP_IPC_LOCK
NoNewPrivileges=yes
ExecStart=/usr/local/bin/vault server -config=/etc/vault/config.hcl
ExecReload=/bin/kill --signal HUP 
KillMode=process
KillSignal=SIGINT
Restart=on-failure
RestartSec=5
TimeoutStopSec=30
StartLimitBurst=3
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
```
- And *inventory.in* file, this is empty because it will be filled once the playbook has been run:
````
[all]
```

Finally, execute the command:

```bash
ansible-playbook ./ansible/vault-configure.yml --inventory=VM_PUBLIC_IP --extra-vars "ansible_user=VM_USERNAME ansible_password=VM_PASSWORD"
```

> Just to point out: Do not miss the parameter in the command above to set the host, and to add the user and password.
>