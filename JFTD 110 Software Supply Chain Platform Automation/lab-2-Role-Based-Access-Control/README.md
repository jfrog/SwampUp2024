# LAB 2 - Role-Based Access Control

## Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Repository Provisioning

## CREATE USER (Internal)
- Please review the CSV that is part of the lab where `username`, `password`, `email` defined for few test users
- Run the following command to create users from the CSV file:
```bash
- jf rt users-create --csv users.csv
 ```
or
```bash
``jf rt uc --csv users.csv
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
    - Run

      ```bash 
         jf rt group-add-users "developers" "mike,jennifer" 
      ```

      or
      ```bash 
         jf rt gau "developers" "mike,jennifer"
     ```


- ops - bob, rolando, jennifer, support
    - Run

  ```bash 
     jf rt group-add-users "ops" "bob,jennifer,rolando,support"
   ```
    or
    ```bash 
     jf rt gau "ops" "bob,jennifer,rolando,support"
   ```
- secops - irene, matt, jennifer
    - Run

      ```bash 
         jf rt group-add-users "secops" "irene,matt,jennifer"
      ```

      or
      ```bash 
         jf rt gau "secops" "irene,matt,jennifer"
     ```

- secops - irene, matt, jennifer
    - Run
            
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
- Run

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
- Run

```bash
jf rt group-delete developers
```

<br />
<br />

## JFrog Project
- JFrog Projects is a management entity for hosting your resources (repositories, builds, Release Bundles, and Pipelines), and for associating users/groups as members with specific entitlements. 
- As such, using projects helps Platform Admins to offload part of their day-to-day management effort and to generate a better separation between the customer products to improve customer visibility on efficiency, scale, cost, and security. 
- Projects simplifies the onboarding process for new users, and create better visibility for LOBs and project stakeholders.
- Review and RUN
  ```bash 
  sh project.sh
  ```

## CHALLENGE - RBAC [Optional]
- Remove `deleteme` users from artifactory
- Update ``development`` permission target and give ``ops`` group ``managedXrayMeta`` permission
- Use JFrog [Project Terraform provider](https://registry.terraform.io/providers/jfrog/project/latest)
