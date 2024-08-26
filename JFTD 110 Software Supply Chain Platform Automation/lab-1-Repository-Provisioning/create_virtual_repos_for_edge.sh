# Path to the projects JSON file
project_file="./project.json"
# Fetch the projectKey from projects.json
project_key=$(jq -r '.projectKey' "$project_file")

# Loop through each repository entry in local-repos.json
for row in $(jq -r '.[] | @base64' ./virtual-repos-for-edge.json); do
    _jq() {
        echo "${row}" | base64 --decode | jq -r "${1}"
    }

    # Get the repository key from virtual-repos.json
    repo_key=$(_jq '.key')

    # Combine project_key and repo_key with a hyphen
    prefixed_repo_name="${project_key}-${repo_key}"

    # Process the repositories array and prefix each repo with the project_key
    repositories=$(_jq '.repositories[]') # Extract repositories array
    prefixed_repositories=$(echo "$repositories" | while read -r repo; do echo "${project_key}-${repo}"; done | paste -sd "," -)

    # Get the repository key from virtual-repos.json
    default_DeploymentRepo=$(_jq '.defaultDeploymentRepo')

    # Combine project_key and repo_key with a hyphen
    prefixed_default_DeploymentRepo="${project_key}-${default_DeploymentRepo}"

    # Get the externalDependenciesRemoteRepo key from virtual-repos.json
    external_DependenciesRemoteRepo=$(_jq '.externalDependenciesRemoteRepo')

    # Combine project_key and repo_key with a hyphen
    prefixed_external_DependenciesRemoteRepo="${project_key}-${external_DependenciesRemoteRepo}"

    # Create the repository with the prefixed repo name and other variables
    jf rt repo-create template-virtual-rescue.json --vars "repo-name=$prefixed_repo_name;package-type=$(_jq '.packageType');repo-type=$(_jq '.rclass');project-key=$project_key;repo-layout=$(_jq '.repoLayoutRef');deploy-repo-name=$prefixed_default_DeploymentRepo;external-remote-repo-name=$prefixed_external_DependenciesRemoteRepo;env=$(_jq '.environments');repos=$prefixed_repositories"
done