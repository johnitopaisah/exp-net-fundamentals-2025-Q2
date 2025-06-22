# 🧱 Linux Networking Tools Lab

## 1. ✨ Introduction

### Purpose of the Lab
This lab aims to provide practical, hands-on experience with essential Linux networking tools used for troubleshooting and diagnostics. These tools are vital for any system administrator, network engineer, or DevOps practitioner working in a Linux environment.

### Why Linux Networking Tools Matter
Linux dominates server environments, cloud infrastructure, and many networking appliances. Command-line tools in Linux offer deep visibility and control over network configurations, traffic flows, and protocol behaviors, making them indispensable for debugging and optimization.

### Target Audience
- Networking and DevOps students  
- System administrators  
- Cloud infrastructure engineers  
- Anyone preparing for Linux-based certifications

---

## 2. 🎯 Learning Objectives

By completing this lab, you will:

- Understand where each tool fits in the OSI/networking stack  
- Use tools like `ip`, `ping`, `traceroute`, `dig`, `tcpdump`, and `netstat`  
- Identify and fix DNS, routing, and connectivity issues  
- Capture and analyze packets using `tcpdump`  
- Compare modern tools (`ip`, `ss`) with legacy ones (`ifconfig`, `netstat`)

---

## 3. 🧪 Lab Setup

### Recommended Environment
- Ubuntu (20.04/22.04) or Debian-based distros  
- CentOS, Rocky Linux, or RHEL  
- WSL2 on Windows (with network tools installed)  
- Cloud VMs (e.g., AWS EC2, GCP, Azure VMs)

### Tools and Access Required
- Terminal emulator  
- Root or sudo access for advanced commands  
- Internet access for real-world connectivity tests

📸 **Suggested Screenshot**: Terminal window open with `ip a` or `ifconfig` displayed

## 4. 🔍 Core Concepts

### What is Network Troubleshooting?
Network troubleshooting is the process of diagnosing and resolving issues affecting communication between systems. Tools operate at different layers of the OSI model, from physical to application.

### Layers of Networking and Where Tools Operate

| OSI Layer     | Purpose                        | Tools                        |
|---------------|--------------------------------|------------------------------|
| Layer 1–2     | Link and MAC details           | `ip`, `ethtool`              |
| Layer 3       | IP routing                     | `ip route`, `traceroute`     |
| Layer 4       | TCP/UDP                        | `netstat`, `ss`              |
| Layer 7       | Application (HTTP/DNS/etc.)    | `curl`, `wget`, DNS tools    |

📸 **Suggested Screenshot**: OSI layers table with tool mapping (optional diagram)

---

## 5. 🛠️ Linux Networking Tools Overview

| Tool       | Purpose                               |
|------------|----------------------------------------|
| `ip`       | Display/manipulate routing, devices    |
| `ifconfig` | Legacy network config tool             |
| `ping`     | Test reachability and latency          |
| `traceroute` | Track packet path through routers    |
| `nslookup` | Query DNS records                      |
| `dig`      | Detailed DNS analysis                  |
| `netstat`  | Show active connections (legacy)       |
| `ss`       | Modern `netstat` replacement           |
| `route`    | View/edit routing table                |
| `tcpdump`  | Capture and analyze packets            |
| `curl` / `wget` | Test web requests and APIs        |

📸 **Suggested Screenshot**: Multiple terminal tabs each showing basic usage of the above tools

---

## 6. 💡 Common Troubleshooting Scenarios

- **IP Conflicts**: Use `ip a`, `ip link`, or `arp` to detect and verify
- **DNS Failures**: Use `dig`, `nslookup`, and check `/etc/resolv.conf`
- **Routing Issues**: Use `ip route`, `traceroute`, and `ss -tuln`
- **Firewall Blocks**: Use `iptables`, `ufw`, or cloud security groups
- **Slow Performance**: Use `ping`, `mtr`, and `tcpdump` to locate delays

---

## 7. 📜 Command Syntax & Flags Summary

### Useful Flags by Tool

| Tool      | Flags & Description                            |
|-----------|-------------------------------------------------|
| `ip`      | `ip a`, `ip r`, `ip link`, `ip neigh`           |
| `ping`    | `-c`, `-i`, `-s`, `-W`                          |
| `traceroute` | `-n`, `-m`, `-w`                             |
| `dig`     | `+short`, `+trace`, `@dns_server`               |
| `tcpdump` | `-i`, `-n`, `-vvv`, `port`, `host`, `-w`        |
| `ss`      | `-tuln`, `-p`, `-s`                             |

### Practical Examples

- `ip a` — Show all interfaces  
- `ping -c 4 8.8.8.8` — Ping 4 times  
- `tcpdump -i eth0 port 80` — Capture HTTP traffic  
- `ss -tuln` — List listening TCP/UDP ports  

---

## 8. ⚡ Advanced Use Cases

### Network Monitoring with `tcpdump`
Capture traffic for specific hosts, ports, or protocols. Essential for debugging real-time connectivity or performance issues.

### DNS Analysis with `dig` vs `nslookup`
- Use `dig` for better formatting and advanced DNS record analysis.
- Add `+trace` to follow DNS resolution path across authoritative servers.

### iproute2 Over Legacy Tools
- Use `ip` and `ss` instead of `ifconfig` and `netstat`
- Benefits: Modern syntax, script-friendly, and extended feature set.

📸 **Suggested Screenshot**: `tcpdump` CLI capture and filtered output (e.g., HTTP traffic on port 80)

## 9. 📸 Suggested Screenshots

- `ip a` and `ip r` outputs
- `ping` with 4 responses
- `dig +trace` with detailed name server steps
- `tcpdump -i eth0 port 80` with captured HTTP traffic output
- `ss -tuln` showing active listening services and ports

---

## 10. ⚙️ Power Tips

- **Real-time Monitoring**:
  ```bash
  watch -n 2 ip a
  ```
  - **Chain with grep:**
  ```bash
  alias netopen='ss -tuln'
  alias traceg='traceroute google.com'
  ```
---
## 11. 🧯 Best Practices & Pitfalls

- Always use the `-n` flag to skip DNS lookups in tools like `ping`, `ss`, and `traceroute`
- Avoid running `tcpdump` on production systems without proper scope or filters
- Don’t overwrite `/etc/resolv.conf` without creating a backup first
- Use `sudo` for the most accurate command outputs and required permissions

## 12. 🙌 Credits

- **Instructor**: Special thanks to **Tim**, who provided the core lecture and hands-on guidance throughout the Linux networking tools walkthrough.

- **Lecture Source**: Derived from the official bootcamp session on Linux Networking and Troubleshooting Fundamentals.

- **Contributors**: [`README.md`](README.md) and supporting lab documentation authored and maintained by [**John Itopa ISAH**](https://github.com/johnitopaisah)
