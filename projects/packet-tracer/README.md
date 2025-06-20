# 🧪 Packet Tracer DHCP Lab – Basic Networking Simulation

This project demonstrates a basic DHCP-enabled network using Cisco Packet Tracer. The goal is to help beginners understand core networking concepts through a hands-on simulation of devices like routers, switches, PCs, and DHCP servers.

> 📘 Full instructions and step-by-step explanations are available in [`Journal.md`](./Journal.md)

---

## 🔧 Lab Overview

- **Router** (Cisco ISR 4331) – Configured with a static IP as gateway  
- **Switch** – Connects all devices within the LAN  
- **Server** – Acts as a DHCP server  
- **PC** – DHCP client receiving dynamic IP configuration  

Using Packet Tracer’s simulation mode, the lab also visualizes the DHCP process (DORA), ARP behavior, and how packets traverse OSI layers.

---

## 📂 Files Included

| File/Folder | Description |
|-------------|-------------|
| `packet-tracer-lab.pkt` | Main Packet Tracer lab file |
| `Journal.md` | Full walkthrough with commands, analysis, and troubleshooting |
| `assets/network-topology.png` | Screenshot of the network topology |
| `README.md` | This file – brief overview of the lab |

---

## ✅ Learning Objectives

- Build and connect a small LAN topology  
- Configure static and dynamic IP addressing  
- Enable and test DHCP services  
- Analyze packet flow and encapsulation in simulation mode  
- Understand ARP, STP, and broadcast behavior

---

## 🚀 How to Use

1. Download and open [`packet-tracer-lab.pkt`](packet-tracer-lab.pkt) in **Cisco Packet Tracer (v8.2 or newer)**
2. Review configuration commands and steps in [`Journal.md`](Journal.md)
3. Optionally toggle to **Simulation Mode** to trace packet behavior
4. Use `ipconfig /release` and `ipconfig /renew` from the PC to trigger DHCP

---

## 🙌 Credits

Created as part of a networking fundamentals bootcamp.  
Special thanks to **Tim** for the instructional walkthrough.  
Authored by [**John Itopa ISAH**](https://github.com/johnitopaisah)

