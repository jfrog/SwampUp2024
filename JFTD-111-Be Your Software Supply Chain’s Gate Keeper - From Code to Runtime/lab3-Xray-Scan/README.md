# Xray Scan Lab
## 0. Pre-requisites:
0.1 Navigate to the root of the npm project located in the sample project folder, `JFTD-111-Be Your Software Supply Chain’s Gate Keeper - From Code to Runtime/sample-app`.

0.2 JFrog CLI installed and configured with a connection to the workshop JFrog Cloud instance.

0.3 Local & Remote NPM repository in your assigned JFrog Projects project.

## 1. Index Your Build
In order for XRay to scan anything, we need to "Index" the resources that XRay will scan.  This step will tell XRay to scan any build that matches a specific name.
> Note: The Build Name we need to use in this step will be whatever build name you used back in Lab 1.

1.1 Turn on indexing of the build. Navigate to `<Your Project Context> -> Administration > Xray Settings > Indexed Resources > Builds > Manage Builds`. Select your build name from Lab 1 in the left column and bring it over to  the  right `Selected Build` column.  Click "Save".


## 2. Build The Project, Publish the Build and Configure for Indexing by XRay
From the root of the Sample Application (`./sample-app`), configure the NPM package manager integration with your instance of the JFrog CLI, if you haven't already done so in Lab 1.

2.1 (Optional: Skip this step if you've already run through setting up the JF CLI to work with the sample app in Lab 1) Run `jf npmc`.  You'll follow prompts similar to the following example:
```
Resolve dependencies from Artifactory? (y/n)? y
Set Artifactory server ID [swampup]: hit Return
Set repository for dependencies resolution (press Tab for options): (use Tab to select the virtual repository `npm-virtual` and hit Return)
Deploy project artifacts to Artifactory? (y/n)? y
Set Artifactory server ID [swampup] hit Return
Set repository for artifacts deployment (press Tab for options): (use Tab to select the virtual repository `npm-virtual` and hit Return)
```

2.2 Npm install and build the sample application.  If you ran a build in Lab 1, using `build-number 1`, let's increment the `build-number` to `2` for the following steps.
```bash
jf npm install --build-name <your-build-name> --build-number 2 --project <your-project-name>
```

2.3 Publish the built NPM package to Artifactory:
```bash
jf npm publish --build-name <your-build-name> --build-number 2 --project <your-project-name>
```

2.4 Collect build environment variables:
```bash
jf rt bce --project <your-project-name> <your-build-name> 2 
```

2.5 Collect build information related to git data:
```bash
jf rt bag --project <your-project-name> <your-build-name> 2
```

2.6 Publish the Build Info to Artifactory's:
```bash
jf rt bp --project <your-project-name> <your-build-name> 2
```

2.7 Verify the published build info on the instance and check the scan details in `Application > Builds > <your-build-name> > 2 > Xray data`

## 3. Create an XRay Security Policy
3.1 Navigate to `Xray > Watches & Policies > Policies Tab > New Policy`.

3.2 Create a Security Policy named `<your-initials>-high-severity-policy`.

3.2 Under `Select Policy Type`, select `Security`.

3.3 The "Create New Policy Rule" pop up should appear. If it doesn't, click on `New Rule`.

3.4 Add a rule named `high-severity-rule`

3.5 Build a rule with the following parameters: 
  * Under `Rule Types` Select `CVEs` under Rule Type, 
  * Under `Rule Category` select `Minimal Severity`.
  * In the Drop-Down for `Minimal Severity`, select `High`
  * When completed, click `Save Rule`.

3.6 Once the rule is saved, click "Save Policy" in the lower right.

## 4. Create an XRay Watch
> It's best to create the watch, and then the policy.  This seems a little counter-intuitive but the UI now has a 
> flow that lets you immediately apply your policy on watched resources and is a nice onboarding features.

A Watch in XRay defines the _scope_ on which you would apply one or more XRay _policies_.  In other words, a Watch tells XRay _where_ to look for policy violations.    You can set Watches on many different objects in Artifactory: Repositories, Release Bundles & Builds. In this lab, we're going to put a watch on any builds that match a specific name. 

4.1 Navigate to `Xray > Watches & Policies > Watches` tab > Click on `New Watch`

4.2 Create a Watch named `<your-intials>-npm-build-watch`

4.3 Click on `Add Builds`

4.4 Select the build name you've been using in this Lab and Lab 1, and move it over to the right `Selected Build` column.

4.5 Click the "Manage Policies" button below and to the right.  Add the policy you created in the previous step, click "Save".

4.6 Click "Create" in the lower right to create your Watch with your Policy.


## 5. Apply Your New Policy On Your Published Build and Review Any Violations
5.1 Once your watch is saved, look for the `...` (3 dots) context menu on the right. Click "Apply on Existing Content".  Give XRay some time to scan your build (~ 5 minutes)

5.2 Review any Policy Violations to see what the security risk of your application looks like.

# 6. (Optional) Remediate a Policy Violation
Based on one of the findings in the XRay Policy let's pick a Vulnerability to remediate.  Many of the findings are related to trasnitive dependencies from the `npm` package.  You are welcome to upgrade the `npm` package, but it's a bit clearer to look at the CVE associated with a direct dependency on the `hoek` package.  Let's follow the remediation advice in the Artifactory UI.

6.1 Navigate to the Scans list by going to `Application > Xray > Scans list > Builds`.

6.2 Find your build scan

6.3 Take a look at the "Policy Violations" tab ont he left side of the Scan UI.

6.4 At the bottom of the list is a reference to `CVE-2018-3728`, associated with the `hoek` package.  Click on that row.

6.5 In the pop-out, there is a section called `Component Details`.  Take a look at the versions of the `hoek` package that resolve this CVE.  

6.6 Go back out to your IDE or text editor and upgrade the `hoek` package to referenced version.

6.7 Re-run the Sample App build and publish steps starting with step 2.2 (you don't need to re-configure the NPM package manager integration), and ensure you increment your build number.

6.8 Once you have run and published your build, XRay will automatically scan this new build.  After a few minutes, take a look at the results and see if `CVE-2018-3728` is still present in your scan results.

6.9 As a suggestion, in the main "Scans" page for your specific build, do you notice anything interesting in the "Build Trends" visualization?

# Quick Start To Quickly Advance to the Required End State of this Lab
1. Index the build that was published to Artifactory in Lab 1.
2. If an NPM config for the JFrog CLI isn't present in the root of the sample app, run `jf npmc` and connect to the project local and remotes
3. `jf npm install --build-name <your-build-name> --build-number 2 --project <your-project-name>`
4. `jf npm publish --build-name <your-build-name> --build-number 2 --project <your-project-name>`
5. `jf rt bce --project <your-project-name> <your-build-name> 2`
6. `jf rt bag --project <your-project-name> <your-build-name> 2`
7. `jf rt bp --project <your-project-name> <your-build-name> 2`
8. `Xray > Watches & Policies > Policies Tab > New Policy`
9. Create a Security Policy named `<your-initials>-high-severity-policy`
10. `Select Policy Type`, select `Security`
11. Add a rule named `high-severity-rule`
12. Under `Rule Types` Select `CVEs` under Rule Type,
13. Under `Rule Category` select `Minimal Severity`.
14. In the Drop-Down for `Minimal Severity`, select `High`
15. When completed, click `Save Rule`.
16. `Xray > Watches & Policies > Watches` tab > Click on `New Watch`
17. `<your-intials>-npm-build-watch`
18. `Add Builds`, Select appropriate build name.
19. `Manage Policies` -> Add your policy and 'Create'
20. `Apply on Existing Content`
