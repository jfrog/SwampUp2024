# Lab 2: JFrog Xray - Step-by-Step Guide

This lab will guide you through enabling Xray indexing on local and remote repositories, uploading Docker images using Docker native commands, and scanning images using JFrog CLI. The goal is to help you understand CVEs (Common Vulnerabilities and Exposures), CWEs (Common Weakness Enumeration), and other security elements related to Docker images.

## Step 1: Enable Xray Indexing on Local & Remote Repositories

### Objective
Enable Xray indexing on repositories to ensure Docker images are scanned for vulnerabilities.

### Instructions
1. **Navigate to Xray Settings:**
   - Log in to your JFrog Platform and go to **Administration**.
   - Under the **Xray** section, click on **Xray Settings**.
   - Select **Indexed Resources** to view the current list of indexed repositories.

2. **Add a Repository for Indexing:**
   - Click on **+ Add a Repository**.
   - Select a Docker repository that contains Docker images. Docker repositories with pre-existing scanned Docker images are preferred for this exercise.
   - Click **Save** to enable indexing for the selected repository.

3. **Observation:**
   - Verify that the repository has been successfully added to the indexed resources list.

### Conclusion
Participants should now understand how to enable Xray indexing and the importance of indexing for CVE detection.

## Step 2: Upload a Docker Image Using Docker Native Commands

### Objective
Upload a Docker image to a JFrog repository to observe the scanning results.

### Instructions
1. **Prepare Your Docker Image:**
   - Use a Docker image from Lab 1 that contains first-party code (your code).
   - Make sure the image is tagged appropriately.

2. **Push the Docker Image to JFrog:**
   - Use the following command to push your Docker image to the JFrog Docker repository:
     ```bash
     docker push swampup17242481112.jfrog.io/docker-virtual/infinitengine/swampup:1.0.0
     ```
   - Replace the repository URL and image tag if necessary based on your JFrog setup.

3. **View Scanning Results:**
   - After pushing the image, navigate to **Scans List** in the JFrog UI to view the security scan results of your Docker repository.

### Observation
Check the vulnerabilities, CWEs, and any detected secrets in the scanned Docker image.

### Conclusion
Participants should now understand how to upload a Docker image and interpret scanning results, including CVEs, CWEs, and secrets.

## Step 3: BONUS - Scan the Docker Image Locally Using JFrog CLI

### Objective
Learn how to perform on-demand scanning of Docker images locally using JFrog CLI.

### Instructions
1. **Install JFrog CLI:**
   - If not already installed, download and install JFrog CLI from [JFrog CLI Documentation](https://jfrog.com/getcli/).

2. **Scan the Docker Image Locally:**
   - Use the Docker image you pushed earlier or download the image directly from Docker Hub.
   - Run the following command to scan the image using JFrog CLI:
     ```bash
     jf docker scan swampup:1.0.0
     ```
   - Replace `swampup:1.0.0` with your specific image tag if different.

3. **View the CLI Output:**
   - Review the scan results displayed in the CLI, focusing on detected CVEs and their severity.

### Observation
Participants will see a detailed list of vulnerabilities detected in the Docker image.

### Conclusion
Participants will understand how to use the JFrog CLI for on-demand scanning and how it provides an immediate view of vulnerabilities.

## Summary
By following these guided steps, participants will gain hands-on experience in enabling Xray indexing, uploading and scanning Docker images, and using JFrog CLI to manage and understand security vulnerabilities effectively.

