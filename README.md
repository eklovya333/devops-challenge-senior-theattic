# 🧩 **Minimalist Application with Docker, NGINX, and GKE (Terraform)**

## 📌 Overview

This repository demonstrates the complete lifecycle of a minimalist Node.js application — from local Docker development to cloud deployment on Google Kubernetes Engine (GKE) using Terraform.

It includes:

- A containerized Node.js time service (`SimpleTimeServiceApp`)
- An NGINX reverse proxy
- Infrastructure as Code with Terraform for deploying a GKE Autopilot cluster
- Kubernetes manifests for app and proxy deployment

---

## 🧱 TASK 1: Minimalist Application Development (Docker + NGINX)

### 🔹 Run Node.js Application Locally

1. Navigate to the Node.js app folder:

   ```bash
   cd app/SimpleTimeServiceApp

2. Build the Docker image:

  ```bash
  docker build -t <image-name> .```
```
3. Run the container:

```bash
docker run -ti -p <port>:<port> <image-name>
```
This will start the Node.js server and return the expected response.

###🔹 Run Application Behind NGINX (Locally)
1. Navigate to the NGINX configuration folder:

  ```bash
  cd app/nginx
```
2. Build the NGINX Docker image:

  ```bash
  docker build -t <nginx-image-name> .
```
3. Edit the docker-compose.yaml file to update the image name under the nginx service.Start the NGINX reverse proxy with Docker Compose:

  ```bash
  docker-compose up
```
4. Access the application via:

  ```bash
  http://localhost:8080
```


## ☁️ TASK 2: Terraform and Cloud Infrastructure (GCP Autopilot Cluster)
###🔹 Set Up GKE Autopilot Cluster

1. Navigate to the Terraform folder:

  ```bash
  cd terraform
```
2. Update the following variables in terraform.tfvars:

  - project_id

  - billing_account_id

  - owner_email

3. Initialize and plan the deployment:

  ```bash
  terraform init
  terraform plan
```
4. Apply the configuration to provision the cluster:

  ```bash
  terraform apply
```
###🔹 Deploy Node App & NGINX on GKE
1. Navigate to the app-deployment folder:

  ```bash
  cd app-deployment
  ```
2. Apply Kubernetes manifests:

  ```bash
  kubectl apply -f nodeapp-deployment.yaml
  kubectl apply -f nodeapp-service.yaml
  kubectl apply -f nginx-deployment.yaml
  kubectl apply -f nginx-service.yaml
  ```

3. In Google Cloud Console:

Go to Kubernetes Engine > Services & Ingress

Locate the nginx-service

Click the endpoint URL to view the application response

✅ Notes
- The NGINX service is exposed via a LoadBalancer, while the Node.js service uses ClusterIP

- Make sure your GKE cluster is configured and kubectl is authenticated before applying manifests

- The current Docker images in docker-compose.yaml point to public DockerHub repositories; customize as needed
