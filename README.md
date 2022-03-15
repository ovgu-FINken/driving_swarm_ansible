# Ansible Scripts for DrivingSwarm

In this repository we will host scripts to manage the software and configuration on a swarm of robots running ros2 with the DrivingSwarm framework.

usage:
To run the ansible configuration script, modify the inventory file and run the command below.
`ansible-playbook -i local_inventory -K install_workspace.yml`

Use the following command for a dry run, which does not make changes to the system:
`ansible-playbook --check -i local_inventory -K install_workspace.yml`
