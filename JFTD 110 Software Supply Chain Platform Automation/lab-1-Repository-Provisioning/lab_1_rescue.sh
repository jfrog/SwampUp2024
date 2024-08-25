jf c use swampup

sh create_local_repos.sh
sh create_remote_repos.sh
sh create_virtual_repos.sh

jf rt curl -XPUT "/api/repositories/aws-tf-local" -H "Content-Type: application/json" -d "@createTerraformRepo.json"

sh lab_1_rescue_for_edge.sh