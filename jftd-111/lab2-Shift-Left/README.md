# Lab 2: Shift-Left with DevSecOps Capabilities at Developers' Fingertips 
## Pre-requisites
### 1. IDE Plugin Installation
Instructions for the two most popular IDEs, VSCode and IntelliJ, or any other JetBrains IDE, are included below.  If 
your preferred IDE isn't either of these two, we recommend installing VSCode to get up and running quickly.
#### 1.1. VSCode Plugin
* VS Code IDE, or your preferred IDE,  with the JFRog Plug-in installed
* Install The Jfrog extension in VS Code  as mentioned in [JFrog - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=JFrog.jfrog-vscode-extension)
* Open npm-vulnerable-example project in the folder example on VS Code
* Navigate to Extension tab and look up `JFrog` > Click `Install`
* Configure Jfrog extension of VS Code - provide the instance url and credentials

#### 1.2. IntelliJ Plugin
* Navigate to Settings > Plugins > Marketplace and enter `JFrog`.
* Click the "INSTALL" button.  Once it's done installing, click "Apply".  You may be asked to restart IntelliJ.  Go 
  ahead and do that.
* Once the Plugin is installed and available, Navigate to Settings > Other Settings > JFrog Global Configuration
* Add in your Username and Password to the Workshop instance of JFrog Cloud

#### 1.3. Open a new Editor instance
Open a new project window or instance specifically on the `./sample-app` directory.  This is intended to help clearly show this course's sample app's results instead of the other courses' projects.  The results are much easier to review in the context of this course.

## 2. Scan the Sample Project with the IDE Plugin
2.1. Once all set, navigate to the JFrog extension and run a scan with the JFrog plugin.

2.2. Check and validate the results

2.2.3. Open `./sample-app/package.json` in your editor.  What do you note?  Hover over some of the underlined 
dependencies. What information is available? What information do you find useful?  Why or why not?

2.2.4. Open the JFrog Plugin "tab", expand the `package.json` item.  Navigate to the `lodash:3.10.1` dependency and 
click.  What do you note?  Is the CVE-2019-10744 applicable to your application code?  What about CVE-2021-23337? 
As a developer, what value does this information provide? 

## 3. Remediate an Applicable CVE right in your IDE
One of the most powerful features of JFrog Advanced Security capabilities, available right in your IDE with the JFrog 
Plugin, is being able to mitigate security risk early in the development cycle.  The Contextual Analysis 
(Applicability) offered by Jfrog Advanced Security can direct a developer precisely where and how to patch security 
vulnerabilities.  Let's take it for a test drive!

3.1. Select the CVE associated with the `lodash:3.10.1` package that was determined to be applicable.

3.2. Can you spot the Applicability evidence for this applicable CVE?  Where should we look to remediate?  How 
should we remediate?

3.3. Go ahead and implement the fix by uncommenting line 26 in `./sample-app/index.js` on line 9 and _save the file_ if you're running VSCode.  IntelliJ users don't need to save the file for the changes to persist.

3.4. Re-run the JFrog Plugin scan.  Is your issue still applicable?


## 3. CLI Dependency Scan
### Pre-requisites
* JFrog CLI installed and configured to connect to workshop instance as per Lab 0.

3.1. In your terminal navigate to the root of the sample project, `./sample-project`.

3.2. Run the command 
```bash
jf audit
```
3.3. Optional : Run the following command to do a security audit of the project's dependencies with results that are limited to dependencies that have fixes.  
```bash
jf audit --extended-table=true --fixable-only=true --licenses=true
```
(Screenshot)
3.4. Validate the scan results
(Screenshot)


## Frogbot scan - optional if we have time
- Fork this project on github - https://github.com/omerzi/frogbot_demo_pypi
- Examine the 2 files in the path - .github/workflows
- frogbot-pr-scan.yml file is for scanning Pull Requests for any vulnerabilities
- frogbot-scan-and-fix.yml is for scanning the git repository for any vulnerabilities
- Let’s do some initial configuration:
  - Navigate to Settings > Environment and create a new environment called frogbot
  - Navigate to Settings > Secrets and Variables > Actions and create the following 2 secrets:
    - `JF_URL` - provide your instance url
    - `JF_ACCESS_TOKEN` - provide an access token from your instance
  - Navigate to `Settings > Actions > General` and scroll to the bottom of the page
    - Make sure the checkbox `Allow github to create and approve pull requests` is selected

<br/>

- Let’s create a PR with a change in dependency:
  - Navigate to Code and open `requirements.txt` file in the project root
  - Click Edit on top right and change the version of the dependency PyYaml to 5.2
  - Click commit changes and select the 2nd option in the list ‘Create a new branch for this commit and start a pull request’
  - Provide an appropriate branch name like `vuln-branch` and click on Propose changes
  - Then click on `Create Pull request`
  - Wait a few seconds for some tasks/checks to be triggered until you get the message - `“Frogbot Scan Pull Request / scan-pull-request (pull_request_target) Waiting”`
  - Click on `Details` next to the message
  - Then click on `Review pending deployments`
  - Select the checkbox next to `frogbot` and click on Approve and deploy
  - The action workflow is triggered. Wait until the workflow is done
  - Once the workflow is completed, navigate to Pull requests and select the PR that was just created
  - Find and examine the scan result highlighting the vulnerability impacting PyYaml v5.2 



