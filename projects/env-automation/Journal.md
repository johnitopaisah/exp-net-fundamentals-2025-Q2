# 🧾 VPC Infrastructure Deployment Journal

This document captures the process I followed to **create and deploy a Virtual Private Cloud (VPC)** in AWS using **CloudFormation** and a **custom deployment script**. It's written to help beginners understand both the reasoning and technical steps behind the setup.

---

## 🔧 VPC Settings: What Are We Building?

Before building anything in AWS, it's important to define **what** we want to deploy. After watching the instructor’s videos, I took note of the VPC configuration we were aiming for:

| Setting                     | Value                   |
|----------------------------|-------------------------|
| **VPC IPv4 CIDR Block**    | `10.200.123.0/24`       |
| **IPv6 CIDR Block**        | None                    |
| **Availability Zones (AZs)** | 1                     |
| **Public Subnets**         | 1                       |
| **Private Subnets**        | 1                       |
| **NAT Gateways**           | None                    |
| **VPC Endpoints**          | None                    |
| **DNS Hostnames**          | Enabled                 |
| **DNS Resolution**         | Enabled                 |

> ℹ️ A **VPC** is a virtual network in AWS, similar to your own private data center, but in the cloud.

---

## 📄 Creating the CloudFormation Template

To automate the creation of the VPC infrastructure, I used **AWS CloudFormation**, a service that lets you define infrastructure as code.

### 🧠 Step 1: Using an LLM to Generate the Template

Instead of writing the entire template by hand, I used **ChatGPT** to generate a **CloudFormation YAML file** based on the VPC settings above.

### 🛠 Step 2: Refactoring for Reusability

The first draft from the LLM had **hardcoded values**. I have  to **refactor** the template to use **parameters** instead. This made the template flexible, allowing me (or others) to reuse it with different values later.

> ✅ Result: A parameterized, reusable `template.yml` file ready for deployment.

---

## 📜 Deploy Script (`deploy.sh`)

To avoid typing long AWS CLI commands manually every time I deploy the stack, I generated a deployment script named:

`deploy.sh` in the `bin dir.`


### 🧠 Script Highlights:
- Written in Bash (`#!/usr/bin/env bash`) to work across Linux, macOS, and Gitpod.
- Uses the AWS CLI to deploy the CloudFormation template.
- Accepts parameters for things like CIDR blocks and AZs.
- Waits for the deployment to finish and then prints the stack’s output.

### 🔍 What the Script Does:
1. Sets the stack name and region.
2. Provides values for the VPC and subnets.
3. Runs `aws cloudformation deploy` to launch the infrastructure.
4. Waits for the deployment to complete.
5. Fetches and displays the stack outputs.

> ✅ Result: Simple, repeatable deployment using `./bin/deploy.sh`  from the `env-automation dir` or you can simply `cd` into the `bin dir` and use `./deploy.sh` command for the deployment.

🔍 _*Please Note:*_ Don't forget to change the `deploy.sh` file to executable mode before the deployment by running the command `chmod 766 deploy.sh` from the `bin dir`. 


---

## 🖼 Visualizing the VPC

I tried visualizing the deployed infrastructure using **AWS Infrastructure Composer**.

### 🔍 Observation:
- It shows the basic layout, but not the best clarity or detail.
- Subnets, routes, and gateway attachments were present, but lacked intuitive labels.

📷 *Screenshot:*
![Infrastructure Composer](./assets/aws_infr_composer.png)


> 📝 *_Insight:_* While Infrastructure Composer gives a visual overview, it's better suited for initial design than deep insight into deployed resources.

---

## 💻 Installing the AWS CLI

To run the deployment script from my local environment, I needed the **AWS Command Line Interface (CLI)**.

### 📦 Installation Steps:
1. Visit: [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
2. Download and install based on your operating system (Windows, macOS, Linux).
3. Configure it using:

   ```bash
   aws configure
   ```

   This step will ensures that the script can authenticate and make changes in your AWS account.

---

## 🚀 Deployed Infrastructure on AWS

After deploying the CloudFormation stack, AWS automatically created the following resources:

- **VPC** (`10.200.123.0/24`)
- **Public Subnet** (`10.200.123.0/25`)
- **Private Subnet** (`10.200.123.128/25`)
- **Internet Gateway**
- **Route Table** with a default route to the internet
- **Route Table Association** with the public subnet

📷 **Resource Map Screenshot:**

![Resource Map](./assets/aws_vpc_resource_map.png)

---

## ✅ What I Learned

- How to describe infrastructure as code using **CloudFormation**
- How to use **Bash scripting** to automate deployments
- How to use the **AWS CLI** for real-world DevOps tasks
- How to structure **reusable templates** using CloudFormation parameters
- Why **visualization tools** like Infrastructure Composer are helpful (but not perfect)

---

## 🔚 Next Steps

Now that the VPC has been successfully deployed, there are several ways we can enhance and extend the infrastructure. These steps will help simulate a more realistic environment and make the setup production-ready.

- **Add a private route table for internal routing**  
  This will allow instances in the private subnet to communicate internally and reach other resources (like a NAT Gateway or database) without public internet exposure.

- **Launch EC2 instances into the public and private subnets**  
  Deploying EC2 instances in both subnets will let us test connectivity, simulate frontend/backend separation, and prepare for real-world application hosting.

- **Add a `delete.sh` script to tear down infrastructure**  
  A cleanup script will help remove the stack and all associated resources when they're no longer needed, saving costs and maintaining a clean AWS environment.

- **Export stack outputs as environment variables or integrate into CI/CD**  
  Making stack outputs accessible (e.g., VPC ID, Subnet IDs) enables smooth integration with other scripts, automation tools, or CI/CD pipelines for continuous delivery.




