# LAB 1 - Repository Provisioning

## Prerequisites
Lab-0 - Configure JFrog CLI

<br />


## CREATE REPOSITORY TEMPLATE
Run the following command to create a local repository template:
```bash
jf rt repo-template template-local.json
```
  - Select the template type (press Tab for options): `create`
  - Insert the repository key > `auth-npm-dev-local`
  - Select the repository class (press Tab for options): `local`
  - Select the repository's package type (press Tab for options): `npm`
  - You can type ":x" at any time to save and exit.
  - Select the next configuration key (press Tab for options): `repoLayoutRef`
  - Insert the value for repoLayoutRef (press Tab for options): > `npm-default`
  - Select the next configuration key (press Tab for options): `environment`
  - Insert the name of the environment to assign to > `DEV`
  - Select the next configuration key (press Tab for options): `xrayIndex`
  - Insert the value for xrayIndex (press Tab for options): > `true`
  - Select the next configuration key (press Tab for options): `:x`
  - Validate template `template-local.json` is created successfully. - ``ls -la``
- 
- View template
 ```json
    {
     "key":"${repo-name}",                
     "packageType":"${package-type}",     
     "rclass":"${repo-type}",             
     "repoLayoutRef":"${repo-layout}",    
     "environments":"${env}",             
     "xrayIndex":"${xray-enable}"         
}
```

Run the following command to create a local repository template:
```bash
jf rt repo-template template-remote.json
```
  - Select the template type (press Tab for options): `create`
  - Insert the repository key > `npm-remote`
  - Select the repository class (press Tab for options): `remote`
  - Insert the remote repository URL > `https://registry.npmjs.org`
  - Select the repository's package type (press Tab for options): `npm`
  - You can type ":x" at any time to save and exit.
  - Select the next configuration key (press Tab for options): `repoLayoutRef`
  - Insert the value for repoLayoutRef (press Tab for options): > `npm-default`
  - Select the next configuration key (press Tab for options): `environment`
  - Insert the name of the environment to assign to > `DEV`
  - Select the next configuration key (press Tab for options): `xrayIndex`
  - Insert the value for xrayIndex (press Tab for options): > `true`
  - Select the next configuration key (press Tab for options): `:x`
  - Validate template `template-remote.json` is created successfully. ``ls -la``
- 
- View template
 ```json
          {
            "key":"${repo-name}",
            "packageType":"${package-type}",
            "rclass":"${repo-type}",
            "url":"${url}",
            "repoLayoutRef":"${repo-layout}",
            "environments":"${env}",           
            "xrayIndex":"${xray-enable}"
          }
```

Run the following command to create a local repository template:
```bash
jf rt repo-template template-virtual.json
```        
  - Select the template type (press Tab for options): `create`
  - Insert the repository key > `auth-npm-dev-virtual`
  - Select the repository class (press Tab for options): `virtual`
  - Select the repository's package type (press Tab for options): `npm`
  - You can type ":x" at any time to save and exit.
  - Select the next configuration key (press Tab for options): `repoLayoutRef`
  - Insert the value for repoLayoutRef (press Tab for options): > `npm-default`
  - Select the next configuration key (press Tab for options): `environment`
  - Insert the name of the environment to assign to > `DEV`
  - Select the next configuration key (press Tab for options): `repositories`
  - The value should be a comma separated list:
  - Insert the value for repositories > `auth-npm-dev-local,npm-remote`
  - Select the next configuration key (press Tab for options): `externalDependenciesRemoteRepo`
  - Insert the value for externalDependenciesRemoteRepo > `auth-npm-remote`
  - Select the next configuration key (press Tab for options): `defaultDeploymentRepo`
  - Insert the value for defaultDeploymentRepo > `auth-npm-dev-local`
  - Select the next configuration key (press Tab for options): `:x`
- 
- Validate template `template-remote.json` is created successfully. ``ls -la``
- View template
 ```json
          {
            "key":"${repo-name}",
            "packageType":"${package-type}",
            "rclass":"${repo-type}",
            "repoLayoutRef":"${repo-layout}",
            "defaultDeploymentRepo":"${deploy-repo-name}",
            "externalDependenciesRemoteRepo":"${external-remote-repo-name}",
            "environments":"${env}",
            "repositories": "${repos}"
          }
```

<br />

## CREATE REPOSITORY
- Run
```bash
jf rt repo-create template-{{ local|remote|virtual }}.json
```
  or
  
```bash
jf rt rc template-{{ local|remote|virtual }}.json
```

NOTE: 

--var - List of variables in the form of "key1=value1;key2=value2;..." to be replaced in the template.

```bash
jf rt rc template-local.json --var "repo-name=sup016-npm-qa-local"
```

- We are going to run this for local and remote repository. For virtual please skip this step and proceed with next step.

<br />


## RUN SCRIPT - Prerequisites for future labs that CREATES ALL REPOSITORIES [MUST]
- Run
```bash
sh lab_1_rescue.sh
 ``` 
and it will create all local, remote, virtual repositories.

<br />

## CHALLENGE - Update Repository [Optional]
- Disable indexing in Xray for one repository we created above
- Update the description for one repository we created above
- Configure repository with Include/Exclude Pattern
- For remote repository, update metadata retrieval cache period in secs. (default: 7200secs)
