# 🧱 Windows Firewall Lab – Rule Management & PowerShell Automation

This lab demonstrates the fundamentals of **Windows Defender Firewall** configuration using GUI and PowerShell. Designed for beginners in cybersecurity and system administration, it covers:

- Firewall profiles (Domain, Private, Public)
- Inbound/outbound rule management
- PowerShell rule creation
- Export/import of firewall policies
- Security best practices

## 📁 Project Structure

```bash
windows-firewall/
├── assets/              # Screenshots used in documentation
├── Journal.md           # Detailed walkthrough of all steps
└── README.md            # Summary (this file)
```

## 🧪 Key Lab Objectives

- Understand host-based firewall and profile behaviors
- Create and manage rules for ICMP, ports, and apps
- Automate rule creation with PowerShell
- Export and import firewall settings with `netsh`
- Simulate real-world use cases (e.g., botnet defense)

## 🔧 Requirements

- Windows 10/11 or Server 2016+ (Admin access)
- PowerShell 5+
- Internet connectivity
- Cloud (AWS EC2) or VirtualBox/VMware/Hyper-V

## ⚙️ Highlights

- Allow ICMP only on **Private profile**
- Block outbound UDP port 1234 traffic
- Create inbound rule for `notepad.exe`
- Export firewall config:
  ```powershell
  netsh advfirewall export "C:\lab\firewall-config.wfw"

## 7. 👤 Credits
- **Instructor**: Special thanks to **Tim**, who guided us through the lecture and the hands-on Packet Tracer simulation with clarity and attention to detail.

- **Lecture Source**: Official bootcamp session on basic networking using Cisco Packet Tracer.

- **Contributors**: [`README.md`](README.md) and [`Journal.md`](Journal.md) authored and maintained by [**John Itopa ISAH**](https://github.com/johnitopaisah)