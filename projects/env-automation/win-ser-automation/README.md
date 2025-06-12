# 🧾 Technical Documentation: Automated Deployment of a Windows Server Environment on AWS Using CloudFormation

### 👨‍💻 Author:  
**John Itopa ISAH**

---

## 📌 Objective  
To design, automate, and validate the deployment of a secure Windows Server 2025 EC2 instance within a custom AWS VPC using **Infrastructure as Code (IaC)** via AWS CloudFormation, Bash scripting, and AWS CLI — followed by a complete teardown of the environment.

---

## 🧰 Tools & Services Used

| Tool/Service              | Purpose                                  |
|---------------------------|------------------------------------------|
| AWS CloudFormation        | Infrastructure-as-Code (IaC)             |
| Amazon EC2                | Hosting the Windows Server               |
| AWS CLI                   | Command-line provisioning                |
| Bash                      | Deployment and teardown scripting        |
| Gitpod + VS Code Terminal | Development & testing environment        |

---

## 🏗️ Infrastructure Design Overview

- **VPC**: `10.200.123.0/24`
- **Public Subnet**: `10.200.123.0/25` (auto-assign public IP)
- **Private Subnet**: `10.200.123.128/25`
- **Internet Gateway**: Routed to the public subnet
- **Security Group**:
  - Allow **RDP (3389)** and **SSH (22)** from `MyIP`
  - Allow all traffic within `10.200.123.0/24`
- **EC2 Instance**:
  - Windows Server 2025 (AMI: `ami-077d884fe0477d60d`)
  - Type: `t3.large`
  - Volume: 125 GiB `gp3`
  - **Secondary ENI** in the private subnet

---

## 📜 CloudFormation Template

Defined in `window-ec2-server.yml` and includes:

- `Parameters`:
  - `VpcCidr`, `PublicSubnetCidr`, `PrivateSubnetCidr`, `AvailabilityZone`, and `MyIP`
- `Resources`:
  - VPC, subnets, route tables, gateway, EC2 instance, security group, ENI
- `Outputs`:  
  Returns instance ID, subnet IDs, VPC ID, and KeyPair name

**Validation Command:**

Validate the template by running the command below from the terminal

```bash
aws cloudformation validate-template \
  --template-body file://window-ec2-server.yml
```

**Output:**

This will display the list of all the resource the stack will provision as shown below

![Validation Result](./assests/val-result.png)

---

## 🚀 Deployment Script: deploy-win-ser.sh

Once the template (`window-ec2-server.yml`) has been validate, you can now move ahead with the deployment of the template by running the deployment script (`deploy-win-ser.sh`) from the terminal,to start the deployment of the resource using CFN template. To do this, we run this command
```bash
  ./bin/deploy.sh
```
⚠️  Please note that, you have to make this script executable by running this command `chmod +x ./bin/desploy.sh` before running the deployment command above.

**📤 Stack Outputs**

This section shows the final output values from the deployed CloudFormation stack.
It includes the EC2 instance ID, VPC ID, subnet IDs, and KeyPair name — serving as proof 
that all resources were provisioned successfully. The screenshot below provides visual 
confirmation of the output in the terminal.

![Output](./assests/stack-output.png)
