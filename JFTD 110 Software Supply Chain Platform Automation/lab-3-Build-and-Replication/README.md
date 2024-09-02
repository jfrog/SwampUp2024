# LAB 3 - Build, Properties and Replication

## Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Repository Provisioning
- Lab-2 - Role-Based Access Control

## BUILDING AND DEPLOYING
- One of the Package Manager Integration we can use

#### MAVEN - Package Manager Integration
- `cd lab-3-Build-and-Replicate/example/maven-example`
- To pre-configured with the Artifactory server, repositories and use for building and publishing. The configuration is stored by the command in the .jfrog directory at the root directory of the project.)
    - Run the following command to configure Maven to resolve dependencies from Artifactory and deploy project artifacts to Artifactory:
      - ```bash 
        jf mvnc
        ```
    - Resolve dependencies from Artifactory? (y/n) [y]? `y`
    - Set Artifactory server ID [swampup]: ↵
    - Set resolution repository for release dependencies (press Tab for options): `{projectKey}-payment-maven-dev-virtual`
    - Set resolution repository for snapshot dependencies (press Tab for options): `{projectKey}-payment-maven-dev-virtual`
    - Deploy project artifacts to Artifactory? (y/n) [y]? `y`
    - Set Artifactory server ID [swampup]: ↵
    - Set repository for release artifacts deployment (press Tab for options): `{projectKey}-payment-maven-dev-virtual`
    - Set repository for snapshot artifacts deployment (press Tab for options): `{projectKey}-payment-maven-dev-virtual`
    - Would you like to filter out some of the deployed artifacts? (y/n) [n]? `n`
- Run 
-   ```bash 
       jf mvn clean install -f ./pom.xml --build-name payment-maven --build-number 1.0.0
      ```

#### NPM - Package Manager Integration
- `cd lab-3-Build-and-Replicate/example-project/npm-example`
- To pre-configured with the Artifactory server, repositories and use for building and publishing. The configuration is stored by the command in the .jfrog directory at the root directory of the project.)
    - Run 
    - ```bash
         jf npmc
      ```
    - Resolve dependencies from Artifactory? (y/n) [y]? `y`
    - Set Artifactory server ID [swampup]: ↵
    - Set repository for dependencies resolution (press Tab for options): `{projectKey}-auth-npm-dev-virtual`
    - Deploy project artifacts to Artifactory? (y/n) [y]? `y`
    - Set Artifactory server ID [swampup]: ↵
    - Set repository for artifacts deployment (press Tab for options): `{projectKey}-auth-npm-dev-virtual`
