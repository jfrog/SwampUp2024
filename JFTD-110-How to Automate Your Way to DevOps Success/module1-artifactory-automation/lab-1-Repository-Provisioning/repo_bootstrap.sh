#!/bin/bash

jf c use swampup

# # Delete the repositories
sh delete_repos.sh

# # Create the local, remote, and virtual repositories
sh create_local_repos.sh
sh create_remote_repos.sh
sh create_virtual_repos.sh

# Commenting it out as it is not required for the lab
#jf rt curl -XPUT "/api/repositories/aws-tf-local" -H "Content-Type: application/json" -d "@createTerraformRepo.json"

# sh repo_bootstrap_for_edge.sh