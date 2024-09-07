# LAB 2 - RELEASE LIFECYCLE MANAGEMENT AND DISTRIBUTION PATTERNS

## Prerequisites
- Lab-0 - Configure JFrog CLI
- Lab-1 - Federation and Topologies
- Lab-2 - Release Lifecycle Management and Distribution Patterns

## Release Lifecycle Management
#### For NPM sample project for build, 
  - `cd jftd-112-devops-at-scale/lab-2-rlm-and-distribution/sample-data/npm/react-node-app`
    - ```
      export buildName=reactModule
      export buildVersion=1
      
      jf npmc --repo-resolve auth-npm-dev-virtual --repo-deploy auth-npm-dev-virtual
      jf npm install --build-name ${buildName} --build-number ${buildVersion}
      jf npm publish --build-name ${buildName} --build-number ${buildVersion}
      
      jf rt bce ${buildName} ${buildVersion}
      jf rt bag ${buildName} ${buildVersion}
      jf rt bp ${buildName} ${buildVersion}
      ```

 - `Run the following command to create a release bundle version 2 for the npm package`
   - ```
        jf rbc --builds=json/builds-spec.json --signing-key=thekey reactModuleRelease ${buildVersion}
       
        # promote to Dev
        jf rbp reactModuleRelease ${buildVersion} DEV --signing-key=thekey --include-repos=auth-npm-dev-local
        jf rt set-props "auth-npm-dev-local/react-bank-api/-/react-bank-api-1.0.1.tgz" "unit.test=pass;integration.test=null;"
  
        # Promote to QA
        jf rbp reactModuleRelease ${buildVersion} QA --signing-key=thekey --include-repos=auth-npm-qa-local
        jf rt set-props "auth-npm-qa-local/react-bank-api/-/react-bank-api-1.0.1.tgz" "unit.test=pass;integration.test=pass;"
  
        # Promote to PROD
        jf rbp reactModuleRelease ${buildVersion} PROD --signing-key=thekey --include-repos=auth-npm-prod-local
        
        jf rbd reactModuleRelease ${buildVersion} --signing-key=thekey --dist-rules=dist-rules.json --create-repo=true
     ```
     
 - `Run the following command for distribution`
   - ```
        jf ds rbs --sign=thekey reactModuleRelease ${buildVersion}
        jf ds rbd reactModuleRelease ${buildVersion} --dist-rules=dist-rules.json --create-repo=true
     ```

#### For MAVEN sample project for build,
    - `cd jftd-112-devops-at-scale/lab-2-rlm-and-distribution/sample-data/maven`
        - ```
             export buildName=mavenModule
             export buildVersion=1

             jf mvnc --repo-resolve-releases payment-maven-dev-virtual --repo-resolve-snapshots payment-maven-dev-virtual --repo-deploy-releases payment-maven-dev-virtual --repo-deploy-snapshots payment-maven-dev-virtual

             jf mvn clean install -f pom.xml --build-name ${buildName} --build-number ${buildVersion}

             jf rt bce ${buildName} ${buildVersion}
             jf rt bag ${buildName} ${buildVersion}
             jf rt bp ${buildName} ${buildVersion}
         ```
    - `Run the following command to create a release bundle version 2 for the npm package`
        - ```
            jf rbc --builds=json/builds-spec.json --signing-key=thekey mavenModuleRelease ${buildVersion}

            # promote to Dev
            jf rbp mavenModuleRelease ${buildVersion} DEV --signing-key=thekey --include-repos=payment-maven-dev-local
            
            # Promote to QA
            jf rbp mavenModuleRelease ${buildVersion} QA --signing-key=thekey --include-repos=payment-maven-qa-local
            
            # Promote to PROD
            jf rbp mavenModuleRelease ${buildVersion} PROD --signing-key=thekey --include-repos=payment-maven-prod-local
            

            # Distribute the Release Bundle to another JPD instance
            jf rbd mavenModuleRelease ${buildVersion} --signing-key=thekey --dist-rules=dist-rules.json --create-repo=true
         ```

    - `Run the following command for distribution`
        - ```
            jf ds rbs --sign=thekey mavenModuleRelease ${buildVersion}
            jf ds rbd mavenModuleRelease ${buildVersion} --dist-rules=dist-rules.json --create-repo=true
         ```