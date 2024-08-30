for row in $(cat ./delete-repos.json | jq -r '.[] | @base64'); do
    _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
    }
    # Path to the projects JSON file
    project_file="./project.json"
    # Fetch the projectKey from projects.json
    project_key=$(jq -r '.projectKey' "$project_file")
    # Get the repository key from local-repos.json
    repo_key=$(_jq '.key')

    # Combine project_key and repo_key with a hyphen
    prefixed_repo_name="${project_key}-${repo_key}"

    jf rt repo-delete $prefixed_repo_name --quiet
done