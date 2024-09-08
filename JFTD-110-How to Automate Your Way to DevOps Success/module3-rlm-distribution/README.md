# [110 - Software Supply Chain Platform Automation - Create, Distribute, and Automate at Scale](../../JFTD-110-How%20to%20Automate%20Your%20Way%20to%20DevOps%20Success/) 🐸

## Module 3 - JFrog Release Lifecycle Management (RLM) and Distribution
Intro to Release Lifecycle Management (RLM) and Distribution
- RLM Building Blocks
- Release Bundles
- Promotion
- Distribution

Lab - Security config  Automation - Using JFrog CLI
- Release Bundle Management
- Build Promotion Automation
- Secure distribution
  
## Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Repository Provisioning
- Lab-2 - Role-Based Access Control
- Lab 3 - Build and Replication
- Lab 4 - AQL  



### Step 1: Release Bundle V2 Creation 
- `cd lab-5-Release Bundle V2 Creation Promotion Distribution`

- Run the following command to create a release bundle version 2 for the npm package `auth-npm` 
```bash 
       jf rbc --spec=rbv2-npm.json --signing-key=debian-erika auth-npm 2.0.0 --project $projectKey --spec-vars="key1=tftd110tr2"
```
- Run the following command to create a release bundle version 2 for the maven package `payment-maven`
```bash 
       jf rbc --spec=rbv2-maven.json --signing-key=debian-erika payment-maven 2.0.0 --project $projectKey --spec-vars="key1=tftd110tr2"
```

### Step 2: Release Bundle V2 Promotion to QA

- Run the following command to create a release bundle version 2 for the npm package `auth-npm`
```bash 
      jf rbp auth-npm 2.0.0 QA --project $projectKey --signing-key=debian-erika
```
- Run the following command to create a release bundle version 2 for the maven package `payment-maven`
```bash 
       jf rbp payment-maven 2.0.0 QA --project $projectKey --signing-key=debian-erika
```

### Step 3: Release Bundle V2 Promotion to PROD

- Run the following command to create a release bundle version 2 for the npm package `auth-npm`
```bash 
      jf rbp auth-npm 2.0.0 PROD --project $projectKey --signing-key=debian-erika
```
- Run the following command to create a release bundle version 2 for the maven package `payment-maven`
```bash 
       jf rbp payment-maven 2.0.0 PROD --project $projectKey --signing-key=debian-erika
```