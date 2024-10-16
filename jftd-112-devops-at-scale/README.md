# JFTD112 - DevOps at Scale: Multisites: How to Design an Enterprise Ready Architecture

### Agenda
- Lab 0 - Configure JFrog CLI
- LAB 1 - Federation and Topologies
- LAB 2 - Release Lifecycle Management and Distribution Patterns


<br/>

## Prerequisites

- Generate a Github personnal [access token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token). <br/>
    - **NOTE**: if you already have GitHub access token then skip this step else create GitHub account first and then follow above steps.
- Confirm `git` [client](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup) has been configured with your user
    - verify with ``git config --list``
- Fork [jfrog/SwampUp2024](https://github.com/jfrog/SwampUp2024) github repository.
    - Reference document to [fork repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository).
- `git clone` the forked repo on your workstation
    - Reference document to [clone repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo#cloning-your-forked-repository).
- Preferred IDE (Integrated Development Environment) like [Intellij](https://www.jetbrains.com/idea/download/?section=mac#section=mac), [VSCode](https://code.visualstudio.com/download)
- All content related today's training is under "**jftd-112-devops-at-scale/**".

<br/>

## SETUP ENV VARIABLES [Must]
- Our directory `SwampUp2024/jftd-112-devops-at-scale/lab-0-Configure-JFrog-CLI` has `setup.sh` file where we need define environment variables.
    - Mandatory - 
      - JFROG_PLATFORM,
      - JFROG_HOST, (same as JFROG_PLATFORM without HTTPs)
      - JFROG_PLATFORM_2, (this will be JPD2)
      - JFROG_EDGE,
      - ADMIN_USER, 
      - ADMIN_PASSWORD, 
      - ACCESS_TOKEN

<br/>


## Run Labs

### Option 1 [Recommended]
- We will provide cloud hosted VM with basic setup like maven, npm, docker, git client install
    - this will ease your setup to run labs
    - NOTE: To ssh into that machine, it is required to have SSH and telnet client like terminal, puTTY, git bash or your preferred client

### Option 2
- We will be using IDE (any with terminal) or terminal/CMD as part of our labs so please download and install one if you do not have one on your workstation.
- Download [JFrog CLI](https://jfrog.com/getcli/) based on our machine.
- Setup MAVEN or NPM and Docker Client.
    - so we can run commands like `mvn install`, `npm install` or `docker pull image:tag`
