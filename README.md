# 🌐 Terraform VPC Project – Scalable Web Application Infrastructure

This project provisions a scalable and highly available infrastructure on AWS using **Terraform**, with a modular and automated approach.

---

## 📦 Features

- Custom **VPC** with Public and Private Subnets across 2 Availability Zones.
- Public EC2 Instances running **Nginx Reverse Proxy**.
- Private EC2 Instances hosting **Web Application Backends** (e.g., Flask or Node.js).
- **Public ALB** → Routes traffic to Nginx proxies.
- **Internal ALB** → Routes traffic to backend app instances.
- **NAT Gateway** for private instances to access the internet.
- **Internet Gateway** for public access.
- **Security Groups** for strict layer-to-layer access control.
- **Terraform Workspaces** to manage different environments (dev, staging, prod).
- **Remote Backend** using **S3** and **DynamoDB** for state management.
- **Provisioners** (`file`, `remote-exec`, `local-exec`) for post-provision configuration.
- Use of **Data Sources** to fetch the latest AMIs dynamically.

---

## 🧠 Architecture Diagram

```mermaid
flowchart TD
    IGW[Internet Gateway] --> RT1[Route Table for Public Subnet]
    RT1 --> Pub1[Public Subnet 1]
    RT1 --> Pub2[Public Subnet 2]

    Pub1 --> EC2A[Nginx Reverse Proxy 1]
    Pub2 --> EC2B[Nginx Reverse Proxy 2]

    EC2A & EC2B --> ALB[Public Application Load Balancer]

    VPC --> NAT[NAT Gateway]
    NAT --> RT2[Route Table for Private Subnet]
    RT2 --> Priv1[Private Subnet 1]
    RT2 --> Priv2[Private Subnet 2]

    Priv1 --> APP1[Web App Instance 1]
    Priv2 --> APP2[Web App Instance 2]

    APP1 & APP2 --> ALB_INT[Internal ALB]

    subgraph "Terraform Infra"
        direction LR
        Workspace["Terraform Workspaces"]
        Modules["Custom Modules"]
        Backend["Remote Backend (S3 + DynamoDB)"]
        Provisioners["Provisioners"]
    end
