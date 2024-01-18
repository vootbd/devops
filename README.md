# DevOps 


## Task 1
Create a full project with code, deployment yaml and jenkinsfile in a github/gitlab/bitbucket repository.

Source should be php laravel latest code. You will take that code and make 2 dockerfile to
create 2 docker image that displays following static html pages,

App 1 browser output: Hello I am App 1
App 2 browser output: Hello I am App 2

Host these docker images in your dockerhub account publicly. Create separate kubernetes
deployment, configmap, service yaml files. Service should be nodeport.

Include a nginx deployment that will serve app1 or app2 based on api address. Use nginx official image and mount configmap to change configuration.
http://nodeip:nodeport/app1 displays app1
http://nodeip:nodeport/app2 displays app2

Deploy these applications in a lightweight kubernetes distribution of your choice. Kind, minikube,
k3s, k0s. Cluster should be 1 master and 2 nodes. Force app1 in node1 and app2 in node2 with
node labels or taints/tolerations, nginx can stay anywhere. Use configmaps for any environment
variables.

Create a docker compose file that runs a jenkins container. Create 2 jenkinsfile that builds and
deploys these 2 applications into your choice of lightweight cluster in your local machine.
Your solution should include step by step instruction to setup lightweight kubernetes distribution,
Your solution should include how to setup 2 jenkins pipelines that use jenkinsfile from your
public repository.

Your solution should include how to customize kubernetes deployment files to use docker
images built by the jenkins pipeline

Prepare readme in such way that anyone can start jenkins container using docker compose,
create 2 pipelines with your instructions, download your code using jenkinsfile from your public
repo, build code and push to their dockerhub account (show the way to input credentials to push
to dockerhub but DO NOT provide any of your credentials anywhere) and use those docker
images with kubernetes yaml files to deploy app1 and app2 into the lightweight cluster. You can
provide separate instructions to deploy nginx and update its config to point to app1 and app2.
Please keep in mind common anti-patterns, security concerns and suggest how your solution
can be scaled up in future. BONUS point for anyone that can successfully integrate any service
mesh to handle api traffic routing from kubernetes end.

Your folder structure should look like the following, src for source codes, build for dockerfile and
related settings, deploy for kubernetes yaml files.

directory root
----app1
----src
----build
----deploy
----Jenkinsfile
----readme.md

----app2
----src
----build
----deploy
----Jenkinsfile
----readme.md

----nginx
----deploy
----readme.md

----infra
----config (contains the files to setup lightweight cluster)
----readme.md

----readme.md

## Task 2
Create 1 master and 2 worker kubernetes cluster using vagrant or lxc/lxd containers. Use
ansible or any configuration management tool of your choice to download kubernetes binaries
and install into those vms/containers. Create a kubeadm config file and use kubeadm to
bootstrap kubernetes cluster using that configuration management tool. You can combine binary
installation and configuration scripts or keep them separate.
Use CNI of your choice but it should be deployed using configuration management scripts
(ansible or other)
Deploy kubernetes dashboard and metric server in this cluster and expose it to nodeport.
Create a service account with the right privilege (provide RBAC file) to access kubernetes
dashboard. Host it into a public git repo with appropriate readme.
Your solution should contain instructions to setup vagrant or lxc/lxd containers.
Your solution should contain ansible or other configuration management tool scripts to install,
configure cluster, cni, deploy dashboard, metric server and create service account with rbac.
Task 3
Create a public git repo which will contain readme files and diagrams. You can combine them
together or keep separate according to section.
Design a highly available microservices architecture deployment solution. Your application may
reside on-premise or can be in the cloud or hybrid.
Your solution should use infrastructure as code or gitops methodologies.
Your solution should use proper loadbalancing, single point of failure, scalability, fault tolerance,
auto recovery considerations.
Your solution should include CI/CD strategies and tool justification along with test automation
and security as pipeline concepts.
Your solution should describe how observability across the whole architecture will be maintained
and what tools will be used.
Your solution should provide logging, alerting strategies and how outage should be handled.
Your solution should include ways for knowledgebase and configurations, secrets management
to be integrated with the system.
You can imagine any sector software system you like (e-commerce, telecom, ride sharing etc)
but provide justification for why it is on-premise or in cloud or maybe hybrid. Provide advantages
of tools and strategies that you selected over others in the market.
A diagram of the proposed architecture would be wonderful but not strictly required. Try to
address all the points in easy to understand English in your readme file or files
