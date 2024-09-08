# 1 - JFrog Xray Resource Indexing - Repos, Builds, Release Bundles

The terraform (tf) resources in this folder will help managing the JFrog Xray indexing list for repos, builds, and release bundles.

- [Repository Indexing (xray_binary_manager_repos)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/binary_manager_repos)
  
- [Build Indexing (xray_binary_manager_builds)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/binary_manager_builds)
  
- [Release Bundle (xray_binary_manager_release_bundles_v2)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/binary_manager_release_bundles_v2)

> **NOTE**
> Changes to the xray binary manager for repos, builds, or release bundles will impact the existing indexed resources. Ensure full list of existing and new resources are passed in when running the tf apply  

### Prerequisites
Before proceeding please ensure the following labs are completed
- [Lab-0 - Configure JFrog CLI](../../lab-0-Configure-JFrog-CLI/)
- [Lab-1 - Repository Provisioning](../../module1-artifactory-automation/lab-1-Repository-Provisioning/)
- [Lab 3 - Build and Replication](../../module1-artifactory-automation/lab-3-Build-and-Replication/)

## Getting Started
Purpose of the various terraform files used 

```
├── main.tf - Contains the main terraform resources to provision the resources
├── variables.tf - Contains variable declarations used in the main terraform file
├── sample.tfvars - Contains the values to pass into the variable file. By default all tfvars will be ignored by git.
├── outputs.tf - Contains information about config available on the command line
└── versions.tf - Contains required version information for terraform and providers
```

**Step 1 -** Create a copy of the `sample.tfvars` and add in your custom values. **NOTE** - all `.tfvars` files will be git ignored except `sample.tfvars`. Please do not modify sample.tfvars
```
cp sample.tfvars swampup.tfvars
```

**Step 2 -** Modify the `swampup.tfvars` file with relevant values. 

Below listed are the values for reference.
```
JFROG_PLATFORM_URL="swampup17242726643.jfrog.io" 
JFROG_PLATFORM_ACCESS_TOKEN="XXXXXX"
JFROG_PROJECT_NAME="puser1"

BUILDS_INDEX_LIST=["demo-node-app"]
```

**Step 3 -** Initialize terraform 
```
tf init
```

**Step 4 -** Generate terraform plan
```
tf plan -var-file=swampup.tfvars
```

**Step 5 -** Apply terraform changes
```
tf apply -var-file=swampup.tfvars
```

**Step 6 -** Navigate to the jfrog platform portal and view the list of indexed resources under `Administration tab --> Xray Settings --> Indexed Resources`

#### Let's proceed with [repo config](../lab2_policies/)