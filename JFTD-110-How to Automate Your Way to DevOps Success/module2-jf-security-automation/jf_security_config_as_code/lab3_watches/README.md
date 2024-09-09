# Lab 3 - JFrog Xray Indexed Repo config 

The terraform (tf) resources in this folder will help you map JFrog Xray security, license, and operational risk policies to different jfrog resources (repos, builds, release bundles).

- [Xray Watches (xray_watch)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/watch)
  
### Prerequisites
Before proceeding please ensure the following labs are completed
- [lab1_resource_indexing](../lab1_resource_indexing/)
- [lab2_policies](../lab2_policies/)

## Getting Started
Ensure you are in the right folder - `SwampUp2024/JFTD-110-How to Automate Your Way to DevOps Success/module2-jf-security-automation/jf_security_config_as_code/lab3_watches`

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
```
vi swampup.tfvars
```

Below listed are the values for reference.
```
JFROG_PLATFORM_URL="swampup17242726643.jfrog.io" 
JFROG_PLATFORM_ACCESS_TOKEN="XXXXXX"

JFROG_PROJECT_NAME="puser--"

EMAIL_LIST_XRAY_VIOLATION=[""]

ACTIVATE_POLICIES=false
```

**Step 3 -** Initialize terraform 
```
terraform init
```

**Step 4 -** Generate terraform plan
```
terraform plan -var-file=swampup.tfvars
```

**Step 5 -** Apply terraform changes
```
terraform apply -var-file=swampup.tfvars
```

#### Let's proceed with [Lab 4 - repo config](../lab4_repo_config/)