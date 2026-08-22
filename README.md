# 2-Tier Application Deployment on AWS Using Terraform

## Project Overview

This project demonstrates how to deploy a **2-tier application architecture on AWS using Terraform**.

The infrastructure is provisioned using **Infrastructure as Code (IaC)** principles, allowing cloud resources to be created, managed, and maintained in a repeatable and automated way.

The project includes AWS networking, compute resources, database infrastructure, domain configuration, SSL certificates, and remote Terraform state management.

---

## Architecture

The infrastructure follows a **2-tier architecture**:

### Application Tier

* Amazon EC2 instances
* Application deployment
* Public-facing infrastructure
* Load balancing and networking

### Database Tier

* Private database infrastructure
* Secure communication with the application layer
* Database credentials managed through Terraform variables

The architecture is deployed inside a custom AWS VPC with public and private subnets.

---

## 🛠️ Technologies Used

* **AWS**
* **Terraform**
* **Amazon EC2**
* **Amazon VPC**
* **Amazon S3**
* **Amazon DynamoDB**
* **Linux**
* **SSH**

---

## 📂 Project Structure

```text
.
├── modules/
│   ├── key/
│   ├── networking/
│   ├── compute/
│   ├── database/
│   └── other infrastructure modules
│
├── root/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── backend.tf
│   └── terraform.tfvars
│
└── README.md
```

---

# ⚙️ Prerequisites

Before deploying this project, make sure you have:

* An AWS Account
* AWS CLI installed and configured
* Terraform installed
* SSH installed

---

# 🔐 Configure AWS Credentials

Configure your AWS credentials using:

```bash
aws configure
```

Verify the configured AWS account:

```bash
aws sts get-caller-identity
```

---

# 🗄️ Configure Terraform Remote Backend

Terraform state is stored remotely using:

* **Amazon S3** for Terraform state storage
* **Amazon DynamoDB** for state locking

## Step 1: Create an S3 Bucket

Create an S3 bucket to store the Terraform state file.

It is recommended to enable **versioning** on the bucket to recover previous versions of the state file if required.

---

## Step 2: Create a DynamoDB Table

Create a DynamoDB table for Terraform state locking.

Use:

```text
Partition Key: LockID
Type: String
```

---

## Step 3: Configure `backend.tf`

Update the `root/backend.tf` file:

```hcl
terraform {
  backend "s3" {
    bucket         = "YOUR_BUCKET_NAME"
    key            = "backend/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "YOUR_DYNAMODB_TABLE"
  }
}
```

---

# 🔑 Generate SSH Key Pair

Navigate to the key module:

```bash
cd modules/key
```

Generate an SSH key pair:

```bash
ssh-keygen
```

This will generate:

```text
Private Key
Public Key
```

Make sure the generated key name matches the configuration used in your Terraform files.
---

# 📝 Configure Terraform Variables

Create or update the following file:

```text
root/terraform.tfvars
```

Add your infrastructure configuration:

```hcl
region = "us-east-1"

project_name = "my-project"

vpc_cidr = "10.0.0.0/16"

pub_sub_1a_cidr = "10.0.1.0/24"
pub_sub_2b_cidr = "10.0.2.0/24"

pri_sub_3a_cidr = "10.0.3.0/24"
pri_sub_4b_cidr = "10.0.4.0/24"

pri_sub_5a_cidr = "10.0.5.0/24"
pri_sub_6b_cidr = "10.0.6.0/24"

db_username = "admin"
db_password = "your-secure-password"
```

> ⚠️ **Important:** Do not push sensitive values such as database passwords or private keys to GitHub.

---

# 🚀 Deployment Steps

Navigate to the root directory:

```bash
cd root
```

## 1️⃣ Initialize Terraform

```bash
terraform init
```

## 2️⃣ Validate Configuration

```bash
terraform validate
```

## 3️⃣ Format Terraform Files

```bash
terraform fmt -recursive
```

## 4️⃣ Review the Execution Plan

```bash
terraform plan
```

## 5️⃣ Deploy Infrastructure

```bash
terraform apply
```

Type:

```text
yes
```

when prompted to confirm the deployment.

---

# 🧹 Destroy Infrastructure

To avoid unnecessary AWS charges, destroy all resources when you are finished:

```bash
terraform destroy
```

Type:

```text
yes
```

to confirm.

---

# 🔒 Security Considerations

* Do not commit `.tfstate` files to GitHub.
* Do not commit AWS credentials.
* Do not expose database passwords.
* Store sensitive values using AWS Secrets Manager or environment variables.
* Restrict Security Group rules to only required ports and IP addresses.
* Keep EC2 instances and dependencies updated.

---

# 📚 Key Learnings

Through this project, I gained hands-on experience with:

* Infrastructure as Code using Terraform
* AWS VPC and subnet architecture
* Terraform modules
* Remote state management using S3
* State locking using DynamoDB
* SSH key management
* Deploying multi-tier cloud infrastructure
* Terraform workflow: `init`, `plan`, `apply`, and `destroy`

---

# 👨‍💻 Author

**Dhairyashil Ramesh Suryawanshi**

**DevOps / Cloud Engineer**

### Skills

* AWS Cloud
* Terraform
* Linux
* Git & GitHub
* Docker
* Kubernetes
* CI/CD
* Jenkins

---

⭐ If you found this project useful, consider giving it a star!
