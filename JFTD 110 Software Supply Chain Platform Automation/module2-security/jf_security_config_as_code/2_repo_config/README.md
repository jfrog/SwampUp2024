# 2 - JFrog Xray Indexed Repo config 

The terraform (tf) resources in this folder will help you manage config of indexed repositories.

- [Repository Config (xray_repository_config)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/repository_config)

> **NOTE**
> Modifications to the indexed repos config will need privileged access

## Getting Started
Purpose of the various terraform files used 

```
├── main.tf - Contains the main terraform resources to provision the resources
├── variables.tf - Contains variable declarations used in the main terraform file
├── sample.tfvars - Contains the values to pass into the variable file. By default all tfvars will be ignored by git.
├── outputs.tf - Contains information about config available on the command line
└── versions.tf - Contains required version information for terraform and providers
```

Create a copy of the `sample.tfvars` and add in your custom values. NOTE - all `.tfvars` files will be git ignored except `sample.tfvars`. Please do not modify sample.tfvars
```
cp sample.tfvars swampup.tfvars
```

Below listed are the values for reference.
```
JFROG_PLATFORM_URL="foo.jfrog.io" 
JFROG_PLATFORM_ACCESS_TOKEN="XXXXXX"

REPO_NAME_LIST=["swampup-docker-dev-local","swampup-npm-dev-local"]

JAS_ENABLED=true
VULN_CONTEXTUAL_ANALYSIS_STATUS=true
EXP_SCAN_SECRETS_STATUS=true
EXP_SCAN_IAC_STATUS=true
EXP_SCAN_SERVICES_STATUS=true
EXP_SCAN_APPLICATIONS_STATUS=true
XRAY_SCAN_DATA_RETENTION_DAYS=180
```

Initialize terraform 
```
tf init
```

Generate terraform plan
```
tf plan -var-file=swampup.tfvars
```

Apply terraform changes
```
tf apply -var-file=swampup.tfvars
```

Let's move on to [Xray Policy Creation](../3_policies/)