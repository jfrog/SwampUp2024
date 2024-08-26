# Lab 0: Tools Installation & Validation

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
    * JFrog access token (Leave blank for username and password/API key): `{access token}`
      * To create an access token, navigate on the UI to Administration > User management > Access Tokens > Generate token
        <br/>
        <img src="user-mgmt-for-token-create.jpg" alt="create user token" width="600" height="300">
        <br/> 
    * JFrog username: `{username}`
    * JFrog password or API key: `{password} or {api key}`
  * Is the Artifactory reverse proxy configured to accept a client certificate? (y/n): `n`
  * Use the configured instance - `jf config use {server ID}` Ex: `jf config use swampup`
<br/>


* Validate your connection with a basic connection health check: `jf rt ping`
  <br/>
  <br/>
  ![jf config add and check](image15.png)

## IDE Installation
### VS Code //TODO
### IntelliJ IDE //TODO
### Eclipse //TODO

## Git Installation
Verify you have a working installation of `git`: `git -v`.  If you don't have `git` installed, use one of the following methods:
### macOS
`brew install git` 
### Windows
[Windows Installation Options](https://git-scm.com/download/win)
### Linux
[Linux Installation Options](https://git-scm.com/download/linux)

## NPM Installation
[Installation guidance](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)
### Windows
### macOS
### Linux