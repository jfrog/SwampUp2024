# Path to the projects JSON file
project_file="./project.json"

# Fetch the projectKey from projects.json
project_key=$(jq -r '.projectKey' "$project_file")

# Loop through each repository entry in local-repos.json
for row in $(jq -r '.[] | @base64' ./local-repos.json); do
    _jq() {
        echo "${row}" | base64 --decode | jq -r "${1}"
    }

    # Get the repository key from local-repos.json
    repo_key=$(_jq '.key')

    # Combine project_key and repo_key with a hyphen
    prefixed_repo_name="${project_key}-${repo_key}"

    # Create the repository with the prefixed repo name and other variables
    jf rt repo-create template-local-rescue.json \
        --vars "repo-name=$prefixed_repo_name;package-type=$(_jq '.packageType');repo-type=$(_jq '.rclass');repo-layout=$(_jq '.repoLayoutRef');project-key=$project_key;env=$(_jq '.environments');xray-enable=$(_jq '.xrayIndex')"
done
