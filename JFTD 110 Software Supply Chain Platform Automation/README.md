# Lab 0 - Configure JFrog CLI

## Prerequisites

Ensure that JFrog CLI is installed on your machine.

### Check Installation

Run the following command to verify that JFrog CLI is installed:

```bash
jf -v
```

If JFrog CLI is not installed, download it from the JFrog CLI downloads page.

Option 1 - Set Up JFrog CLI with Main JPD
Check Current JFrog CLI Configurations

Run the following command to list all JFrog CLI configurations:

```bash
jf config show
```
Configure JFrog CLI

Add a new configuration that points to your JFrog instance:

```bash
jf config add --interactive
```
Choose a server ID: e.g., swampup
JFrog platform URL: https://{{host}}.jfrog.io (Replace {{host}} with your JFrog Cloud instance URL)
JFrog access token: Leave blank if using username and password/API key (Generate access token from UI: Administration -> Identity and Access -> Access Tokens)
Artifactory reverse proxy: Is it configured to accept a client certificate? (y/n) [n]
Use the New Configuration

Use the newly created configuration:

```bash
jf config use swampup
```
Health Check

Verify the connection to your JFrog instance:

```bash
jf rt ping
```