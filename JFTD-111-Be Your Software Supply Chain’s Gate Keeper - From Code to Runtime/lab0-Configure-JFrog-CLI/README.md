# Lab 0: Tools Installation & Validation

Your 
Terminal app installation is told a head of time

## JFrog CLI setup
### Installation & validation
  * Install JFrog CLI - https://jfrog.com/getcli/
  * Easiest options: 
    - macOS: `brew install jfrog-cli`
    - Windows: `choco install jfrog-cli`
  * Check and confirm the install - `jf -v`

### Configuration with JFrog instance
  * Add a config - `jf config add`
  * Choose a server ID: {unique name} Ex: `swampup`
  * JFrog platform url: `{your Jfrog instance url}` Ex: https://southbay.jfrog.io
  * Use one of these methods to authenticate to the workshop instance:
    * JFrog username: `{username}`
    * JFrog password or API key: `{password} or {api key}`
  * Is the Artifactory reverse proxy configured to accept a client certificate? (y/n): `n`
  * Use the configured instance - `jf config use {server ID}` Ex: `jf config use swampup`


* Validate your connection with a basic connection health check: `jf rt ping`

## IDE Installation
If you don't have a preferred Code editor / IDE installed on your local machine, we recommend installing VSCode from Microsoft.  

Head to the VSCode download site and follow the instrctions for your machine
https://code.visualstudio.com/download

## Git Installation
Verify you have a working installation of `git`: `git -v`.  If you don't have `git` installed, use one of the following methods:
### macOS
`brew install git` 
### Windows
[Windows Installation Options](https://git-scm.com/download/win)
### Linux
[Linux Installation Options](https://git-scm.com/download/linux)

## NPM Installation
* [Installation guidance](https://nodejs.org/en/download/package-manager)
* Once Node and NPM is installed run the following commands in your terminal to validate:
```bash
node --version
npm --version
```

## Clone
