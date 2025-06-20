## 📘 Introduction

### Overview of the Lab
This Packet Tracer lab is a hands-on guided exercise designed main for understanding fundamental networking concepts through simulation. In this lab, I build a basic network consisting of a router, a switch, a PC, and a server. The lab walks through setting up physical and logical connections, configuring static and dynamic IP addressing, and analyzing packet behavior using Cisco Packet Tracer’s simulation mode.

### Purpose of Using Cisco Packet Tracer
Cisco Packet Tracer is used in this lab to simulate real-world networking scenarios without the need for physical hardware. Although the environment is emulated—not truly simulated—the tool provides valuable insights into how networking works at both the data and control planes. Key features such as protocol visibility, device behavior emulation, and real-time/simulation modes make it ideal for learning foundational networking skills.

This lab emphasizes **learning how networking works**, rather than becoming Cisco-certified engineers. It highlights tools like the DHCP protocol, ARP, and packet analysis, allowing me to observe how data flows through a network from a Layer 1 to Layer 7 perspective.

### Target Audience
This lab is designed for:
- Beginners in computer networking
- Students in IT bootcamps
- Self-learners using Packet Tracer for the first time
- Anyone interested in understanding the fundamentals of how network traffic is initiated, transmitted, and resolved

---

## 🧰 Tools & Requirements

### Cisco Packet Tracer Installation
To complete this lab, I'll be needing the **Cisco Packet Tracer** installed. This was downloaded from the [Cisco Networking Academy](https://www.netacad.com/portal/resources/packet-tracer).

### Lab File
> 🗂 **Note**: If a `.pkt` file is provided in this repository, you can open it directly in Packet Tracer to follow along with the lab steps.  
If not, you can manually build the topology by following the instructions in this README.

### PC System Requirements
- **Operating System**: Windows, macOS, or Linux  
- **RAM**: Minimum 4GB (8GB recommended)  
- **Disk Space**: At least 500MB free  
- **Packet Tracer Version**: 8.2 or later (recommended for stability and feature parity)

### Optional Resources or Pre-Knowledge
It is highly recommended that if you want to carry out this lab, you've reviewed or be familiar with the following concepts:
- OSI Model and Layer Functions
- IP Addressing and Subnetting
- MAC Addresses and ARP
- DHCP Protocol (Discover, Offer, Request, Acknowledge)
- Basic Command Line Interface (CLI) navigation for routers/switches

---

## 🧠 Learning Objectives

By the end of this lab, you will be able to:
- Build a simple network topology using Packet Tracer
- Connect networking devices using appropriate cables and ports
- Configure static IP addressing on routers and servers
- Configure a DHCP server to dynamically assign IP addresses to clients
- Use simulation mode to inspect network packet flow and protocol behavior
- Analyze broadcast vs unicast traffic at various OSI layers
- Understand the DHCP DORA process and observe ARP behavior in a network

### Key Networking Concepts Demonstrated
- Router vs Switch vs Server roles
- Layer 1–3 device functions
- DHCP Protocol and the DORA sequence
- MAC and IP addressing
- Spanning Tree Protocol (briefly touched)
- Simulation of Ethernet frames and broadcast domains
- Gratuitous ARP announcements

---

## 🖥️ Network Topology Overview

### Devices Used
- **Router**: Cisco ISR 4331 (Layer 3 device) – Configured with static IP  
- **Switch**: Generic Layer 2 switch – Connects devices within the same network  
- **Server**: DHCP Server – Provides dynamic IP configuration  
- **PC**: Client device requesting IP via DHCP

### Topology Description
The PC is connected to the switch via FastEthernet. The switch is linked to both the router (for external network access) and the DHCP server (to assign dynamic IPs to the PC). The router is configured manually with a static IP and acts as the default gateway for other devices in the network.

![ASCII Network Diagram]()

---
## 🔌 Step-by-Step Lab Guide

### Step 1: Adding Devices
Begin by dragging and dropping the following devices into the workspace from the Cisco Packet Tracer device list:

- **1 Router**: Cisco ISR 4331  
- **1 Switch**: Any generic Layer 2 switch  
- **1 Server**: Used for DHCP service  
- **1 PC**: DHCP client

---

### Step 2: Connecting Devices Using Appropriate Cables
Use **Copper Straight-Through** cables for all connections:

- **PC → Switch**: FastEthernet 0 on PC to FastEthernet 1 on Switch  
- **Server → Switch**: FastEthernet 0 on Server to FastEthernet 24 on Switch  
- **Router → Switch**: GigabitEthernet 0/0/0 on Router to GigabitEthernet 1 on Switch  

> 💡 **Note**: You may use “Smart Connection” in Packet Tracer to auto-select cables, but manually choosing ensures accuracy.

---

### Step 3: Configuring the Router (Static IP)
Click on the **router**, go to the **CLI tab**.

Enter the following commands to configure the router interface:

```bash
enable
configure terminal
interface gigabitEthernet 0/0/0
ip address 192.168.0.1 255.255.255.0
no shutdown
exit
```
This sets the router as the default gateway and brings the interface up.

### Step 4: Configuring the Server (Static IP & Gateway)
Click on the Server, go to the Config tab.

Assign a static IP to the server:

- **IP Address:** `192.168.0.100`

- **Subnet Mask:** `255.255.255.0`

- **Default Gateway:** `192.168.0.1`

Optionally, set the DNS server as `192.168.0.1`

### Step 5: Enabling DHCP on the Server
Define a DHCP pool:

- **Default Gateway:** `192.168.0.1`

- **DNS Server:** `192.168.0.1`

