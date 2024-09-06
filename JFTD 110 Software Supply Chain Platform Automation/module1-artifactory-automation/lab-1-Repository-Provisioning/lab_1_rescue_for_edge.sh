# switch to swampupedge config
jf c use swampupedge

# Path to the projects JSON file
project_file="./project.json"

# Fetch the projectKey from projects.json
project_key=$(jq -r '.projectKey' "$project_file")

# Delete the repositories
for row in $(cat ./local-repos-for-edge.json | jq -r '.[] | @base64'); do
    _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
    }
    # Get the repository key from local-repos.json
    repo_key=$(_jq '.key')
    # Combine project_key and repo_key with a hyphen
    prefixed_repo_name="${project_key}-${repo_key}"

    jf rt repo-delete $prefixed_repo_name --quiet
done
# creating repos on edge nodes
sh create_local_repos_for_edge.sh

# switch back to MAIN JPD
jf c use swampup