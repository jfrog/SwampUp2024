# [JFrog Xray Terraform Provider](https://registry.terraform.io/providers/jfrog/xray/latest/docs)

The Xray provider is used to interact with the resources supported by the JFrog Xray. The terraform (tf) resources in this repo will help manage the following config/policy as code

- [Repository Indexing (xray_binary_manager_repos)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/binary_manager_repos)
  
- [Build Indexing (xray_binary_manager_builds)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/binary_manager_builds)
  
- [Release Bundle (xray_binary_manager_release_bundles_v2)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/binary_manager_release_bundles_v2)
  
- [Repository Config (xray_repository_config)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/repository_config)
  
- [Security Policy as Code (xray_security_policy)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/security_policy)
  
- [License Policy as Code (xray_license_policy)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/operational_risks_report)
  
- [Operation Risk Policy as Code (xray_operational_risk_policy)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/security_policy)
  
- [Xray Watches (xray_watch)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/watch)


### Prerequisites
Before proceeding please ensure the following labs are completed
- [Lab-0 - Configure JFrog CLI](../../lab-0-Configure-JFrog-CLI/)
- [Lab-1 - Repository Provisioning](../../module1-artifactory-automation/lab-1-Repository-Provisioning/)
- [Lab 3 - Build and Replication](../../module1-artifactory-automation/lab-3-Build-and-Replication/)

## Getting Started
The content is broken down into the following sections to help with the flow.
```
├── 1_resource_indexing
├── 2_repo_config
├── 3_policies
└── 4_watches
```

Each folder consists of the following files
```
├── main.tf - Contains the main terraform resources to provision the resources
├── variables.tf - Contains variable declarations used in the main terraform file
├── sample.tfvars - Contains the values to pass into the variable file. By default all tfvars will be ignored by git.
├── outputs.tf - Contains information about config available on the command line
└── versions.tf - Contains required version information for terraform and providers
```

Ensure all the necessary tools are installed before you get started
```
jf -v
tf -v
```
if not installed then download or refer to the [executables folder](../executables/)
- [JFrog CLI version 2.67.0](https://jfrog.com/getcli/)
- [Terraform CLI version 1.8.5](https://releases.hashicorp.com/terraform/1.8.5/)

Let's jump into [resource indexing](./1_resource_indexing/)
```
cd 1_resource_indexing
```