- Run ```bash jf npm install --build-name auth-npm --build-number 1.0.0``
- To Publish build Artifact to repository
  - Run 
    ```bash 
       jf npm publish --build-name auth-npm --build-number 1.0.0
    ```


<br />
<br />

## COLLECT ENVIRONMENT VARIABLES
#### Maven
- Run

  ```bash 
    jf rt build-collect-env payment-maven 1.0.0
    ```
  or
  ```bash 
     jf rt bce payment-maven 1.0.0
  ```


#### NPM
- Run 
   ```bash
     jf rt bce auth-npm 1.0.0
    ```

<br />
<br />


## COLLECT INFORMATION REGARDING GIT
#### Maven
- Run

  ```bash jf rt build-add-git payment-maven 1.0.0``` - (.git path[Optional] - Path to a directory containing the .git directory. If not specific, the .git directory is assumed to be in the current directory or in one of the parent directories.)

  or

  ```bash jf rt bag payment-maven 1.0.0```

#### NPM
- Run ```bash jf rt bag auth-npm 1.0.0```  - (.git path[Optional] - Path to a directory containing the .git directory. If not specific, the .git directory is assumed to be in the current directory or in one of the parent directories.)

<br />
<br />


## PUBLISH BUILD-INFO
#### Maven publish build-info
- Run 
  ```bash 
    jf rt bp payment-maven 1.0.0
    ```

#### NPM publish build-info
- Run 
  - ```bash
      jf rt bp auth-npm 1.0.0
    ```


<br />
<br />

## Promoting a Build
#### Maven
- Run 
  - ```bash 
      jf rt bpr payment-maven 1.0.0 payment-maven-qa-local --status='QA candidate' --comment='webservice is now QA candidate and hand over for regression test' --copy=true --props="maintainer=maharship;stage=qa"
    ```

#### NPM
- Run 
  - ```bash
     jf rt bpr auth-npm 1.0.0 auth-npm-qa-local --status='QA candidate' --comment='webservice is now QA candidate and hand over for regression test' --copy=true --props="maintainer=maharship;stage=qa"
    ```

NOTE: [Command Options](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-PromotingaBuild)

<br />
<br />


### Add Files as Build Dependencies [OPTIONAL]
- Run

  ```bash 
    jf rt build-add-dependencies payment-maven 1.0.0 "path/to/build/dependencies/dir/"
  ```

  or

  ```bash 
    jf rt bad payment-maven 1.0.0 "path/to/build/dependencies/dir/"
  ```

<br />
<br />

### Aggregate Published Builds [OPTIONAL]
- Create and publish build 1 for multi1
    - Run 
      ```bash 
        jf rt upload "multi1/*.zip" payment-maven-virtual --build-name multi1-build --build-number 1 --module multi1
      ```
      - Run
        ```bash 
        jf rt bp multi1-build 1
        ```
- Create and publish build 1 for multi2
    - Run the following command to upload the build artifacts to Artifactory and publish the build information:
      ```bash 
        jf rt upload "multi2/*.zip" payment-maven-virtual --build-name multi2-build --build-number 1 --module multi2
      ```
    - Run 
      ```bash 
        jf rt bp multi2-build 1
      ```
  - Aggregate Builds
      - Run the following command to aggregate the builds:
        ```bash 
        jf rt build-append payment-maven 1.0.0 multi1-build 1
        ```
        - Run the following command to aggregate the builds:
      ```bash 
      jf rt build-append payment-maven 1.0.0 multi2-build 1
      ```
- Run 
  - ```bash
      jf rt bp payment-maven 1.0.0
    ```

<br />
<br />

### Collect Dependencies [OPTIONAL]
- the following command downloads the ``shiro-core-1.7.1.jar`` file found in repository ``{{repository}}`` , but it also specifies this file as a dependency in build ``payment-maven`` with build number ``1.0.0``
    - Run ```bash jf rt dl {{repository}}/org/apache/shiro/shiro-core/1.7.1/shiro-core-1.7.1.jar --build-name=payment-maven --build-number=1.0.0``` - downloads the `shiro-core-1.7.1.jar` file found in repository ``{{repository}}`` , but it also specifies this file as a dependency in build

<br />
<br />
<br />

## Properties
### Set Properties
#### Maven
- Run
  ```bash 
    jf rt set-props "payment-maven-qa-local/org/jfrog/test/" "unit.test=pass;integration.test=null;"
   ```

  or

  ```bash
  jf rt sp "payment-maven-qa-local/org/jfrog/test/" "unit.test=pass;integration.test=null;"
  ```


#### NPM
- Run

  ```bash 
     jf rt set-props "auth-npm-dev-local/npm-example/-/npm-example-1.1.5.tgz" "unit.test=pass;integration.test=null;"
  ```

  or

  ```bash 
     jf rt sp "auth-npm-dev-local/npm-example/-/npm-example-1.1.5.tgz" "unit.test=pass;integration.test=null;"
  ```

<br />
<br />


## RUN SCRIPT
- Run 
```bash 
sh lab_3_build_rescue.sh
```

<br />
<br />

## SETTING UP A CI PIPELINE [Optional - MUST for POST SESSION]
- Run ``jf ci-setup``, **auto generate yml or jenkins file with CLI Steps**
    - The ci-setup command allows setting up a basic CI pipeline with the JFrog Platform, while automatically configuring the JFrog Platform to serve the pipeline. It is an interactive command, which prompts you with a series for questions, such as your source control details, your build tool, build command and your CI provider. The command then uses this information to do following:
        - Create the repositories in JFrog Artifactory, to be used by the pipeline to resolve dependencies.
        - Configure JFrog Xray to scan the build.
        - Generate a basic CI pipeline, which builds and scans your code.
    - You can use the generated CI pipeline as a working starting point and then expand it as needed.
    - Supported CI providers - Jenkins, JFrog Pipeline and Github Action
        - example projects [here](https://github.com/jfrog/SwampUp2022/tree/main/SUP016-Automate_everything_with_the_JFrog_CLI/ci-example)
        - **[Demo](https://youtu.be/JvEmihsjxjQ)**

<br />
<br />


# Configure Replication [Optional - Multisite Topology Setup]

## CREATE REPLICATION TEMPLATE
- Run

  ```bash
   jf rt replication-template template-pull.json
  ```

  or

  ```bash 
    jf rt rplt template-pull.json
  ```

    - Select replication job type (press Tab for options): `pull`
    - Enter source repo key > `swampup-docker-main`          # Smart Repository (Remote repository pointing other repository from other Artifactory instance)
    - Enter cron expression for frequency (for example, 0 0 12 * * ? will replicate daily) > `*/10 * * * * ?`
    - You can type ":x" at any time to save and exit.
    - Select the next property > `enabled`
    - Insert the value for enabled (press Tab for options): > `true`
    - Select the next property > `enableEventReplication`
    - Insert the value for enableEventReplication (press Tab for options): > `true`
    - Select the next property > `syncDeletes`
    - Insert the value for syncDeletes (press Tab for options): > `true`
    - Select the next property > `syncProperties`
    - Insert the value for syncProperties (press Tab for options): > `true`
    - Select the next property > `syncStatistics`
    - Insert the value for syncStatistics (press Tab for options): > `true`
    - Select the next property > `:x`

- Validate template template-pull.json is created successfully. `- ls -la`
- View template

      ```json
      {
        "cronExp": "*/10 * * * * ?",
        "enableEventReplication": "true",
        "enabled": "true",
        "repoKey": "swampup2022-docker-main",
        "syncDeletes": "true",
        "syncProperties": "true",
        "syncStatistics": "true"
      }
      ```

<br />

## CREATE REPLICATION USING TEMPLATE
- Run

  ```bash
    jf rt replication-create template-pull.json --vars "url=https://lunchnlearn.jfrog.io/artifactory/docker-main/"
  ```

  or

  ```bash 
  jf rt rplc template-pull.json --vars "url=https://lunchnlearn.jfrog.io/artifactory/docker-main/"
  ```

<br />
<br />

## **Blog**
[Replication: Using Artifactory to Manage Binaries Across Multi-Site Topologies](https://jfrog.com/whitepaper/replication-using-artifactory-to-manage-binaries-across-multi-site-topologies/)

<br />
<br />

## RUN SCRIPT
- Run 
  ```bash
     sh lab_3_replication_rescue_optional.sh
  ```

## CHALLENGE 1 - Update Properties [Optional]
- Add new property to sub-folder inside the artifact - HINT: We need that property to be tagged to each and every single file of the Artifact recursively.
- Update the ``integration.test`` to ``pass`` or ``fail``
- NEED to be tested - Fetch all the artifacts under repository that does not have properties `"unit.test=pass;integration.test=pass;"`
- [Discard](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-DiscardingOldBuildsfromArtifactory) 60 days Old builds from Artifactory
    - HINT: ``jf rt build-discard`` or ``jf rt bdi``

## CHALLENGE 2 - Replications [Optional]
- Setup Push based replication between two instances.
  - NOTE: target serverId requires JFrog CLI config with username/password  - In lab-0, we used access token. Instead of that we need to use username/password.



