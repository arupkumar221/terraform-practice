# 🚀 Terraform AWS Aurora MySQL Cluster

![Terraform](https://img.shields.io/badge/Terraform-v1.5+-623CE4?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-RDS-orange?logo=amazonaws)
![Aurora](https://img.shields.io/badge/Aurora-MySQL-blue)
![License](https://img.shields.io/badge/License-MIT-green)

---

# 📌 Project Overview

This project provisions an **Amazon Aurora MySQL Cluster** using **Terraform** on AWS.

The infrastructure includes:

- Custom VPC
- Internet Gateway
- Public Subnet
- Two Private Subnets
- Route Table
- Security Group
- DB Subnet Group
- Aurora MySQL Cluster
- Writer Instance
- Reader Instance

---

# 🏗️ Architecture

```

                        AWS
                         │
                  Custom VPC
                         │
      ┌──────────────────┴──────────────────┐
      │                                     │
 Public Subnet                     Private Subnets
                                        │
                          ┌──────────────┴─────────────┐
                          │                            │
                    Aurora Writer               Aurora Reader
                          │
                   Shared Aurora Storage

```

---

# 📁 Project Structure

```

terraform-aws-aurora-mysql/
│
├── main.tf
├── provider.tf
├── versions.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── .gitignore
└── README.md

```

---

# ⚙️ AWS Resources Created

- VPC
- Internet Gateway
- Public Subnet
- Private Subnet 1
- Private Subnet 2
- Route Table
- Route Table Association
- Security Group
- Aurora DB Subnet Group
- Aurora MySQL Cluster
- Writer Instance
- Reader Instance

---

# 🛠 Technologies Used

- Terraform
- AWS
- Amazon Aurora MySQL
- Amazon VPC
- Security Groups
- Git
- GitHub

---

# 🌎 AWS Region

```

us-east-1 (N. Virginia)

```

---

# 📋 Prerequisites

Before running the project, install:

- Terraform
- AWS CLI
- Git

Configure AWS CLI

```bash
aws configure
```

Enter:

```

AWS Access Key
AWS Secret Key
Region = us-east-1
Output = json

```

---

# 🚀 Deployment Steps

### Clone Repository

```bash
git clone https://github.com/<your-github-username>/terraform-aws-aurora-mysql.git
```

---

### Move into Project

```bash
cd terraform-aws-aurora-mysql
```

---

### Initialize Terraform

```bash
terraform init
```

---

### Validate Configuration

```bash
terraform validate
```

---

### Format Terraform Files

```bash
terraform fmt
```

---

### Review Execution Plan

```bash
terraform plan
```

---

### Deploy Infrastructure

```bash
terraform apply
```

Type

```

yes

```

---

Terraform will create:

- VPC
- Networking
- Security Group
- Aurora Cluster
- Writer
- Reader

---

# 📤 Outputs

Terraform returns:

- VPC ID
- Public Subnet ID
- Private Subnet IDs
- Security Group ID
- Aurora Cluster Endpoint
- Reader Endpoint
- Writer Instance ID
- Reader Instance ID

---

# 🧹 Destroy Infrastructure

```bash
terraform destroy
```

---

# 📷 AWS Console Verification

Verify the following resources in AWS Console:

- VPC
- Subnets
- Route Tables
- Security Group
- DB Subnet Group
- Aurora Cluster
- Writer Instance
- Reader Instance

---

# 🎯 Learning Objectives

After completing this project, you will understand:

- Terraform Basics
- AWS Provider
- Variables
- Outputs
- VPC
- Subnets
- Route Tables
- Security Groups
- Aurora MySQL
- Writer & Reader Architecture
- DB Subnet Groups

---

# 💡 Interview Questions

### 1. What is Amazon Aurora?

Amazon Aurora is a fully managed relational database compatible with MySQL and PostgreSQL that provides high performance and high availability.

---

### 2. What is the difference between RDS MySQL and Aurora?

Aurora uses shared distributed storage and supports automatic failover with reader instances.

---

### 3. Why do we need a DB Subnet Group?

It specifies the private subnets where the Aurora database instances are deployed.

---

### 4. Why is Aurora deployed in private subnets?

For security reasons. Databases should not be directly accessible from the Internet.

---

### 5. What is the Writer Endpoint?

Used for:

- INSERT
- UPDATE
- DELETE

---

### 6. What is the Reader Endpoint?

Used for:

- SELECT Queries

---

### 7. Can Aurora have multiple readers?

Yes.

Aurora supports multiple reader instances for read scaling.

---

### 8. What happens if the writer instance fails?

Aurora automatically promotes one of the reader instances to become the new writer.

---

### 9. Why use Terraform?

Terraform enables Infrastructure as Code (IaC), making infrastructure repeatable, version-controlled, and automated.

---

### 10. What is Infrastructure as Code (IaC)?

Infrastructure is managed using code instead of manual creation through the AWS Console.

---

# 📚 Terraform Commands

```bash
terraform init

terraform fmt

terraform validate

terraform plan

terraform apply

terraform destroy
```

---

# 👨‍💻 Author

**Arup Kumar Dash**

AWS | Terraform | Docker | Kubernetes | Jenkins | GitHub Actions | DevOps Engineer

---

# ⭐ If you found this project useful

Please ⭐ Star this repository on GitHub.

Happy Learning! 🚀