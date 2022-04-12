#!/bin/bash
apt install -y ansible
ansible-galaxy install -r requirements.yml
ansible-galaxy collection install -r requirements.yml
