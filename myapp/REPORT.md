# 📊 DevOps Pipeline Case Study – Project Report

## ✅ Project Summary

This case study demonstrates an end-to-end DevOps pipeline that builds, tests, provisions, configures, and deploys a simple Node.js application on an AWS EC2 instance using Docker, Terraform, Ansible, Jenkins, GitHub, and shell scripting.

The pipeline is triggered via GitHub, which initiates Jenkins to build and push a Docker image, provision infrastructure via Terraform, and deploy the app using Ansible on an EC2 instance running on AWS Free Tier.

---

## 📌 Architecture Overview

1. **Developer pushes code** → GitHub (`develop` branch)
2. **Jenkins pipeline triggers** → clones code
3. **Docker image is built** → pushed to DockerHub
4. **Terraform runs** → creates AWS EC2 instance, security groups, VPC, subnet, Elastic IP
5. **Ansible connects to EC2** → installs Docker, pulls image, runs container
6. **User accesses app** via public IP → response: "Hello from Dockerized Node.js App!"

                     +------------------+
                     |   Developer PC   |
                     | (Code, Git Push) |
                     +--------+---------+
                              |
                              | 1. Git Push (code, Dockerfile, scripts)
                              v
                    +---------+----------+
                    |      GitHub        |
                    | (Code Repository)  |
                    +---------+----------+
                              |
                              | 2. Webhook / Poll
                              v
         +--------------------+--------------------+
         |                 Jenkins CI/CD           |
         |         (Local or EC2 Jenkins Server)   |
         +--------------------+--------------------+
                              |
                              | 3. Docker Build & Push
                              v
                    +--------+--------+
                    |   Docker Engine |
                    | (On Jenkins VM) |
                    +--------+--------+
                              |
                              | 4. (Simulated) Push to DockerHub
                              |
                              | 5. Terraform Provisioning
                              v
                   +----------+-----------+
                   |       AWS Cloud      |
                   |    (via Terraform)   |
                   +----------+-----------+
                              |
                +-------------+-------------+
                |                           |
        +-------v--------+         +--------v-------+
        |  VPC & Subnet  |         |   Security     |
        |   (main.tf)    |         |    Groups      |
        +-------+--------+         +--------+-------+
                |                           |
                | 6. EC2 Instance Provision |
                v
         +------+-------+
         |   EC2 (t2.micro)
         |   Amazon Linux 2
         +------+-------+
                |
                | 7. Ansible SSH into EC2
                v
         +------+-------+
         |    Docker    |  <--- installed by Ansible
         +------+-------+
                |
                | 8. Pull image & run container
                v
         +------+--------------------+
         | Node.js App in Container |
         |   (Port 3000 → 80)       |
         +--------------------------+


---

## 🌿 Git Branching Strategy

- `main`: Stable, production-ready branch. Protected from direct pushes.
- `develop`: Active development branch. Features are merged here.

All merges to `main` must come via reviewed Pull Requests from `develop`.

---

## 🐳 Dockerization

The Node.js app is packaged inside a Docker container. The Dockerfile defines the base image (`node:18-alpine`), installs dependencies, and sets the container to expose port 3000. A shell script automates the build and push of the image to DockerHub.

Docker enables consistent and portable deployment across environments.

---

## ☁️ Terraform Provisioning

Terraform is used to define and provision AWS infrastructure as code. The Terraform configuration does the following:

- Creates a custom VPC and public subnet
- Launches a `t2.micro` EC2 instance with a static Elastic IP
- Attaches a security group allowing HTTP (port 80) and SSH (port 22)
- Outputs the public IP address of the instance

AWS Infrastructure

```
AWS Infrastructure
└── VPC (10.0.0.0/16)
    └── Public Subnet (10.0.1.0/24)
        └── EC2 Instance (t2.micro)
            ├── Elastic IP (e.g., 13.234.123.45)
            └── Security Group
                ├── Allow SSH (22)
                └── Allow HTTP (80)
```



All configurations are modular, using variables for AWS region, instance type, and key pair name. The output is used by Ansible for remote access.

---

## 🛠️ Ansible Configuration

Ansible connects to the newly created EC2 instance using SSH and performs configuration tasks, including:

- Installing Docker on the EC2 instance
- Pulling the pre-built Docker image from DockerHub
- Running the container on port 80 (mapped to app's 3000)

The inventory file (`hosts.ini`) includes the EC2's public IP, and the playbook (`deploy.yml`) defines all the deployment tasks in a repeatable, automated manner.

---

## 🔄 Jenkins CI/CD Pipeline

Jenkins orchestrates the entire CI/CD process using a scripted pipeline defined in the `Jenkinsfile`. It performs the following stages:

1. **Checkout** – Clones the code from the `develop` branch
2. **Docker Build & Push** – Executes the build-and-push script
3. **Terraform Apply** – Provisions infrastructure using Terraform scripts
4. **Ansible Deploy** – Runs Ansible playbook to deploy the app to the EC2

Jenkins runs either locally or on an EC2 VM and integrates with Docker, GitHub, Terraform, and Ansible via appropriate plugins and CLI tools.

---

## ⚙️ Shell Scripts

Two shell scripts are used in the pipeline:

- **`build_and_push.sh`**: Builds the Docker image and pushes it to DockerHub using the latest Git commit hash as a tag. Enables consistent versioning and reuse.
- **`cleanup.sh`**: Cleans up unused Docker images, containers, and networks. Helps prevent disk space issues during development or CI runs.

Both scripts are written with error handling and logging using `set -euo pipefail` for robustness.

---

## 📂 Folder Structure Explanation

- `src/` – Contains the application source code (Node.js app)
- `Dockerfile` – Describes how to build the Docker image
- `package.json` – Contains metadata and dependencies for the app
- `scripts/` – Shell scripts for build/push and cleanup
- `infra/` – Terraform code for AWS infrastructure provisioning
- `ansible/` – Hosts inventory and Ansible playbook for deployment
- `Jenkinsfile` – Jenkins pipeline definition
- `REPORT.md` – This documentation/report file
  
---

## 🔐 Security Best Practices

- Do NOT commit AWS credentials or `.pem` keys to GitHub
- Use Jenkins credentials manager or environment variables for secrets
- Add sensitive files to `.gitignore`:  
  - `terraform.tfstate`  
  - `*.pem`  
  - `*.log`  
  - `.env`

---

## ✅ Conclusion

This project simulates a real-world CI/CD pipeline implementation using a cloud-native stack. It automates the entire software delivery process—from code push to production deployment—using open-source DevOps tools and Infrastructure as Code (IaC).

It’s scalable, maintainable, and fully reproducible, offering hands-on experience with every stage of modern DevOps.
