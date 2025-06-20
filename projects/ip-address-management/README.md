# Deploying and Managing Windows Server on Azure using Bicep

This project demonstrates how to provision a Windows Server 2025 virtual machine (VM) on Microsoft Azure using **Azure Bicep**. It covers converting ARM templates to Bicep, parameterizing deployments, and resolving common regional image constraints.

## 🧭 Objectives

- Deploy a Windows Server 2025 VM via Azure Portal
- Convert exported ARM templates into reusable Bicep IaC format
- Parameterize deployment settings for reusability
- Resolve image region/SKU compatibility issues
- Connect to the VM via Remote Desktop (macOS)
- Document lessons learned from deployment challenges

---

## 📁 Project Structure

```bash
projects/
├── ip-address-management/
│   ├── Journal.md                 # Full deployment report
│   ├── template.json              # Original exported ARM template
│   ├── template.bicep             # Decompiled and refactored Bicep template
│   ├── parameters.json            # Deployment parameters (username, location, etc.)
│   └── assets/                    # Screenshots or supporting visual materials
```
---
## 🚀 Quick Start

### Prerequisites
- Azure CLI with Bicep:
  ```bash
  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
  az login --use-device-code
  az bicep install
  ```
### Deployment Steps
1. Create the resource group:
    ```
    az group create --name net-bootcamp-resource-group --location francecentral
    ```
2. Deploy the VM using Bicep
    ```bash
    az deployment group create \
      --resource-group net-bootcamp-resource-group \
      --template-file template.bicep \
      --parameters @parameters.json
    ```
3. After deployment, download the .rdp file from the Azure Portal and connect using:

    - Username: `john_user`

    - Password: `Testing123456!`
---
## 🧠 Lessons Learned
- Not all image SKUs are available in every region (e.g., no Gen2 Windows 11 x86 in Canada East).

- ARM64 SKUs are often in preview and tied to Gen1 VMs.

- Use az vm image list to confirm compatibility before deploying.

- Bicep templates generated from ARM tend to be verbose — refactoring improves maintainability.

- Azure deployment failures can result from zone mismatches or NIC/IP re-usage.

---
## 📓 Full Report
See [Journal.md](Journal.md) for:

- Step-by-step deployment narrative

- Screenshots

- Infrastructure decisions
---
## 🙌 Credits
**`Instructor`:** [**Andrew Brown**](https://github.com/omenking) 

**`Written/Summarized`:**
[**John Itopa ISAH**](https://github.com/johnitopaisah)


