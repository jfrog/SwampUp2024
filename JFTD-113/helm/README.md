# Helm build for class - JFTD 113

This helm chart is used for RLM builds that will used in the Labs

Please use the JFrog CLI to build and upload this to your JFrog Platform instance
Please make sure you configure your JFrog CLI to connect to your instance

- jf rt build-add-git sample-helm-build 1.0.1 --project=<jfrog_project_name>
- jf rt build-collect-env sample-helm-build 1.0.1 --project=<jfrog_project_name>
- jf rt u nginx.tar jftd113-dev-helm-virt --build-name=sample-helm-build  --build-number=1.0.1 --project=<jfrog_project_name>
- jf rt build-publish sample-helm-build 1.0.1 --project=<jfrog_project_name>
