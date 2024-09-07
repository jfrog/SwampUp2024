# Docker build for class

This Docker Iamge is used for RLM builds that will used in the Labs

Please use the JFrog CLI to build and upload this to your JFrog Platform instance
Please make sure you configure your JFrog CLI to connect to your instance

- jf docker build -t sample-docker .
- docker login -utrainer JFROG-INSTANCE-ID.jfrog.io
- The Password is found in the Set Me Up in Artifactory, go there and use that id
- docker tag sample-docker JFROG-INSTANCE-ID.jfrog.io/PROJECT-ID-dev-docker-virt/sample-docker:latest
- docker push sample-docker JFROG-INSTANCE-ID.jfrog.io/PROJECT-ID-dev-docker-virt/sample-docker:latest
- jf rt dp JFROG-INSTANCE-ID.jfrog.io/PROJECT-ID-dev-docker-virt/sample-docker:latest PROJECT-ID-dev-docker-virt --build-name=sample-docker-build  --build-number=1.0.1 --project=PROJECT-ID
- jf rt build-add-git sample-docker-build 1.0.1 --project=PROJECT-ID
- jf rt build-collect-env sample-docker-build 1.0.1 --project=PROJECT-ID
- jf rt build-publish sample-docker-build 1.0.1 --project=PROJECT-ID
