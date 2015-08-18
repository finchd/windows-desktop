#!/usr/bin/env bash

ansible-playbook --syntax-check -i provisioning/inventory --ask-vault-pass $1
