# 🧰 Windows Networking Tools (Troubleshooting Labs)

This repository provides a hands-on, command-line-based exploration of essential **Windows networking tools** used for network diagnostics and troubleshooting in real-world environments.

---

## 📘 Overview

This lab-based project documents the usage of built-in Windows tools like:

- `ipconfig`
- `ping`
- `tracert`
- `nslookup`
- `netstat`
- `route`

These tools can be test in various environments — including local machines, virtual machines (Hyper-V, VirtualBox), and AWS EC2 — with scenarios covering DNS issues, MTU bottlenecks, IP configuration errors, and multi-NIC routing.

---

## 📂 Project Structure

```bash
projects/
├── windows-networking/
│   ├── Journal.md      # Full detailed lab documentation (recommended read)
│   ├── assets/         # Screenshots and demo outputs
│   └── README.md  
```

## 🔍 What You’ll Learn

- How to verify network configs with `ipconfig`
- How to test reachability with `ping`
- How to trace route hops with `tracert`
- How to analyze DNS with `nslookup`
- How to monitor connections with `netstat`
- How to manipulate routes using `route`

---

## 🧪 Getting Started

To replicate this lab:

1. Launch a Windows environment (local or cloud)
2. Open Command Prompt as Administrator
3. Follow the scenarios in [`Journal.md`](./Journal.md)

---

## 🙌 Credits

- **Instructor:** **Tim** (lecture-based walkthrough)
- **Documentation:** [**John Itopa ISAH**](https://github.com/johnitopaisah)
- **Source:** Bootcamp on Windows Network Fundamentals
