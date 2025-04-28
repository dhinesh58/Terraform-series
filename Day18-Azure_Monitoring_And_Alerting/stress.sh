#!/bin/bash
#Author : Dhinesh
#Team : Infra Team
#Description: create stress load for high cpu
#version: 0.0

sudo apt install stress -y
sudo apt update
# Generate high CPU load
stress --cpu 6 --timeout 300
#Generate high memory disk load
stress --vm 4 --vm-bytes 90% --timeout 120s
