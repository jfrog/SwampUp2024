# Lab 2: Shift-Left with DevSecOps Capabilities at Developers' Fingertips 
## Pre-requisites
### 1. IDE Plugin Installation
Instructions for the two most popular IDEs, VSCode and IntelliJ, or any other JetBrains IDE, are included below.  If 
your preferred IDE isn't either of these two, we recommend installing VSCode to get up and running quickly.

#### 1.1. VSCode Plugin
1.1.1. Install The Jfrog extension in VS Code  as mentioned in [JFrog - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=JFrog.jfrog-vscode-extension)

1.1.2. Navigate to Extension tab and look up `JFrog` > Click `Install`

1.1.3. Configure Jfrog extension of VS Code - the URL for the Course JFrog Platform instance will be provided, along with your username and password

#### 1.2. IntelliJ Plugin
1.2.1. Navigate to Settings > Plugins > Marketplace and enter `JFrog`.

1.2.2. Click the "INSTALL" button.  Once it's done installing, click "Apply".  You may be asked to restart IntelliJ.  Go 
  ahead and do that.

1.2.3. Once the Plugin is installed and available, Navigate to Settings > Other Settings > JFrog Global Configuration

1.2.4. Add in your Username and Password to the Workshop instance of JFrog Cloud

#### 1.3. Open a new Editor instance
1.3.1. Open a new project window or instance specifically on the sample app directory.  The full path from the repository root is `JFTD-111-Be Your Software Supply Chain’s Gate Keeper - From Code to Runtime/sample-app` This is intended to help clearly show this course's sample app's results instead of the other courses' projects.  In other words should should have a clean IDE project window with _just_ the sample app's file and folders.

## 2. Scan the Sample Project with the IDE Plugin
2.0  In order to get the full experience of the JFrog IDE Plugin, the project needs to have its dependencies resolved and present in the `./sampe-app/node_modules` folder.  If you haven't already built this project in Lab 1, please do so now with the following command:
```bash
jf npm install
```

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

3.1. With the JFrog Plugin selected in either VSCode or IntelliJ, expand the scan results for `package.json`, and then expand the results for the dependency `lodash:3.10.1`.  Select the CVE associated with the `lodash:3.10.1` package that was determined to be applicable.

3.2. Can you spot the Applicability evidence for `CVE-2019-10744`?  Where should we look to remediate?  How 
should we remediate?

3.3. Go ahead and implement the fix by uncommenting line 9 in `./sample-app/index.js` and _save the file_ if you're running VSCode.  IntelliJ users don't need to save the file for the changes to persist.

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
- Fork this project on Github - https://github.com/omerzi/frogbot_demo_pypi
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

# Quick Start To Quickly Advance to the Required End State
1. Install the JFrog CLI in your IDE
2. Uncomment out (remove the `//` characters at the line start) line 9 of `./sample-app/index.js`.
3. Save the file if you're running VSCode or a different editor, IntelliJ or other Jetbrains IDEs will automatically save.

