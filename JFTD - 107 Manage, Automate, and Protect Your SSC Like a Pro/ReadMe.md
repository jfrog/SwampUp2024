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
