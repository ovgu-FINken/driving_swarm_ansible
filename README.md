# Ansible Scripts for DrivingSwarm

In this repository we will host scripts to manage the software and configuration on a swarm of robots running ros2 with the DrivingSwarm framework.

### Installing Driving Swarm using Ansible (localhost)

First install ansbile and the neccessary components (ansible-galaxy and the ansible-galaxy packages).
To run the ansible configuration script, modify the inventory file and run the command below.
`ansible-playbook -i local_inventory -K install_workspace.yml`

Use the following command for a dry run, which does not make changes to the system:
`ansible-playbook --check -i local_inventory -K install_workspace.yml`

### Making an SD-Card for the Turtlebot

Manual:
[](http://www.lpenz.org/articles/ansiblerpi/)
or: use `rpi-imager` on ubuntu to flash an sd card.

* Download and install ubuntu22.04
* Change username and password
* Enable ssh, put public key on card
* Change Wi-Fi network

Then:
* Set correct ntp-server (in case some firewall admin decides that ntp is not that useful ...)
* Copy the SD-Card for other robots

### Run ansible script
To run the script you have to modify an 'inventory file' which holds the hostname and config variables for each host.
You can use the file `turtlebots.txt` as an example.

The script will:
* Install ros2 humble
* Install and setup zenohd, zenoh-bridge-dds, ...
* Install driving swarm git repo
* Install dependencies via rosdep
* Install script to run driving swarm automatically
* Install launchfile as systemd-service
* Setup zenoh-bridge (start on boot)
