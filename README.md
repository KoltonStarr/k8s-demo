# Kubernetes 101

## Overview & Goals (Kolton)
- To see the full lifecycle of developing an application and then deploying it to K8s.
- Technical, brief, to the point.

## Caveat (Kolton & David)
- Kubernetes has a steep learning curve in my opinion. When I was first learning, the concepts just don't stick really well at first. If we were demoing features of a new programming language it would probably be easier because we all know what for loops are, data types, etc. So a lot of this material might seem like a bit of a black hole at first and it might be hard to connect the concepts to your day-to-day development. Nonetheless, its still valuable information!

## Brief History of K8s. (Kolton)
- Invented by Google. It was originally called "Borg". 
- It was designed to solve a very specific problem for them. They had TONS of services and not an easy way to orchestrate and manage them. Thus K8s was born. 
- K8s is open source because google opened it up to the public and it is managed by the CNCF (Cloud Native Compute Foundation). 
- Even though it was designed to solve container orchestration at scale it IS also a good choice for small projects too (I don't want to go too deep on this topic). 

## What is EKS? (David)
- A wrapper for K8s specififc to AWS and integrated deeply with AWS services and capabilities. 
- You do NOT need EKS to have a fully functioning cluster. Though, most cloud providers have a managed service available for you to use. It is a PAIN to setup a cluster from scratch. 
- I don't want to cover this too much because this could be an entire talk of it's own. 

## Benefits of using K8s vs. other solutions. (David)
- K8s magnifies the benefits of containers. It is an incredibly useful framework to deploy and manage containerized applications.
- With K8s, we can make our applications more resilient, secure, highly scalable, and self healing. These attributes are not often present in traditional network systems.

## Startup: Architecture (David)
- Worker Nodes. 
- EKS manages the control plane for us so we won't see that. In a self-managed cluster you would see the control plane.
- Worker Node security group that allows access to a particular port that we want to expose (31127). 
- Target group that collects all the nodes and will forward traffic to that port. 
- NLB that forwards traffic on port 80 to the worker nodes on the port (just HTTP). 
- Registered domain name with an A record that points at our NLB. 

## Phase 1: Application Development. (Kolton)
- A simple Rust webserver that serves an image of Benjamin (image by ChatGPT).
- run it locally to see it working.

## Phase 2: Containerizing the Application. (Kolton)
- We are not going to do a deep dive into exactly HOW containers work but for the sake of this demo lets just think of containers as just enough of an operating system to do a single task. 
- K8s makes no sense if workloads are not containerized. It IS, after all, a conatiner orchestration technology. So we need to containerize our application. 
- Run commands and build container.
- Run the container locally and see it working.
- Shell into the container just to poke around and prove the container has its own self-contained file system.

## Phase 3: Pushing the Image to an Image Registry. (Kolton)
- There are many different registries that you can use. Docker HUB is a prime example. Another example would be to use your own AWS ECR registry. In this case we have a public registry setup and we will push to that since there is nothing really secret about our image here. 

## Phase 4: PODS! Creating a K8s Pod. (David)
- Pods are arguably the smalling building block in K8s. A Pod is NOT a container but rather another small layer on top of the running container that allows K8s to do K8s-specifc things with the containers and the container filesystem. There is a really good piece of documentation on this in the K8s doc which I can send out if anyone is interested but I do not want to spend too much time on HOW Pods work. 
- Define the pod manifest file and then apply it.

## Phase 5: SERVICES! Exposing workloads (Pods) with a K8s Service (NodePort). (David)
- We have our Pod running but we don't actually have a way to access it from the outside. This is where K8s services come in. Services are a way of exposing your workloads. They are effectively just virtual IPs in front of a set of Pods and they load balance traffic to the pods. K8s manages all of this for you. 

## Phase 6: DEPLOYMENTS! The problem with using Pods without K8s Deployments. The self-healing nature of K8s. (Kolton)
- Let's first see the problem with using Pods directly by terminating our Pod. 
- Now we have an outage. Our webserver is down and it will not come back up without manual intervention. 
- We will create our Deployment which will allow us to get back to the exact same state where we can access the webserver from the outside and see the image. 
- Then we can look and see that now we also have something called a ReplicaSet. 
- Let's terminate one of the Pods and see that now we have a self-healing workload up and running! This is becuase of the ReplicaSet!

THE END

## Beyond Today: Deep-dive into certain topics. SO MUCH TO LEARN! (David & Kolton)
- WHY K8s for smaller projects? 
- AWS Architecture deep-dive (Route53, DNS, Load Balancers, Nodes, EC2, Security Groups, etc.)
- EKS deep-dive (integrations, capabilities, why EKS vs. bare-bones K8s?, etc.)
- Docker deep-dive (how do containers work, containers vs. VMs, etc.)
- Deep-dive into K8s Pods (Why does K8s need a Pod to wrap a container?, what else does K8s do to containers inside the pods?, etc.)
- Services deep-dive (service discovery, virtual IPs, different types of services, integrations with cloud providers, etc.)
- Cluster networking and PKI.
- Other K8s objects like Jobs. 
- Ingress and Gateway API (VERY important topic)
- The actual components and building blocks of what makes a cluster a "cluster". What does that mean? 
- Helm charts! (VERY important topic).
- How does kubectl work? 
- Cluster authentication.
- Automation (VERY important topic)

## Learning Value-add for Developers. (David & Kolton)
- Makes you so much better as an I.T. professional. 
- Stresses knowledge of networking. How do the different component
- Stresses knowledge of TLS/SSL and PKI. 
- Stresses knowledge of containerization. 
- Stresses knowledge of Linux. 
- Stresses knowledge of cloud technology and services. 
- Stresses knowledge of automation and how to easily automate releases to a K8s environment.

## Questions??

## Link to Excalidraw
[Link](https://link.excalidraw.com/l/9gXXTGorvoH/8xmKmEDgteP)