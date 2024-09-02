# LAB 2 - Role-Based Access Control

## Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Repository Provisioning

## JFrog Project
### Step 1: Set Environment Variables 
You can set environment variables directly in your shell session
 ```bash 
 export baseUrl="https://your-jfrog-instance.com replace with your_jfrog_instance"
 ```
 ```bash 
 export project_key="replace with your_project"
 ```
 ```bash
  export token="replace your_access_or_identity_token"
 ```

### Step 2: Get Project Details
 ```bash 
curl -XGET "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}" \
-H "Authorization: Bearer ${ACCESS_TOKEN}"
  ```

### Step 3: # Get Project Users
 ```bash 
curl -XGET "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/users" \
-H "Authorization: Bearer ${ACCESS_TOKEN}"
  ```
### Step 4: # Add User in Project
 ```bash 
curl -XPUT "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/users/mike" \
-H "Authorization: Bearer ${ACCESS_TOKEN}" \
-H "Content-Type: application/json" \
-d "@add-user.json"
  ```
### Step 5: # Update User in Project
 ```bash 
curl -XPUT "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/users/mike" \
-H "Authorization: Bearer ${ACCESS_TOKEN}" \
-H "Content-Type: application/json" \
-d "@update-user.json"
  ```
### Step 6: # Delete User in Project
 ```bash 
curl -XDELETE "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/users/mike" \
-H "Authorization: Bearer ${ACCESS_TOKEN}" \
-H "Content-Type: application/json"
  ```
### Step 7: # GET PROJECT ROLES
 ```bash 
curl -XGET "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/roles" \
-H "Authorization: Bearer ${ACCESS_TOKEN}"
  ```
### Step 8: # Delete role in Project
 ```bash 
curl -XDELETE "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/roles/SeniorDeveloper" \
-H "Authorization: Bearer ${ACCESS_TOKEN}"
  ```
### Step 9: # Add role in Project
 ```bash 
curl -XPOST "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/roles" \
-H "Authorization: Bearer ${ACCESS_TOKEN}" \
-H "Content-Type: application/json" \
-d "@add-role.json"
  ```
### Step 10: # Update role in Project
 ```bash 
curl -XPUT "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/roles/SeniorDeveloper" \
-H "Authorization: Bearer ${ACCESS_TOKEN}" \
-H "Content-Type: application/json" \
-d "@update-role.json"
  ```

## [Optional]

## RUN SCRIPT - if you want to skip Step 1 - Step 10
- Run
```bash
sh lab_2_rescue.sh
 ``` 
and it will get project detail and maintain members, roles

## *** You need Platform Admin Access to run the below section.***
## CREATE USER (Internal)
- Please review the CSV that is part of the lab where `username`, `password`, `email` defined for few test users
- Run the following command to create users from the CSV file:
```bash
jf rt users-create --csv users.csv
 ```
or
```bash
jf rt uc --csv users.csv
 ```

## CREATE GROUPS AND ADD USERS TO GROUPS
**Create Groups**
- Run the following command to create developers group:
```bash
jf rt group-create developers
 ```
- or 
```bash
jf rt gc developers
 ```
- Run the following command to create OPS group:
```bash
jf rt group-create ops
```
or
 ```bash
 jf rt gc ops
  ```
Run the following command to create secops group:
```bash 
jf rt group-create secops
```
 or
```bash
 jf rt gc secops
 ```


**Adding Users to Groups**
- Developers - mike,jennifer
    - Run the following command to add users to the developers group:
      ```bash 
         jf rt group-add-users "developers" "mike,jennifer" 
      ```
      or
      ```bash 
         jf rt gau "developers" "mike,jennifer"
     ```
- ops - bob, rolando, jennifer, support
  - Run the following command to add users to the ops group:

    ```bash 
     jf rt group-add-users "ops" "bob,jennifer,rolando,support"
     ```
    or
    ```bash 
     jf rt gau "ops" "bob,jennifer,rolando,support"
     ```
