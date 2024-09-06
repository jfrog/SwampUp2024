# JFTD-107 JFrog Platform Essentials - Hands-on Labs

# Lab 1: Artifactory

In this lab, we will configure access to the JFrog platform and define repositories to hold Docker images (Docker registries).

## Step 1: Login to the Lab instance
1. Go to: [https://swampup17242481112.jfrog.io/](https://swampup17242481112.jfrog.io/)
2. Login using:
   - **User**: user<#>
   - **Password**: SwampUP2024!
3. From the Projects dropdown, select your project.

## Step 2: Create a Local and Remote Repository
1. Log into the provided JFrog platform with the username/password you were provided.
2. Select your project from the project dropdown in the top right of the page.
3. Click the **“Administration”** section of the platform to the left of the project dropdown.
4. Under project resources, click on **“+ Create Repository”** under resources on the right side of the page.

### 2a: Create a Local Docker Repository
1. Select Docker from the list of repository types.
2. Fill in the repository key that will be the name of the local repository: `docker-local`.
3. Click the **Create Local Repository** button at the bottom of the page.
4. Click on **“I’ll Do It Later”**.

### 2b: Create a Remote Docker Repository
1. Click **Create a Repository** (Top right) and select **Remote**.
2. Select Docker from the list of repository types.
3. Fill in the repository key that will be the name of the remote repository: `docker-remote` (NOTE: Do not change the URL).
4. Click the **Create Remote Repository** button at the bottom of the page.
5. Click on **“I’ll Do It Later”**.

### 2c: Create a Virtual Repository
1. Click **Create a Repository** (Top right) and select **Virtual**.
2. Select Docker from the list of repository types.
3. Fill in the repository key that will be the name of the local repository: `docker-virtual`.
4. Scroll down to **Available Repositories**:
   - Select both remote/local and click **>>**.
5. Scroll down to **Default Deployment Repository**:
   - Select `puser<user>-docker-local` from the dropdown.
6. Click the **Create Virtual Repository** button at the bottom of the page.
7. Click on **“I’ll Do It Later”**.

## Step 3: Create an Access Token on the JFrog UI
1. Under **Administration**, select **User Management**.
2. Click **Access Tokens** on the right side panel.
3. Click **+ Generate Token** on the top right corner of the page.
   - **Description**: Optional.
   - **Token Roles**: Project Admin.
4. Click **Generate**.
5. Copy the token for use later in the lab.

## Step 4: Login to Virtual Machine for CLI Access: Download SSH Tools/Key
1. Follow this path in the JFrog UI: **Application** (Top navbar) -> **Artifactory** (Left Panel) -> **Artifacts**.
2. Expand `purserX-virtual-machine-tools`.
3. Select and download each file:
   - `Swampup2024-keypair.pem`
   - `Swampup2024-keypair.ppk`
   - `vm_ssh_command.txt`
4. Open a terminal (Requires SSH client):
   - Change the directory to where the files were downloaded in the step above.
   - Review `vm_ssh_command.txt`.
   - Run the SSH command that corresponds to your computer’s architecture.

## Step 5: Configure the JFrog CLI
1. Run command
   ```
   jf config add
   ```
   - **Unique Server identifier**: SwampUp2024.
   - **JFrog Platform URL**: [https://swampup17242481112.jfrog.io](https://swampup17242481112.jfrog.io).
   - Press enter (Save and Continue).
   - Select Username and Password / API Key and press enter.
   - **Username**: Your lab user `userX`.
   - Paste the Access Token generated in Step 3.
   - Press enter (Accept default).
   - ```jf config use SwampUp2024```
   - ```jf c show```
2. Test with ```bashjf rt ping```
   - You should get an **OK** response.

## Step 6: Install Docker Client
1. Run:
```
sudo apt install docker.io
```
3. Run: ```sudo usermod -a -G docker ubuntu```
4. Run: ```newgrp docker```
5. Run: ```docker ps```
   - If you get an error:
     1. Exit the terminal and log in again (Steps 4.d).

## Step 7: Run Docker Login Command Using Set Me Up Functionality in Artifactory
1. Run: ``` docker login swampup17242481112.jfrog.io```
   - **Username**: Your lab user `userX`.
   - **Password**: Token from Step 3.

## Step 8: Download a Docker Image from Docker Hub Using JFrog CLI
1. Example: ```bashdocker pull swampup17242481112.jfrog.io/puser<Your user number>-docker-virtual/infinitengine/swampup:1.0.0```
   - **NOTE**: Change the URL to add your user number (lab user).

# Lab 2: JFrog Xray - Step-by-Step Guide

This lab will guide you through enabling Xray indexing on local and remote repositories, uploading Docker images using Docker native commands, and scanning images using JFrog CLI. By completing these steps, you will gain a deeper understanding of CVEs (Common Vulnerabilities and Exposures), CWEs (Common Weakness Enumeration), secrets, and how JFrog Xray helps identify these issues in Docker images.

## Step 1: Enable Xray Indexing on Local & Remote Repositories

### Objective
Enable Xray indexing to ensure that Docker images are scanned for vulnerabilities and other security issues.

### Instructions

1. **Navigate to Xray Settings:**
   - Log in to your JFrog Platform and go to **Administration**.
   - Under the **Xray** section, select **Xray Settings**.
   - Click on **Indexed Resources** to see the current list of repositories that are being indexed.

2. **Add a Repository for Indexing:**
   - Click **+ Add a Repository**.
   - From the list, select a Docker repository that contains Docker images. It is recommended to select a repository with existing scanned Docker images (preferably from another Docker repository).
   - Click **Save** to enable indexing for the selected repository.

3. **Observation:**
   - Check that the selected repository is now listed under **Indexed Resources**.

### Conclusion
Participants should now understand how to enable Xray indexing on repositories and the importance of indexing for identifying CVEs.

---

## Step 2: Upload a Docker Image Using Docker Native Commands

### Objective
Upload a Docker image to a JFrog repository and observe the security scan results to understand how Xray detects vulnerabilities, CWEs, secrets, and more.

### Instructions

1. **Tag the Docker Image:**
   - Use a Docker image that you pulled in Lab 1. Tag the image as follows:
     ```bash
     docker tag swampup17242481112.jfrog.io/puser<Your user number>-docker-virtual/infinitengine/swampup:1.0.0 swampup17242481112.jfrog.io/puser<Your user number>-docker-virtual/myimage/swampup:1.0.0
     ```
   - Make sure to replace `<Your user number>` with your assigned user number to ensure the tag is correct.

2. **Push the Docker Image to JFrog:**
   - Use the following command to push your tagged Docker image to the JFrog Docker repository:
     ```bash
     docker push swampup17242481112.jfrog.io/puser<Your user number>-docker-virtual/myimage/swampup:1.0.0
     ```

3. **View Scanning Results:**
   - After pushing the image, go to **Application > Xray > Scan Lists**.
   - Click on your Docker repository (**puser<Your user number>-docker-local**).
   - Navigate to **myimage/** and select your uploaded image.

4. **Explore the Scan Results:**
   - Review the scan results, focusing on:
     - **Vulnerabilities**: Identified CVEs in the image.
     - **Exposures**: Security risks related to known vulnerabilities.
     - **Applicable**: Highlights the critical issues that apply specifically to your image.
     - **SBOM (Software Bill of Materials)**: Accessible from the small icons on the left, providing detailed insights into the components of your image.

### Conclusion
Participants will understand how to upload Docker images to JFrog, view scanning results, and interpret findings such as CVEs, CWEs, and exposed secrets.

---

## Step 3: BONUS - Scan the Docker Image Locally Using JFrog CLI (Optional)

### Objective
Learn how to perform an on-demand scan of Docker images locally using JFrog CLI to identify vulnerabilities (CVEs).

### Instructions

1. **Install JFrog CLI:**
   - If you haven't already, download and install JFrog CLI from the [JFrog CLI Documentation](https://jfrog.com/getcli/).

2. **Scan the Docker Image Locally:**
   - Use the Docker image you pushed earlier or another relevant Docker image from Docker Hub.
   - Run the following command to scan the image locally using JFrog CLI:
     ```bash
     jf docker scan swampup:1.0.0
     ```

3. **Review the CLI Output:**
   - Observe the scan results displayed in the CLI, focusing on identified vulnerabilities and their severity.

### Conclusion
Participants will understand how to use the JFrog CLI for on-demand scanning, providing a quick and effective way to assess vulnerabilities in Docker images.

---

## Summary
By completing these steps, participants will gain hands-on experience with JFrog Xray, enhancing their understanding of how to secure Docker images against vulnerabilities and other security threats.

# Lab 3: Distribution

In this lab, you will create a Release Bundle and distribute it to an Edge node using previously uploaded Docker images from a local repository.

## Step 1: Create a Release Bundle

1. Navigate to **Distribution** -> **Release Bundles** -> Click **+ New Release Bundle**.
2. Fill in the following details:
   - **Name**: `<Your UserName>-release-bundle`
   - **Version**: `1.0.7`
3. Click **Create Query** -> **Add Query**.
4. Set the Query name to `<Your user name>-AQL`.
5. Add the local repository from the previous labs using the “Repository Names” drop-down.
   - **Repository Name**: `puser<usernumber>-docker-local`
6. (Optional) Click the **Show AQL** checkbox at the bottom of the page to view the AQL format.
7. Click **Next** and then **Next** again, then save the release bundle.
8. Click the **Create and Sign** button.
9. Click **Sign** to finalize the signing of the release bundle.

## Step 2: Distribute Your Signed Release Bundle

1. Click on the **Versioned Actions** button in the top right corner.
2. Select **Distribute Version**.
3. Choose the edge node to which you want to distribute your release bundle.
4. Click the **Distribute** button to start the distribution process.

### JFrog Setup

- JPD with Edge, Docker, and NPM repositories configured.
- Indexing enabled, with Docker images scanned for Basic and Advanced Security.
- Keep JPDs active for a week after the session (until Sep 20th).
- GitHub account setup.

### Workstation Setup

- Git CLI
- Docker Runtime
- JFrog CLI
- NPM Native Client
- IDE (VSCode, IntelliJ)
- Web Browser (Chrome)
