# Xray Scan Lab
## 0. Pre-requisites:
0.1 Navigate to the root of the npm project located in the sample project folder, `./sample-app`.

0.2 JFrog CLI installed and configured with a connection to the workshop JFrog Cloud instance.

0.3 Local, Remote and Virtual NPM repository in your assigned JFrog Projects project.

## 1. Index Your Build
In order for XRay to scan anything, we need to "Index" the resources that XRay will scan.  This step will tell XRay to scan any build that matches a specific name.
> Note: The Build Name we need to use in this step will be whatever build name you used back in Lab 1.

1.1 Turn on indexing of the build. Navigate to `<Your Project Context> -> Administration > Xray Settings > Indexed Resources > Builds > Manage Builds`. Select your build name from Lab 1 in the left column and bring it over to  the  right `Selected Build` column.  Click "Save".


## 1. Build The Project, Publish the Build and Configure for Indexing by XRay
From the root of the Sample Application (`./sample-app`), configure the NPM package manager integration with your instance of the JFrog CLI, if you haven't already done so in Lab 1.

1.1 (Optional: Skip this step if you've already run through setting up the JF CLI to work with the sample all in Lab 1) Run `jf npmc`.  You'll follow prompts similar to the following example:
```
Resolve dependencies from Artifactory? (y/n)? y
Set Artifactory server ID [swampup]: hit Return
Set repository for dependencies resolution (press Tab for options): (use Tab to select the virtual repository `npm-virtual` and hit Return)
Deploy project artifacts to Artifactory? (y/n)? y
Set Artifactory server ID [swampup] hit Return
Set repository for artifacts deployment (press Tab for options): (use Tab to select the virtual repository `npm-virtual` and hit Return)
```

1.8 Npm install and build the sample application.  If you ran a build in Lab 1, using `build-number 1`, let's increment the `build-number` to `2` for the following steps.
```bash
jf npm install --build-name <your-build-name> --build-number 2 --project <your-project-name>
```

1.9 Publish the built NPM package to Artifactory:
```bash
jf npm publish --build-name <your-build-name> --build-number 2 --project <your-project-name>
```

1.10 Collect build environment variables:
```bash
jf rt bce --project <your-project-name> <your-build-name> 2 
```

1.11 Collect build information related to git data:
```bash
jf rt bag --project <your-project-name> <your-build-name> 2
```

1.12 Publish the Build Info to Artifactory's:
```bash
jf rt bp --project <your-project-name> <your-build-name> 2
```

1.13 Verify the published build info on the instance and check the scan details in Builds > <your-build-name> > 02 > Xray data

## Create an XRay Security Policy
4.1 Navigate to Xray > Watches & Policies > Click on `New Policy`

4.2 Create a Security Policy named `high-severity-policy`

4.3 The "New Rule" pop up should appear. If it doesn't, click on `New Rule`.

4.4 Add a rule named `high-severity-rule`.

4.5 Build a rule with the following parameters: 
  * Under "Rule Types" Select "CVEs" under Rule Type, 
  * Under "Rule Category" select "Minimal Severity"
  * In the Drop-Down for "Minimal Severity", select "High"
  * Check both boxes for "Except if a fix version is not available" & "Skip Not Applicable CVEs".

4.6 In the section titled "Then",  `Automatic Actions` select the `Fail Build` option and click `Save` (Is this needed?, probab ly not)

4.7 Once the rule is saved, click "Save Policy" in the lower right.

## Create an XRay Watch
> It's best to create the watch, and then the policy.  This seems a little counter-intuitive but the UI now has a 
> flow that lets you immediately apply your policy on watched resources and is a nice onboarding features.

A Watch in XRay defines the _scope_ on which you would apply one or more XRay _policies_.  In other words, a Watch tells XRay _where_ to look for policiy violations.    You can set Watches on many different objects in Artifactory: Repositories, Release Bundles & Builds. In this lab, we're going to put a watch on any builds that match a specific name. 
3.1 Navigate to Xray > Watches & Policies > `Watches` tab > Click on `New Watch`

3.2 Create a Watch named `npm-build-watch`

3.3 Click on `Add Builds`

3.4 Select the build name you've been using in this Lab and Lab 1, and move it over to the right `Selected Build` column. Click Save.

## 5. Apply Your New Policy On Your Published Build and Review Any Violations
5.1 Click "Apply on Existing Content".  Give XRay some time to scan your build (~ 5 minutes)

5.2 Review any Policy Violations to see what the security risk of your application looks like.
>  TODO: This needs to be fleshed out more

# 6. (Optional) Remediate a Policy Violation
Based on one of the findings in the XRay Policy let's pick a Vulnerability to remediate.  Many of the findings are related to trasnitive dependencies from the `npm` package.  You are welcome to upgrade the `npm` package, but it's a bit clearer to look at the CVE associated with a direct dependency on the `hoek` package.  Let's follow the remediation advice in the Artifactory UI.

6.1 Navigate to the Scans list.

6.2 Find your build scan

6.3 Take a look at the "Policy Violations" tab ont he left side of the Scan UI

6.4 At the bottom of the list is a reference to `CVE-2018-3728`, associated with the `hoek` package.  Click on that row

6.5 In the pop-out, there is a section called `Component Details`.  Take a look at the versions of the `hoek` package that resolve this CVE.  

6.6 Go back out to your IDE or text editor and upgrade the `hoek` package to referenced version

6.7 Re-run the build and publish steps starting with step 1.2 (you don't need to re-configure the NPM package manager integration), and ensure you increment your build number.

6.8 Once you have run and published your build, XRay will automatically scan this new build.  After a few minutes, take a look at the results and see if `CVE-2018-3728` is still present in your scan results.

## 5. (Optional) Scan the build locally with XRay after it's been published to Artifactory
5.1 Scan the build info on your local machine with XRay:
```bash
jf bs <your-build-name> 2 --extended-table=true --vuln
```

> This next bit was in the previous repo. It's interesting, but I don't think it's necessary.
- You can capture the output of the jf command, including any error messages or codes it produces, and then 
    process that output in a script. 
    - Here's how you might do it using Bash scripting as an example:
      <br/> Note: The 2>&1 syntax redirects the standard error stream to the standard output stream so that both 
      streams are captured in the output variable.
```text
output=$(jf bs npm_build 02 --extended-table=true --fail=true 2>&1)
error_code=$?

echo "Command output:"
echo "$output"
echo "Error code: $error_code"
```
<br/>
<img src="capture_jf_output_and_error_code_1.png" alt="jf output ,error code, error message" width="600" height="300">
<img src="capture_jf_output_and_error_code_2.png" alt="jf output ,error code, error message" width="600" height="300">