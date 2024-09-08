# Lab 4 - JFrog Security Shift Left scans

### Prerequisites
Before proceeding please ensure the following labs are completed
- [Lab-0 - Configure JFrog CLI](../../lab-0-Configure-JFrog-CLI/)
- [Lab-1 - Repository Provisioning](../../module1-artifactory-automation/lab-1-Repository-Provisioning/)
- [Lab 3 - Build and Replication](../../module1-artifactory-automation/lab-3-Build-and-Replication/)

## Getting Started

Set the following values before proceeding
```
export JF_PROJECT="" 
export JF_INSTANCE="swampup17242726643.jfrog.io" 
export JF_BUILD_NAME="demo-node-app"
export JF_BUILD_NUMBER="1.0.0"
```

Navigate to the [example demo-node-app](../../../module1-artifactory-automation/lab-3-Build-and-Replication/example/demo-node-app/) directory used in Module 1 - Artifactory Automation, Lab 3 Build and Replication.
```
cd SwampUp2024/JFTD-110-How to Automate Your Way to DevOps Success/module1-artifactory-automation/lab-3-Build-and-Replication/example/demo-node-app
```

### JF Audit
Perform jf audit which allows scanning your source code dependencies to find security vulnerabilities and licenses violations, with the ability to scan against your Xray policies.
```
jf audit
```

### JF Docker Scan
jf docker scan command scans docker containers located on the local file-system using the docker client and JFrog Xray. 
```
jf docker scan $JF_INSTANCE.jfrog.io/$JF_PROJECT-demonodeapp-docker-dev-virtual/$JF_BUILD_NAME:$JF_BUILD_NUMBER
```

### JF Curation Audit
JFrog Curation defends your software supply chain, enabling early blocking of malicious or risky open-source packages before they even enter. Seamlessly identify harmful, vulnerable, or risky packages, ensuring increased security, compliance, and developer productivity.

The 'curation-audit' is a JFrog CLI command designed for developers to scan their projects and identify third-party dependencies that violate the restrictions set by the Curation service. 

```
jf curation audit
```