# Lab 0 - Configure JFrog CLI

## Prerequisites

Ensure that JFrog CLI is installed on your machine.

### Check Installation

Run the following command to verify that JFrog CLI is installed:

```bash
jf -v
```

```html
<pre style="background-color: black; color: white; padding: 10px;">
jf -v
</pre>
if not installed then Download [JFrog CLI](https://jfrog.com/getcli/) based on our machine.

## Option 1 - Set Up JFrog CLI with Main JPD
Check Current JFrog CLI Configurations

1. Run the following command to list all JFrog CLI configurations:

```bash
jf config show
```
2. Configure JFrog CLI

Add a new configuration that points to your JFrog instance:

```bash
jf config add --interactive
```
Choose a server ID: e.g., swampup
- Configure CLI that point to JFrog Instance
```bash 
 jf config add --interactive
 ``` 
or
```bash 
 jf c add --interactive
 ``` 
    
- Enter a unique server identifier: ```${{unique name}}```        # like -> `swampup`
- JFrog platform URL: ```https://{{host}}.jfrog.io```             # JFrog Cloud instance URL from document
- JFrog access token (Leave blank for username and password/API key): ```${{access_token}}```
- Create access token from UI ``Administration`` -> ``Identity and Access`` -> ``Access Tokens``
- Is the Artifactory reverse proxy configured to accept a client certificate (y/n) [n]?: ``n``


3. Use the newly created configuration:

```bash
jf config use swampup
```
4. Health Check

Verify the connection to your JFrog instance:

```bash
jf rt ping
```

## Option 2: Setup JFrog CLI with Main JPD (Non-Interactive)

### Step 1: Add Configuration for Main JPD
To configure JFrog CLI without interaction, use the following command:
```bash
jf config add swampup --artifactory-url=https://$JFROG_PLATFORM/artifactory --user=$ADMIN_USER --password=$ADMIN_PASSWORD --interactive=false
```

### Step 2: Add Configuration for Edge Node
To add configuration for an edge node, use the following command:
```bash
jf config add swampupedge --artifactory-url=https://$JFROG_EDGE/artifactory --user=$ADMIN_USER --password=$ADMIN_PASSWORD --interactive=false
```

## Optional Challenge: Export and Import JFrog CLI Configurations

### Export Configuration
To export a JFrog CLI configuration, run:
```bash
jf config export swampup
```
This generates a token that can be used to import the configuration on another system.

### Import Configuration
On the target system, import the configuration using the token:
```bash
jf config import $TOKEN
```

---

**Note:** Replace all placeholders (e.g., `$JFROG_PLATFORM`, `$ADMIN_USER`, `$TOKEN`) with the appropriate values specific to your environment.