- **Start IP Address:** `192.168.0.101`

- **Subnet Mask:** `255.255.255.0`

- **Maximum Users:** `100`

Click "On" to activate the DHCP service.
```
⚠️ Avoid creating overlapping or multiple DHCP pools in Packet Tracer—it may cause unexpected IP allocations due to a known bug.
```
### Step 6: Obtaining an IP Address from the PC
Click on the PC, go to **Desktop > Command Prompt.**

Run the following command to request an IP:
```bash
ipconfig /renew
```
### Step 7: Troubleshooting DHCP Issues
If the PC:

- Receives an incorrect IP like 192.168.0.2, it may be due to an old or default DHCP pool still active.

- Doesn’t get an IP at all, verify:

  - The server is on and DHCP service is enabled

  - The server's interface is up and configured

  - Only one DHCP pool exists with valid settings

Fix by:
- Editing the default DHCP pool instead of creating a new one

- Releasing IP on the PC with:
```bash
ipconfig /release
```
And then trying again with `/renew`.

### Step 8: Using Simulation Mode to Analyze Packet Flow
- Switch to Simulation Mode from the bottom-right corner.

- Trigger an IP request from the PC using `ipconfig /renew`.

- Step through each stage using the **"Play"** button.

You can examine each frame at every OSI layer to understand encapsulation.

## 📶 Protocols and Network Behavior

### DHCP Process (DORA)
The DHCP process includes **4 steps**:

1. **Discover** – Client broadcasts to find a DHCP server  
2. **Offer** – Server replies with available IP offer  
3. **Request** – Client requests offered IP  
4. **Acknowledge** – Server confirms and assigns IP  

> This is visible and traceable in **Simulation Mode** in Packet Tracer.

---

### Spanning Tree Protocol (STP)
- STP is briefly seen when switch ports delay transitioning to "up" state.  
- It helps prevent **network loops** by blocking redundant paths.  
- Not deeply explored in this lab, but observable during **switch port negotiation**.

---

### ARP vs Gratuitous ARP
- **ARP**: A device sends a broadcast asking, “Who has this IP?” to resolve MAC addresses.  
- **Gratuitous ARP**: A device announces its IP **without being asked**, allowing other devices to update their ARP tables automatically.

---

### Broadcast Behavior in Switches
When receiving a **broadcast** (e.g., DHCP Discover), the switch **floods the frame** out all ports **except** the one it came from.

> 🧪 This can be observed in Simulation Mode where both the **router and server receive** the DHCP request.

---

## 🔍 Packet Analysis

### Inspecting Packets in Simulation Mode
Use Packet Tracer’s **Simulation tab** to:
- Capture packets triggered by commands (e.g., `/renew`)
- Click on each packet to see details at:
  - **OSI Layers** (Application to Physical)
  - **Encapsulation Units** (Frame, Packet, Segment, etc.)
  - **Source/Destination MAC & IP**
  - **Port Numbers** (e.g., UDP 67/68 for DHCP)

---

### Understanding Encapsulation and OSI Layers
Each frame includes:
- **Layer 2 (Ethernet)**: MAC addresses, FCS  
- **Layer 3 (IP)**: Source/Destination IPs  
- **Layer 4 (UDP)**: Source/Destination Ports  
- **Layer 7 (Application)**: DHCP messages  

This lets you see how **data is wrapped and passed** between layers as it moves through the network.

---

## 🐞 Common Pitfalls & Debugging Tips

### DHCP Pool Conflicts
- **Issue**: Packet Tracer may apply **default DHCP settings** even after custom pools are created.  
- **Fix**: Modify the **default pool** instead of creating a new one.  
  Delete/disable all other pools if multiple pools exist.

---

### Interface Status Issues
Ensure interfaces are manually enabled using:

```bash
no shutdown
```
### Interface Status Issues
Check for physical layer issues — Packet Tracer may show ports as down due to:

- **STP delays**
- **Misconfigured interfaces**

---

### Packet Tracer-Specific Limitations
Packet Tracer is **emulated**, not real — some behaviors (like DNS or TFTP) may not work fully.

DHCP issues sometimes require:

- **Reloading the simulation**
- **Switching to Real-Time Mode**

Device behaviors may not perfectly mimic real-world hardware.

---
## 📝 Summary & Key Takeaways

### What You've Built
In this lab, you've constructed a functional **Local Area Network (LAN)** in Cisco Packet Tracer using:

- A **router** configured with a static IP to serve as the gateway  
- A **switch** to interconnect devices  
- A **DHCP server** to assign IP addresses dynamically  
- A **PC** configured as a DHCP client  

You also enabled **DHCP**, analyzed packet flows using **simulation mode**, and examined the journey of packets through the **OSI model**.

---

### What You've Learned
By completing this lab, you’ve gained practical knowledge of:

- Building and wiring a small network  
- Configuring router and server interfaces  
- Implementing DHCP services  
- Understanding broadcast traffic and switch behavior  
- Using simulation mode to analyze packets and protocol behavior  
- Differentiating between **ARP** and **Gratuitous ARP**  
- Troubleshooting common issues in emulated environments like Packet Tracer

---

## 🙌 Acknowledgements

- **Instructor**: Special thanks to **Tim**, who guided us through the lecture and the hands-on Packet Tracer simulation with clarity and attention to detail.

- **Lecture Source**: Official bootcamp session on basic networking using Cisco Packet Tracer.

- **Contributors**: [`README.md`](README.md) and [`Journal.md`](Journal.md) authored and maintained by [**John Itopa ISAH**](https://github.com/johnitopaisah)

