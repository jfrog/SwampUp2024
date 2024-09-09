# JFrog Advanced Security Scan
## 0. Pre Reqs
0.1. Docker installed on local machine

0.2. Docker Local, Remote and Virtual


0.3. Note the name of your virtual Docker repo

## 1. Create Docker Local, Remote and Virtual Repos
In your Project context, create new repositories for Docker.

1.1. In your project context, go to `Administration -> Resources -> Create Repository`, click Local Repository.  Name the new repo `<project-prefix>-docker-local` and keep the defaults

1.2. In your project context, go to `Administration -> Resources -> Create Repository`, click Remote Repository.  Name the new repo `<project-prefix>-docker-remote` and keep the defaults

1.3. In your project context, go to `Administration -> Resources -> Create Repository`, click Virtual Repository.  Name the new repo `<project-prefix>-docker-virtual`.  Add the two previously-created repos as members of the Virtual repository.  Add `<project-prefix>-docker-local` as the "Deafult Deployment Repository".  Leave all other values at default.

## 2. Build Docker Image from Sample App
Let's build a Docker image that we can scan with JFrog Advanced Security

2.0. Login to your Artifactory-based Docker registry.  You'll be prompted for your password after executing the command.  Note there is no space after the `-u` parameter.  For example, if you are `user0`, the parameter should look like `-uuser0`
```bash
docker login -u<your-user-name> swampup17242481114.jfrog.io 
```

2.1. Navigate to sample app directory, `./sample-app`.

2.2. Open the Dockerfile and update the `FROM` directive with your Docker registry and virtual repo.
For example: `FROM swampup17242481114.jfrog.io/<project-prefix>-docker-virtual/node:lts-buster`

2.3 Build the Docker image:
```bash
docker build -t swampup17242481114.jfrog.io/<project-prefix>-docker-virtual/sample-app:1 .
```
2.4 Verify the image was created successfully


2.5 Publish the image
```bash
docker push swampup17242481114.jfrog.io/<project-prefix>-docker-virtual/sample-app:1
```

## 3. Review the Scan Results in the XRay > Scans > Repositories
> Look at the ENORMOUS amount of vulnerabilities that you would never see with Code-level scanning alone.
> This image is full of holes, some of the very high vulnerability scores, and they are applicable!

JFrog Advanced Security has powerful security capabilities to scan for Contextualized Applicability of detected CVEs, but it can do much more. When a Docker image with application frameworks like Django (Python) or Express (Javascript) are detected by Advanced Security, we can make recommendations on whether there are security vulnerabilities exposed by the configuration of the service or framework.  In this case, our Sample Application uses the Express framework and has some recommendations to harden the container.  

JFrog Advanced Security can also detect Secrets that might be found in any layer of the image, and we happen to have one seeded in the Docker image that you just published.  Let's take a look at both of those examples.

3.1.  In the JFrog UI head to `XRay -> Scans -> Repositories` and locate the local Docker repository into which we just published the Docker image.  The scan may still be running, so please be patient to let the scan finish.  The Advanced Security Engine is going layer by layer through the image and examining all the artifacts in each layer for potential security vulnerabilities.  It can take a few minutes for all the different scans to complete 

3.2.  Explore the JAS UI.  What stands out?  What surprises you?  Is there anything here you expect to see?

3.3. Check the `Secrets` section of the Scan UI.  Did you notice the Secret that was found?  

3.4. Check the `Applications` section of the Scan UI.  Does anything stand out here?

## 4. Remediate as many vulnerabilities as possible
4.1 After spending some time reviewing the vulnerabilities discovered with the JFrog Advanced Security scans, feel free to experiment with either the Javascript application or the Dockerfile to remediate the scan findings.  What would you prioritize?  How come?


