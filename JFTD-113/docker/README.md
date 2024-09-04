# Docker build for class

This Docker Iamge is used for RLM builds that will used in the Labs

Please use the JFrog CLI to build and upload this to your JFrog Platform instance
Please make sure you configure your JFrog CLI to connect to your instance

- jf docker build -t sample-docker .
- docker tag sample url_of_jfrog_platform/jftd113-dev-docker-virt/sample-docker:latest
- docker push url_of_jfrog_platform/jftd113-dev-docker-virt/sample-docker:latest
- jf rt dp url_of_jfrog_platform/jftd113-dev-docker-virt/sample-docker:latest jftd113-dev-docker-virt --build-name=sample-docker-build  --build-number=1.0.1 --project=jftd113\
- jf rt build-add-git sample-docker 1.0.1 --project=jftd113
- jf rt build-collect-env sample-docker 1.0.1 --project=jftd113
- jf rt build-publish sample-docker 1.0.1 --project=jftd113
