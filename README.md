DevOps Project
This project aims to complete a series of tasks related to DevOps practices. Below are detailed instructions for each task.

Task 1
Project Structure
lua
Copy code
|-- app1
|   |-- src
|   |-- build
|   |-- deploy
|   |-- Jenkinsfile
|   |-- readme.md

|-- app2
|   |-- src
|   |-- build
|   |-- deploy
|   |-- Jenkinsfile
|   |-- readme.md

|-- nginx
|   |-- deploy
|   |-- infra
|   |-- config (contains files to set up lightweight cluster)
|   |-- readme.md

|-- readme.md

Instructions
Create a full project with code, deployment YAML, and Jenkinsfile in a GitHub/Gitlab/Bitbucket repository.
Use Laravel's latest PHP code and create two Dockerfiles to build images displaying static HTML pages for App 1 and App 2.
Host these Docker images publicly on Dockerhub.
Create separate Kubernetes deployment, config map, and service YAML files. Service should be nodeport.
Include an Nginx deployment to serve App1 or App2 based on the API address.
Deploy applications in a lightweight Kubernetes distribution (Kind, Minikube, K3s, K0s) with a 1 master and 2 nodes cluster.
Use node labels or taints/tolerations to force App1 on node1 and App2 on node2.
Create a Docker Compose file that runs a Jenkins container.
Create 2 Jenkinsfiles for building and deploying the applications into your lightweight cluster.
Provide step-by-step instructions for setting up the lightweight Kubernetes distribution.
Include instructions to set up 2 Jenkins pipelines using Jenkinsfile from your public repository.
Explain how to customize Kubernetes deployment files to use Docker images built by the Jenkins pipeline.
Prepare a readme for anyone to start Jenkins container, create pipelines, download code, build, and push to Dockerhub.
Provide separate instructions to deploy Nginx and update its config to point to App1 and App2.
Address common anti-patterns, security concerns, and suggest how the solution can be scaled up.
Bonus points for successfully integrating any service mesh for API traffic routing.
Task 2
Instructions
Create a Kubernetes cluster with 1 master and 2 worker nodes using Vagrant or LXC/LXD containers.
Use Ansible or any configuration management tool to download Kubernetes binaries and install them.
Create a kubeadm config file and use kubeadm to bootstrap the Kubernetes cluster.
Choose a CNI and deploy it using configuration management scripts.
Deploy Kubernetes dashboard and metric server, exposing them to nodeport.
Create a service account with the right privileges and provide an RBAC file to access the Kubernetes dashboard.
Host everything in a public git repo with appropriate readme.
Provide instructions to set up Vagrant or LXC/LXD containers.
Include Ansible or other configuration management tool scripts for installation, configuration, CNI deployment, dashboard, metric server, and RBAC.
Task 3
Instructions
Create a public Git repo for readme files and diagrams.
Design a highly available microservices architecture deployment solution.
Use infrastructure as code or GitOps methodologies.
Consider load balancing, single points of failure, scalability, fault tolerance, and auto-recovery.
Include CI/CD strategies, tool justification, test automation, and security as pipeline concepts.
Describe observability across the entire architecture and tools used.
Provide logging, alerting strategies, and outage handling.
Integrate knowledge base, configurations, and secrets management with the system.
Justify whether the application is on-premise, in the cloud, or hybrid.
Explain advantages of selected tools and strategies over others in the market.
Optionally include a diagram of the proposed architecture.
