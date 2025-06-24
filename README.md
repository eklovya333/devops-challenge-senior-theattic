Minimalist Application with Docker, NGINX, and GKE (Terraform)
📌 Overview
This repository demonstrates the complete lifecycle of a minimalist Node.js application — from local Docker development to cloud deployment on Google Kubernetes Engine (GKE) using Terraform.
It includes:
1.A containerized Node.js time service (SimpleTimeServiceApp)
2.An NGINX reverse proxy
3.Infrastructure as Code with Terraform for deploying a GKE Autopilot cluster

Kubernetes manifests for app and proxy deployment

🧱 TASK 1: Minimalist Application Development (Docker + NGINX)
🔹 Run Node.js Application Locally
Navigate to the Node.js app folder:
cd app/SimpleTimeServiceApp

Build the Docker image:
docker build -t <image-name> .

Run the container:
docker run -ti -p <port>:<port> <image-name>
This will start the Node.js server and return the expected response.

🔹 Run Application Behind NGINX (Locally)
Navigate to the NGINX configuration folder:
cd app/nginx

Build the NGINX Docker image:
docker build -t <nginx-image-name> .

Edit the docker-compose.yaml file to update the image name under the nginx service.

Start the NGINX reverse proxy with Docker Compose:
docker-compose up

Access the application via:
http://localhost:8080


☁️ TASK 2: Terraform and Cloud Infrastructure (GCP Autopilot Cluster)
🔹 Set Up GKE Autopilot Cluster
Navigate to the Terraform folder:
cd terraform

Update the following variables in terraform.tfvars:
1.project_id
2.billing_account_id
3.owner_email

Initialize and plan the deployment:
terraform init
terraform plan

Apply the configuration to provision the cluster:
terraform apply


🔹 Deploy Node App & NGINX on GKE
Navigate to the app-deployment folder:
cd app-deployment


Apply Kubernetes manifests:
kubectl apply -f nodeapp-deployment.yaml
kubectl apply -f nodeapp-service.yaml
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml


In Google Cloud Console:

Go to Kubernetes Engine > Services & Ingress
Locate the nginx-service
Click the endpoint URL to view the application response

✅ Notes
The NGINX service is exposed via a LoadBalancer, while the Node.js service uses ClusterIP

Make sure your GKE cluster is configured and kubectl is authenticated before applying manifests

The current Docker images in docker-compose.yaml point to public DockerHub repositories; customize as needed