- secops - irene, matt, jennifer
  - Run the following command to add users to the secops group:
    ```bash 
       jf rt group-add-users "secops" "irene,matt,jennifer"
    ```
    or
    ```bash 
       jf rt gau "secops" "irene,matt,jennifer"
     ```

- secops - irene, matt, jennifer
- Run the following command to add users to the secops group: 
    ```bash 
        jf rt group-add-users "secops" "irene,matt,jennifer"
    ``` 
  or
    ```bash 
        jf rt gau "secops" "irene,matt,jennifer"
    ```
<br />

## CREATE PERMISSION TARGET TEMPLATE
- Run

  ```bash 
      jf rt permission-target-template pt-template.json
   ```
    or
  ```bash
     jf rt ptt pt-template.json
  ```
- Insert the permission target name > `development`

- You can type ":x" at any time to save and exit.
- Select the permission target section to configure (press Tab for options): `repo` <br/>
- Insert the section's repositories value. <br/>
- You can specify the name "ANY" to apply to all repositories, "ANY REMOTE" for all remote repositories or "ANY LOCAL" for all local repositories:
- Insert a value for repositories: ↵
- The value should be a comma separated list > `ANY`
- Insert a value for include-patterns: ↵
- The value should be a comma separated list (press enter for default) [**]: ↵
- Insert value for exclude-patterns: ↵
- The value should be a comma separated list (press enter for default) []: ↵
- Configure actions for users? (press Tab for options): [yes]: `no`
- Insert user name (press enter to finish) > ↵
- Configure actions for groups? [yes]: `yes`
- Insert group name (press enter to finish) > `developers`
- Select permission value for developers (press tab for options or enter to finish) > `read`
- Select permission value for developers (press tab for options or enter to finish) > `write`
- Select permission value for developers (press tab for options or enter to finish) > ↵
- Insert group name (press enter to finish) > `secops`
- Select permission value for secops (press tab for options or enter to finish) > `managedXrayMeta`
- Select permission value for secops (press tab for options or enter to finish) > ↵
- Insert group name (press enter to finish) > `ops`
- Select permission value for ops (press tab for options or enter to finish) > `manage`
- Select permission value for ops (press tab for options or enter to finish) > `write`
- Select permission value for ops (press tab for options or enter to finish) > ↵
- Insert group name (press enter to finish) > ↵
- Select the permission target section to configure (press Tab for options): `build`
- Insert a value for include-patterns: ↵
- The value should be a comma separated list (press enter for default) [**]: ↵
- Insert value for exclude-patterns: ↵
- The value should be a comma separated list (press enter for default) []: ↵
- Configure actions for users? (press Tab for options): [yes]: `no`
- Insert user name (press enter to finish) > ↵
- Configure actions for groups? [yes]: `yes`
- Insert group name (press enter to finish) > `ops`
- Select permission value for ops (press tab for options or enter to finish) > `manage`
- Select permission value for ops (press tab for options or enter to finish) > ↵
- Insert group name (press enter to finish) > ↵
- Select the permission target section to configure (press Tab for options): `:x`

<br />

## CREATE PERMISSION TARGET USING TEMPLATE
- Run the following command to create a permission target using the template:
  ```bash
  jf rt permission-target-create pt-template.json
  ```
  or
  ```bash
  jf rt ptc pt-template.json
  ```

  ```json
 ###NOTE:
    --var - List of variables in the form of "key1=value1;key2=value2;..." to be replaced in the template.
  
```bash
   jf rt permission-target-create pt-template.json``
```
or
```bash
  jf rt ptc pt-template.json
```

    
###NOTE:
    --var - List of variables in the form of "key1=value1;key2=value2;..." to be replaced in the template.

<br />


### Delete User (Internal) - [POST SESSION TASK]
- Run

```bash
jf rt users-delete users.csv --quiet``
```
or

```bash
jf rt udel --csv users.csv --quiet``
```
<br />

### Delete Group - [POST SESSION TASK]
- Run the following command to delete the developers group:

```bash
jf rt group-delete developers
```

<br />
<br />
