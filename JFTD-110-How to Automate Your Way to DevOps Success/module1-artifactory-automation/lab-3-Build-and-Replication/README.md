# LAB 3 - Build, Properties and Replication

## Prerequisites
- [Lab-0 - Configure JFrog CLI](../../lab-0-Configure-JFrog-CLI/)
- [Lab-1 - Repository Provisioning](../lab-1-Repository-Provisioning/)
- [Lab-2 - Role-Based Access Control](../lab-3-Build-and-Replication/)

## BUILDING AND DEPLOYING
JFrog CLI includes integration with maven, npm, go, nuget, pip, docker, gradle, dotnet, poetry, and yard allowing you to resolve dependencies and deploy build artifacts from and to Artifactory, while collecting build-info and storing it in Artifactory.

Below are the instructions for [NPM](#npm---package-manager-integration) and [Maven](#maven---package-manager-integration). 

### NPM and Docker - Package Manager Integration

**Step 1 -** Navigate into the demo-node-app under `lab-3-Build-and-Replicate/example-project/demo-node-app`
```
cd lab-3-Build-and-Replicate/example-project/demo-node-app
```
The `package.json` file has all the npm dependencies needed to run the app.

**Step 2 -** To pre-configured with the Artifactory server, repositories and use for resolving OSS dependencies and publishing. The configuration is stored by the command in the `.jfrog` directory at the root directory of the project.
```
jf npmc 
```
Input the following values
```
Resolve dependencies from Artifactory? (y/n) [y]? `y`
Set Artifactory server ID [swampup]: ↵
Set repository for dependencies resolution (press Tab for options): `{projectKey}-demonodeapp-npm-dev-virtual`
Deploy project artifacts to Artifactory? (y/n) [y]? `y`
Set Artifactory server ID [swampup]: ↵
Set repository for artifacts deployment (press Tab for options): `{projectKey}-demonodeapp-npm-dev-virtual`
```

View the config stored under `.jfrog`
```
cat .jfrog/projects/npm.yaml
```

**Step 3 -** Build the npm app by passing in the build name and build number.

Set the following values before proceeding
```
export JF_PROJECT="" 
export JF_INSTANCE="swampup17242726643.jfrog.io" 
export JF_BUILD_NAME="demo-node-app"
export JF_BUILD_NUMBER="1.0.0"
```

```
jf npm install --build-name $JF_BUILD_NAME --build-number $JF_BUILD_NUMBER --module npm-build --project $JF_PROJECT
```

(Optional) Start the app and open `localhost:3000` in your browser 
```
DEBUG=demo-node-app:* npm start
```

**Step 4 -** Publish the npm build artifact to artifactory
```
jf npm publish --build-name $JF_BUILD_NAME --build-number $JF_BUILD_NUMBER --module npm-build --project $JF_PROJECT
```
On successful upload you should should be able to view the artifact under the npm local dev repo in Artifactory.

**Step 5 -** Perform a docker image build using the `dockerfile` placed under the same folder.
```
jf docker build -t $JF_INSTANCE.jfrog.io/$JF_PROJECT-demonodeapp-docker-dev-virtual/$JF_BUILD_NAME:$JF_BUILD_NUMBER --build-name $JF_BUILD_NAME --build-number $JF_BUILD_NUMBER --module docker-build --project $JF_PROJECT .
```

**Step 6 -** Publish the docker image to artifactory.
```
jf docker push $JF_INSTANCE.jfrog.io/$JF_PROJECT-demonodeapp-docker-dev-virtual/$JF_BUILD_NAME:$JF_BUILD_NUMBER --build-name $JF_BUILD_NAME --build-number $JF_BUILD_NUMBER --module docker-build --project $JF_PROJECT
```

**Step 7 -** Gather the build dependencies, environment variables, and git information.
```
jf rt build-add-git $JF_BUILD_NAME $JF_BUILD_NUMBER --project $JF_PROJECT
jf rt build-collect-env $JF_BUILD_NAME $JF_BUILD_NUMBER --project $JF_PROJECT
```

**Step 8 -** Build the build info to artifactory. Replace the placeholder `PROJECT_KEY` with your actual project key.
```
jf rt build-publish $JF_BUILD_NAME $JF_BUILD_NUMBER --project $JF_PROJECT
```

### MAVEN - Package Manager Integration
**Step 1 -** Navigate into the maven-example app under 
```
cd lab-3-Build-and-Replicate/example/maven-example
```

**Step 2 -** To pre-configured with the Artifactory server, repositories and use for resolving OSS dependencies and publishing. The configuration is stored by the command in the `.jfrog` directory at the root directory of the project.
``` 
jf mvnc
```

**Step 3 -** Input the following values
```
Resolve dependencies from Artifactory? (y/n) [y]? `y`
Set Artifactory server ID [swampup]: ↵
Set resolution repository for release dependencies (press Tab for options): `{projectKey}-payment-maven-dev-virtual`
Set resolution repository for snapshot dependencies (press Tab for options): `{projectKey}-payment-maven-dev-virtual`
Deploy project artifacts to Artifactory? (y/n) [y]? `y`
Set Artifactory server ID [swampup]: ↵
Set repository for release artifacts deployment (press Tab for options): `{projectKey}-payment-maven-dev-virtual`
Set repository for snapshot artifacts deployment (press Tab for options): `{projectKey}-payment-maven-dev-virtual`
Would you like to filter out some of the deployed artifacts? (y/n) [n]? `n`
Use Maven wrapper? (y/n) [y]? `y`
```

View the config stored under `.jfrog`
```
cat .jfrog/projects/maven.yaml
```

**Step 4 -** Build the app using the below command and pass in the build name and build number
``` 
jf mvn clean install -f ./pom.xml --build-name payment-maven --build-number 1.0.0 --project {projectKey}
```

**Step 5 -** Gather the build dependencies, environment variables, and git information.
```
jf rt build-collect-env payment-maven 1.0.0 --project {projectKey}
jf rt build-add-git payment-maven 1.0.0 --project {projectKey}
```

**Step 6 -** Publish the maven build artifact to artifactory
``` 
jf rt bp payment-maven 1.0.0 --project {projectKey}
```

### Add Files as Build Dependencies [OPTIONAL]
- Run
```
jf rt build-add-dependencies payment-maven 1.0.0 "path/to/build/dependencies/dir/"
```
or
```
jf rt bad payment-maven 1.0.0 "path/to/build/dependencies/dir/"
```

### Aggregate Published Builds [OPTIONAL]
Create and publish build 1 for multi1
``` 
jf rt upload "multi1/*.zip" payment-maven-virtual --build-name multi1-build --build-number 1 --module multi1
```
``` 
jf rt bp multi1-build 1
```

Create and publish build 1 for multi2
  - Run the following command to upload the build artifacts to Artifactory and publish the build information:
    ``` 
    jf rt upload "multi2/*.zip" payment-maven-virtual --build-name multi2-build --build-number 1 --module multi2
    ```
  - Run 
    ``` 
      jf rt bp multi2-build 1
    ```
Aggregate Builds
- Run the following command to aggregate the builds:
  ``` 
  jf rt build-append payment-maven 1.0.0 multi1-build 1
  ```
- Run the following command to aggregate the builds:
  ``` 
  jf rt build-append payment-maven 1.0.0 multi2-build 1
  ```
- Run 
  ```
  jf rt bp payment-maven 1.0.0
  ```

## Properties
#### Set Properties
#### Maven
Run
``` 
jf rt set-props "payment-maven-qa-local/org/jfrog/test/" "unit.test=pass;integration.test=null;"
```
or

```
jf rt sp "payment-maven-qa-local/org/jfrog/test/" "unit.test=pass;integration.test=null;"
```


## RUN SCRIPT
- Run 
``` 
sh lab_3_build_rescue.sh
```

## SETTING UP A CI PIPELINE [Optional - MUST for POST SESSION]
Run ``jf ci-setup``, **auto generate yml or jenkins file with CLI Steps**
- The ci-setup command allows setting up a basic CI pipeline with the JFrog Platform, while automatically configuring the JFrog Platform to serve the pipeline. It is an interactive command, which prompts you with a series for questions, such as your source control details, your build tool, build command and your CI provider. The command then uses this information to do following:
    - Create the repositories in JFrog Artifactory, to be used by the pipeline to resolve dependencies.
    - Configure JFrog Xray to scan the build.
    - Generate a basic CI pipeline, which builds and scans your code.
- You can use the generated CI pipeline as a working starting point and then expand it as needed.
- Supported CI providers - Jenkins, JFrog Pipeline and Github Action
    - example projects [here](https://github.com/jfrog/SwampUp2022/tree/main/SUP016-Automate_everything_with_the_JFrog_CLI/ci-example)
    - **[Demo](https://youtu.be/JvEmihsjxjQ)**

## Configure Replication [Optional - Multisite Topology Setup]

### Create Replication Template
- Run
  ```
  jf rt replication-template template-pull.json
  ```

  or

  ``` 
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
  ```
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

### Create Replication Template
Run
```
jf rt replication-create template-pull.json --vars "url=https://lunchnlearn.jfrog.io/artifactory/docker-main/"
```
or
``` 
jf rt rplc template-pull.json --vars "url=https://lunchnlearn.jfrog.io/artifactory/docker-main/"
```

**Blog**
[Replication: Using Artifactory to Manage Binaries Across Multi-Site Topologies](https://jfrog.com/whitepaper/replication-using-artifactory-to-manage-binaries-across-multi-site-topologies/)


## RUN SCRIPT
- Run 
```
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