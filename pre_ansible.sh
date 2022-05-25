#!/bin/bash
sudo apt install -y ansible ansible-galaxy
ansible-galaxy install -r requirements.yml
ansible-galaxy collection install -r requirements.yml
