
#!/bin/bash
# Note: To run this script you need the "jq" tool from https://jqlang.github.io/jq/download/
# Usage: bash ./create-local-remote-virtual.sh

# Read values from JSON using jq
key=$(jq -r '.key' npm-local.json)
packageType=$(jq -r '.packageType' npm-local.json)
rclass=$(jq -r '.rclass' npm-local.json)
repoLayoutRef=$(jq -r '.repoLayoutRef' npm-local.json)
xrayIndex=$(jq -r '.xrayIndex' npm-local.json)

# Create local
jf rt repo-create template-local.json \
  --vars  "repo-name=$key;package-type=$packageType;repo-type=$rclass;repo-layout=$repoLayoutRef;xray-enable=$xrayIndex"


# Read values from JSON using jq
key=$(jq -r '.key' npm-remote.json)
packageType=$(jq -r '.packageType' npm-remote.json)
rclass=$(jq -r '.rclass' npm-remote.json)
url=$(jq -r '.url' npm-remote.json)
repoLayoutRef=$(jq -r '.repoLayoutRef' npm-remote.json)
xrayIndex=$(jq -r '.xrayIndex' npm-remote.json)


# Create remote
jf rt repo-create template-remote.json \
  --vars "repo-name=$key;package-type=$packageType;repo-type=$rclass;url=$url;repo-layout=$repoLayoutRef;xray-enable=$xrayIndex"


# Read values from JSON using jq
key=$(jq -r '.key' npm-virtual.json)
packageType=$(jq -r '.packageType' npm-virtual.json)
rclass=$(jq -r '.rclass' npm-virtual.json)
repoLayoutRef=$(jq -r '.repoLayoutRef' npm-virtual.json)
defaultDeploymentRepo=$(jq -r '.defaultDeploymentRepo' npm-virtual.json)
externalDependenciesRemoteRepo=$(jq -r '.externalDependenciesRemoteRepo' npm-virtual.json)
repositories=$(jq -r '.repositories' npm-virtual.json)


# Create remote
jf rt repo-create template-virtual.json \
  --vars  "repo-name=$key;package-type=$packageType;repo-type=$rclass;url=$url;repo-layout=$repoLayoutRef;deploy-repo-name=$defaultDeploymentRepo;external-remote-repo-name=$externalDependenciesRemoteRepo;repos=$repositories"