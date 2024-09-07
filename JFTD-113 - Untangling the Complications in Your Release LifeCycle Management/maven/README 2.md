# Maven build for class - JFTD 113

This Maven build is used for RLM builds that will used in the Labs

Please use the JFrog CLI to build and upload this to your JFrog Platform instance
Please make sure you configure your JFrog CLI to connect to your instance

- mvn clean install
- jf rt u ./application/target/multi-module-application-3.0.0.jar PROJECT-ID-dev-maven-virt --build-name=sample-maven-build  --build-number=1.0.1 --project=PROJECT-ID
- jf rt build-add-git sample-maven-build 1.0.1 --project=PROJECT-ID
- jf rt build-collect-env sample-maven-build 1.0.1 --project=PROJECT-ID
- jf rt build-publish sample-maven-build 1.0.1 --project=PROJECT-ID

