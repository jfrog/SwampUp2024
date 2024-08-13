# Xray Scan Lab
## Pre-requisites:
  - Navigate to the root of the npm project located in the sample project folder, `./sample-app`.
  - JFrog CLI installed and configured with a connection to the workshop JFrog Cloud instance.
  - Local NPM repository in your assigned JFrog Projects project.

## Index Your Build 
> I am not sure where to configure Build Indexing.  I feel like it should go here, but then we have to go back and 
> do another build in order for this to be indexed.  We can set a Wildcard placeholder for the Build in Lab0, or 
> Lab1, but it's the wrong context.  Idk what feels more organic.  Kinda leaning toward indexing 
- Turn on indexing of the build
- Administration > Xray Settings > Indexed Resources > Builds > Manage Builds > Select your build in the left column 
  and bring it over to  the  right `Selected Build` column.  Click "Save".

> It's best to create the watch, and then the policy.  This seems a little counter-intuitive but the UI now has a 
> flow that lets you immediately apply your policy on watched resources and is a nice onboarding features.
- Navigate to Xray > Watches & Policies > `Watches` tab > Click on `New Watch`
- Create a Watch named `npm-build-watch`
- Click on `Add Builds`
- Select the `npm_build` and move it over to the right `Selected Build` column
- Click Save
- Click `Manage Policies`
- In `Manage Watch Policies` Select the `security-policy` you created and move it to the right `Selected Policies` column and click Save
- Click on `Create` to create the watch.



- Navigate to Xray > Watches & Policies > Click on `New Policy`
- Create a Security Policy named `high-severity-policy`
- The "New Rule" pop up should appear. If it doesn't, click on `New Rule`.
- Add a rule named `high-severity-rule`.
- Select "Malicious Packages" under Rule Type.
- In the section titled "Then",  `Automatic Actions` select the `Fail Build` option and click `Save`
- Once the rule is saved, click "Save Policy" in the lower right.
> Does it make sense to have a Fail Build action here?  Not saying it doesn't, just considering whether or not we 
> should do this here?

    
  - From the root of the project
    - Npm package manager integration
      - Run `jf npmc`
      - Resolve dependencies from Artifactory? (y/n)? y
      - Set Artifactory server ID [swampup]: hit Return
      - Set repository for dependencies resolution (press Tab for options): use Tab to select the virtual repository 
        `npm-virtual` and hit Return
      - Deploy project artifacts to Artifactory? (y/n)? y
      - Set Artifactory server ID [swampup] hit Return
      - Set repository for artifacts deployment (press Tab for options): use Tab to select the virtual repository 
        `npm-virtual` and hit Return
    - Npm install and build
      - `jf npm install --build-name npm_build --build-number 02`
    - Publish the built npm pkg to Artifactory
      - `jf npm publish --build-name npm_build --build-number 02`
    - Collect environment variables
      - `jf rt bce npm_build 02`
    - Collect information regarding git
      - `jf rt bag npm_build 02`
        <br/>
        <img src="jf_npm_publish_to_rt.png" alt="jf npm publish to RT" width="600" height="300">   
    - Publish build info
      - `jf rt bp npm_build 02`
        <br/>
        <img src="jf_rt_bp.png" alt="jf rt build-publish" width="600" height="100">
    - Verify the published build info on the instance and check the scan details in Builds > npm_build > 02 > Xray data
    - Scan the build info on your local by Xray - optional
      - `jf bs npm_build 02 --extended-table=true --vuln`
    - Run jf audit - optional
      - `jf audit --extended-table=true --fixable-only=true --licenses=true`
        <br/>
        <img src="jf_audit1.png" alt="jf audit" width="600" height="100">
        <img src="jf_audit2.png" alt="jf audit" width="600" height="300">
        <img src="jf_audit3.png" alt="jf audit" width="600" height="300">
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