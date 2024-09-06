# Demo Node.js Application
This is a sample node js application created for demo

## Stack
Node.js | Express | EJS

### Bootstrapping the app
```
npm install
DEBUG=demo-node-app:* npm start
## App should be up and running on port 3000
```

### Docker Build
```
docker build -t <JFROG_PLATFORM_URL>/<DOCKER_REPO_NAME>/swampup-demo-node-app:latest .
docker run --rm -it -p 3000:3000 <JFROG_PLATFORM_URL>/<DOCKER_REPO_NAME>/swampup-demo-node-app:latest
docker login <JFROG_PLATFORM_URL>
docker push <JFROG_PLATFORM_URL>/<DOCKER_REPO_NAME>/swampup-demo-node-app:latest
```

###  Publish to JFrog Artifactory
```
npm config set registry https://<JFROG_PLATFORM_URL>/artifactory/api/npm/<NPM_REPO_NAME>/
npm login
npm publish --registry https://<JFROG_PLATFORM_URL>/artifactory/api/npm/<NPM_REPO_NAME>/
```