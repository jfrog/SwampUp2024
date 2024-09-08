## Curation lab
### 1. Pre-requisites
* Latest [npm client](https://nodejs.org/en/download/package-manager)
* A local copy of the sample application code.  Do this by running the following command:
```bash
git clone https://github.com/jfrog/SwampUp2024
cd SwampUp2024
```
* Identify your personal JFrog Project's "project prefix" with the help of your instructor

### 2. Create Project Repositories

#### 2.1 Remote Repository
* Ensure your project is active in the JFrog Platform UI 
* Select `Administration > Project Settings > Repositories > Create Repository`
* Select `Remote Repository` and  pick type `npm`
* Type the repo name `npm-remote-curation` in the Repository Key field. Note
  the Project "prefix" is pre-configured and indicates that this repo belongs to your Project.
* Scroll to the bottom of the view to ensure that XRay Indexing is enabled, it should be by default.
* Click Create Remote Repository.
> Note:  We're going to skip the "Set Me Up" client guidance for this lab. We will use the JFRog CLI's
> NPM integration for this workshop.

#### 2.2 Local Repository
* Ensure your project is active in the JFrog Platform UI
* Select `Administration > Project Settings > Resources > Create Repository`
* Select `Local Repository` and  pick type `npm`
* Type the repo name `npm-local` in the Repository Key field and hit Create Remote Repository.  Note
  the name "prefix" is pre-configured and indicates that this repo belongs to your Project.
* Ensure that XRay Indexing is enabled, it should be by default.
> Note:  We're going to skip the "Set Me Up" client guidance for this lab. We will use the JFRog CLI's
> NPM integration for this workshop.

> Note: Indexing is enabled by default.  Indexing is an important concept in XRay use and will be covered in 
> more detail later in the course
    

### 3. Instructors Will Demonstrate Enabling the Curation Service On All Students' Remote Repos
> As of SwampUp '24, configuring Curation settings like enabling Curation on remote repos is a function reserved for Platform Admins. Workshop instructors will handle steps enabling Curation on each remote repo.

### 4. Build a Basic Curation Policy
> In order for this to work, each Student _must_ have "Manage Policies" Role added to their User account by a platform Admin

4.1. Navigate to `Application > Curation > Policies`

4.2. Click on `Create New Policy` ( if this is the first policy) or `Create Policy` at the top right 

4.3. Give the Policy a name similar to `<your intials> block malicious pkgs` and click `Next`
> The Policy names must be globally unique, we recommend prefixing the policy name with your initials.

4.4. Select the just created repo by selecting `Specific` and then pick the repo '<your-project-prefix>-npm-remote-curation' 
and click `Save` then click `Next`

4.5. Select the first condition in the list called `‘Malicious package’` then click `Next`

4.6. Leave the waivers section blank then click `Next`

4.7. In the Actions section, pick `‘Block’` then click `Next`

4.8. Click on the `Save Policy` button

### 5. Configure JF CLI Settings to Build and Publish NPM Project
The JFrog CLI has an integration with some of the most popular package managers, including NPM.  We're going to use the JFrog CLI NPM Integration in this lab because of it's ease-of-use and creation of Build Info that we'll use in a later lab.  The advantages of this approach will be highlighted in later labs.

5.1. Navigate to Sample App folder: `./sample-app`.  The full path from the root of the SwampUp directory would be:
```bash
cd /Users/tomj/IdeaProjects/SwampUp2024/JFTD-111-Be Your Software Supply Chain’s Gate Keeper - From Code to Runtime/sample-app

```
5.2. Run `jf npm-config` or it's abbreviated command,  `jf npmc`.

Go through the prompts and provide your server name and repos for dependency resolution and package publishing.  It should look similar to this example:
```bash
> jf npmc
Resolve dependencies from Artifactory? (y/n) [y]? y
Set Artifactory server ID [<your-default-server-id>]:
Set repository for dependencies resolution <your-project-remote-repository>
Deploy project artifacts to Artifactory? (y/n) [y]? y
Set Artifactory server ID [<your-default-server-id>]:
Set repository for artifacts deployment <your-project-local-repository>
[🔵Info] npm build config successfully created.
```
Now that all this setup is done, let's see Curation in Action!  Take a look at The application's dependency declarations in `./sample-app/package.json` on line 26.  We see our application depends on an OSS package, `cors.js`.  The JFrog Catalog service has flagged this as a [known malicious package](https://www.mend.io/blog/a-busy-weekend-for-npm-attacks-including-cors-typosquatting/).  Since we have told our NPM Client to use our Curated repo as the source of its dependencies, and we have a policy setup to block malicious packages, what do you expect to happen when we try to build our application?  

Let's find out! 


> Note: If you'd like to see some verbose output in the next example, set the JFRog CLI log level to DEBUG.  This can be done by exporting an Environment variable like the following 
> ```bash
> export JFROG_CLI_LOG_LEVEL=DEBUG
> ```

5.3. Run this command.  **Pay particular attention to the `--build-name` parameter we use in this step.  We will need this value when we look at XRay in Lab 3.**
```bash
jf npm install --build-name=<your-initials>-npm-app --build-number=1 --project=<your-project-prefix>
```
What happened?  Can we fix it?

> Note: If the build actually succeeds, there are a few things to do in order to "reset" the lab:
> 1. Clear the local npm cache `npm cache clean --force`
> 2. Remove package-lock.json & the node_modules dir: `rm -rf node_modules package-lock.json`
> 3. Delete the Remote Cache Repo content in Artifactory.  Documentation about this step can be found at https://jfrog.com/help/r/jfrog-artifactory-documentation/manipulating-artifacts
> 4. "Zap Cache" of the Remote Cache Repo in Artifactory.  Documentation about this step can be found at https://jfrog.com/help/r/jfrog-artifactory-documentation/zapping-caches

5.4. Check the Catalog service for details on `Cors.js` and implement the recommendation.  Log in to the Artifactory instance, and go to "Catalog" in the left-hand Navigation pane.  

5.5  Re-run the build and it should succeed:
```bash
jf npm install --build-name=<your-initials>-npm-app --build-number=1 --project=<your-project-prefix>
```
5.6  Now add some details and publish the build.  If you follow the example in previous steps, your build number will be `1`
```bash
jf rt build-collect-env <your-initials>-npm-app <build-number>
jf rt build-add-git <your-initials>-npm-app <build-number>
jf rt build-publish <your-initials>-npm-app <build-number> --project=<your-project-prefix>
```
# End
# Quick Start To Quickly Advance to the Required End State
If you're joining late, or run out of time, please execute the following steps quickly or get an instructor to assist fast-tracking you to the end-state of this lab.
In the Project context:
1. Create an NPM remote called `npm-remote-curation`
2. Create an NPM local called `npm-local`
3. Create a Malicious Package Curation Policy and apply it to the Project's NPM Remote
4. Change the entry in `./sample-app/package.json` on line 26 from `"cors.js": "^0.0.1-security"` to `"cors": "2.8.5"`.
5. Run the following commands to build the NPM project and publish the build to Artifactory:
```bash
jf npmc <follow the prompts to configure your project to build and publish to your project
jf npm install --project=<your-project-prefix> --build-name=<your-initials>-npm-app --build-number=1 
jf rt build-collect-env <your-initials>-npm-app 1
jf rt build-add-git <your-initials>-npm-app 1
jf rt build-publish --project=<your-project-prefix> <your-initials>-npm-app 1 
```