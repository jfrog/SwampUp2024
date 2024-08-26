# JFrog Advanced Security Scan
## 0. Pre Reqs
0.1. Docker installed on local machine
0.2. Docker Local, Remote and Virtual
0.3. Note the name of your virtual Docker repo

## 1. Build Docker Image from Sample App
Let's build a Docker image that we can scan with JAS
1.1. Navigate to sample app directory, `./sample-app`.
1.2. Open the Dockerfile and update the `FROM` directive with your Docker registry and virtual repo.
For example: `FROM <myinstance>.jfrog.io/docker-virtual/node:lts-buster`
1.3 Build the Docker image:
```bash
docker build -t myinstance.jfrog.io/docker-virtual/sample-app:1 .
```
1.4 Verify the image was created successfully
1.5 Publish the image

## 2. Review the Scan Results in the XRay > Scans > Repositories
> Look at the ENORMOUS amount of vulnerabilities that you would never see with Code-level scanning alone.
> This image is full of holes, some of the very high vulnerability scores, and they are applicable!
2.1.  Explore the JAS UI.  What stands out?  What surprises you?  Is there anything here you expect to see?

## 3. Upload some more images and IaC specs to further exercise JAS capabilities
3.1. _Run the original `guided trial` content?_

