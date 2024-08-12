# zen-website

* Taken from: https://auth0.com/blog/create-a-simple-and-stylish-node-express-app/

* NPM Packages for Project
* npm i -D nodemon
* npm i express
* npm i pug
* npm i -D browser-sync

* Run NPM
* npm run dev
* npm run ui < browser-sync version
* npm set audit false

* jfrog rt c show
* rm -rf node_modules
* jfrog rt npmc
* jfrog rt npm-install --build-name=ZenNodeProject --build-number=1.0.1
* jfrog rt build-add-git ZenNodeProject  1.0.1
* jfrog rt build-collect-env ZenNodeProject  1.0.1
* jfrog rt npm-publish --build-name=ZenNodeProject --build-number=1.0.1
* jfrog rt build-publish ZenNodeProject 1.0.1
* Test
* Good luck .. you'll need it 
