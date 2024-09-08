# 3 - JFrog Xray Indexed Repo config 

The terraform (tf) resources in this folder will help you manage JFrog Xray security, license, and operational risk policies as code.

- [Security Policy as Code (xray_security_policy)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/security_policy)
  
- [License Policy as Code (xray_license_policy)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/operational_risks_report)
  
- [Operation Risk Policy as Code (xray_operational_risk_policy)](https://registry.terraform.io/providers/jfrog/xray/latest/docs/resources/security_policy)

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
JFROG_PROJECT_NAME="foobar123"
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

Let's move on to [Attaching policies to resources using watches](../4_watches/))