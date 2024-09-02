# switch to swampupedge config
jf c use swampupedge

# creating repos on edge nodes
sh create_env.sh

sh create_federated_repos.sh
sh create_virtual_repos_for_edge.sh

# switch back to MAIN JPD
jf c use swampup