## Curation lab
### 1. Pre-requisites
* Latest [npm client](https://nodejs.org/en/download/package-manager)
* A local copy of the sample application code
* Identify your personal JFrog Project's "project prefix" with the help of your instructor

### 2. Create Project Repositories

#### 2.1 Remote Repository
* Ensure your project is active in the JFrog Platform UI 
* Navigate to Admin panel > Project Settings > Resources > Create Repository
* Select `Remote Repository` and  pick type ‘npm’
* Type the repo name 'npm-remote-curation' in the Repository Key field and hit Create Remote Repository.  Note 
the name "prefix" is pre-configured and indicates that this repo belongs to your Project.
* Ensure that XRay Indexing is enabled, it should be by default.

#### 2.2 Local Repository
* Ensure your project is active in the JFrog Platform UI
* Navigate to Admin panel > Project Settings > Resources > Create Repository
* Select `Local Repository` and  pick type ‘npm’
* Type the repo name 'npm-remote-curation' in the Repository Key field and hit Create Remote Repository.  Note
  the name "prefix" is pre-configured and indicates that this repo belongs to your Project.
* Ensure that XRay Indexing is enabled, it should be by default.

> Note: Indexing is enabled by default.  Indexing is an important concept in XRay use and will be covered in 
> more detail later in the course
    
> Note:  We're going to skip the "Set Me Up" client guidance for this lab. We will use the JFRog CLI's 
> NPM integration for this workshop.

> @Rakesh & @Gabe: The output is silent on the jf npm wrapper, though, and that sucks.  No one has idea whats happening. I Got past it by exporting the LOG LEVEL env var....do we want to do this?

> As of SwampUp '24, configuring Curation settings like enabling Curation on remote repos and creating Curation policies are functions reserved for Platform Admins. Workshop instructors will handle steps 3 & 4 as a demo.

### 3. Instructors Will Demonstrate Enabling the Curation Service On All Remote Repos
(Screenshot)  
  
### 4. Instructors Will Demonstrate Building a Basic Curation Policy
* Navigate to Application panel > Curation > Policies management
* Click on `Create New Policy` ( if this is the first policy) or `Create Policy` at the top right
* Give the Policy the name `'block malicious pkgs'` and click `Next`
* Select the just created repo by selecting `Specific` and then pick the repo 
'<your-project-prefix>-npm-remote-curation' 
and click `Save` then click `Next`
* Select the first condition in the list called `‘Malicious package’` then click `Next`
* Leave the waivers section blank then click `Next`
* In the Actions section, pick `‘Block’` then click `Next`
* Click on the `Save Policy` button

### 5. Configure JF CLI Settings to Build and Publish NPM Project
The JFrog CLI has an integration with some of the most-used package managers, including NPM.  We're going to use the JFrog CLI NPM Integration in this lab because of it's ease-of-use and creation of Build-Info.  The advantages of this approach will be highlighted in later labs.

5.1. Navigate to Sample App folder: `./sample-app`

5.2. Run `jf npm configure` or it's abbreviated command,  `jf npmc`.

Go through the prompts and provide your server name and repos for dependency resolution and package publishing.  It should look similar to this example:
```bash
> jf npmc
Resolve dependencies from Artifactory? (y/n) [y]? y
Set Artifactory server ID [<your-default-server-id>]:
Set repository for dependencies resolution <your-project-remote-repository>
Deploy project artifacts to Artifactory? (y/n) [y]? y
Set Artifactory server ID [<your-default-server-id>]:
Set repository for artifacts deployment <your-project-local-repository>
16:15:04 [🔵Info] npm build config successfully created.
```
Now that all this setup is done, let's see Curation in Action!  Take a look at The application's dependency declarations in `./sample-app/package.json` on line 21.  We see our application depends on an OSS package, `cors.js`.  The JFrog Catalog service has flagged this as a [known malicious package](https://www.mend.io/blog/a-busy-weekend-for-npm-attacks-including-cors-typosquatting/).  Since we have told our NPM Client to use our Curated repo as the source of it's dependencies, and we have a policy setup to block malicious packages, what do you expect to happen when we try to build our application?  

Let's find out! 

> @Rakesh @Gabe, this is Mend article, but it's the best I could find about this particular package.  Should we leave it, find something else?  Also, should we go into Catalog and show the page for Cors.js?

5.3. Run this command:
```bash
jf npm install --build-name=NpmApp --build-number=1 --project=<your-project-prefix>`
```
What happened?  Can we fix it?

5.4. Check the Catalog service for details on `Cors.js` and implement the recommendation.
> @Rakesh and @Gabe, I had originally considered just chaning the policy to Dry Run, but perhaps it's cooler to actually use the remediation recommendation in Catalog to fix the issue and see it succeed.  WDYT?

5.5  Re-run the build and it should succeed:
```bash
jf npm install --build-name=NpmApp --build-number=1 --project=<your-project-prefix>`
```
5.6  Now add some details and publish the build: 
```bash
jf rt uild-collect-env <build-name> <build-number>
jf rt build-add-git <build-name> <build-number>
jf rt build-publish <build-name> <build-number> --project=<your-project-name>
```
# End