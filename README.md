# Ansible Scripts for DrivingSwarm

In this repository we will host scripts to manage the software and configuration on a swarm of robots running ros2 with the DrivingSwarm framework.
For installing the neccessary software for running Driving Swarm you have to:
- install ansible
- adapt the inventory file
- run the playbook to install the software

The inventory file holds a list of hosts you want to manage (i.e. your laptop/workstation(s) and your turtlebots).

### Install ansible

Install the ansible package via `apt install ansible` or `pip install ansible`. Ansible is only used on the host computer (for example your laptop). You do not need to install ansible on the Rasperry-pi of the robots.

### Adapt the inventory file

You the file `turtlebots.txt` as an example. The content of the file should look like this:
```
## set the domain id for each host individually
## domain IDs 0-101 and 215-232 can be safely used 

[turtlebot]
#10.61.10.236 ansible_connection=ssh ansible_ssh_user=turtle domain_id=1
#10.61.10.246 ansible_connection=ssh ansible_ssh_user=turtle domain_id=5


[demo]
#10.61.10.232 ansible_connection=ssh ansible_ssh_user=turtle domain_id=101
#10.61.10.245 ansible_connection=ssh ansible_ssh_user=turtle domain_id=100

[turtlehost]
#localhost ansible_connection=local domain_id=215

[turtlebot:children]
demo
```
There are three groups of hosts:
1. `turtlebot` the raspberry-pi on each robot
2. `demo` for turtlebotgs running a demo behaviour on boot
3. `turtlehost` for host computers (e.g. your laptop or workstation)

For each host you can set additional variables:
- `ansible_connection` for the connection method
- `ansible_ssh_user` for the username (when connecting via ssh)
- `domain_id` the ros domain id used for the host (we use zenoh-bridge, to route traffic between domains - use a different domain for each host)

### Installing Driving Swarm using Ansible (localhost)

Install ansible and adapt your hosts file, to contain localhost. You can use the command
`ansible-playbook --check -i turtlebots.txt --limit turtlehost -K install_workspace.yml` to see what changes ansible would perform on your system.

Run the same command without `--check` to apply the changes. The parameter `-K` lets you enter the password for `sudo`.

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

### Run ansible script for the Turtlebot(s)

Make sure you are able to connect to your turtlebot(s) via ssh, via your ssh key. (If you are able to connect via password, use `ssh-keygen` to generate an ssh-key and `ssh-copy-id username@IP` to copy your key to the raspberry-pi)

To run the script you have to modify an inventory file which holds the hostname and config variables for each host as described above.
You can use the file `turtlebots.txt` as an example.

Run the command `ansible-playbook -i turtlebots.txt install_workspace.yml --limit turtlebot` which installs all neccessary software on the robots (and your hosts).

The script will:
* Install ros2 humble
* Install and setup zenohd, zenoh-bridge-dds, ...
* Install driving swarm git repo
* Install dependencies via rosdep
* Install script to run driving swarm automatically
* Install launchfile as systemd-service
* Disable automatic updates
* Change the hostname and ros prefix
* Setup zenoh-bridge (start on boot)
