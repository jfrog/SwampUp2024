# Lab 0 - Configure JFrog CLI

## Prerequisites

Ensure that JFrog CLI is installed on your machine.

### Check Installation

Run the following command to verify that JFrog CLI is installed:

```bash
jf -v
```

if not installed then Download [JFrog CLI](https://jfrog.com/getcli/) based on our machine.

### Check Host, Authentication Details

Ensure that you have the following details from the email you have received:
`$JFROG_PLATFORM`, `$JFROG_EDGE`,`$ADMIN_USER`,`$ADMIN_PASSWORD` are the placeholders for the JFrog Platform URL, Edge Node URL, Project Admin User, and Project Admin Password, respectively.
- Create access token from UI
  - Goto JFrog Platform URL `$JFROG_PLATFORM` and use the credentials `$ADMIN_USER` and `$ADMIN_PASSWORD` to login
  - click the initials of your username on the top right-hand corner of the screen to view the User Profile menu ``User Profile``-> ``Edit Profile`` -> ``Generate An Identity Token``-> ``Next`` -> ``Copy the token`` -> ``Close``
  - Replace all placeholders (e.g., `$JFROG_PLATFORM`, `$JFROG_EDGE`,`$ADMIN_USER`,`$ADMIN_PASSWORD`, `$ACCESS_TOKEN`) with the appropriate values specific to your environment.

## Option 1 - Set Up JFrog CLI with Main JPD
Check Current JFrog CLI Configurations

1. Run the following command to list all JFrog CLI configurations:
```bash
    jf config show
```
2. Configure JFrog CLI
    - Choose a server ID: e.g., swampup
    - Configure CLI that point to JFrog Instance
    ```bash 
     jf config add --interactive
    ``` 
    or
    ```bash 
     jf c add --interactive
     ```
      - Enter a unique server identifier: ```${{unique name}}```        # like -> `swampup`
      - JFrog platform URL: ```https://{{host}}.jfrog.io```             # JFrog Cloud instance URL $JFROG_PLATFORM from document
      - JFrog access token (Leave blank for username and password/API key): ```${{$ACCESS_TOKEN}}``` # Access token generated from JFrog Platform
      - Is the Artifactory reverse proxy configured to accept a client certificate (y/n) [n]?: ``n``

3. Use the newly created configuration:
    ```bash
    jf config use swampup
    ```
4. Health Check
       - Verify the connection to your JFrog instance by running the following command and the result should be 'OK'
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
jf config import $ACCESS_TOKEN
```

---
