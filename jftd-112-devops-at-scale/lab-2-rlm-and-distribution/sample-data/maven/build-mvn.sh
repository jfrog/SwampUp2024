export buildName=mavenModule
export buildVersion=1
jf --version
jf rt ping

jf mvnc --repo-resolve-releases payment-maven-dev-virtual --repo-resolve-snapshots payment-maven-dev-virtual --repo-deploy-releases payment-maven-dev-virtual --repo-deploy-snapshots payment-maven-dev-virtual

jf mvn clean install -f pom.xml --build-name ${buildName} --build-number ${buildVersion}

jf rt bce ${buildName} ${buildVersion}
jf rt bag ${buildName} ${buildVersion}
jf rt bp ${buildName} ${buildVersion}
# jf rt bs ${buildName} ${buildVersion}

jf rbc --builds=json/builds-spec.json --signing-key=thekey mavenModuleRelease ${buildVersion}

# promote to Dev
jf rbp mavenModuleRelease ${buildVersion} DEV --signing-key=thekey --include-repos=payment-maven-dev-local

# Promote to QA
jf rbp mavenModuleRelease ${buildVersion} QA --signing-key=thekey --include-repos=payment-maven-qa-local

 # Promote to PROD
jf rbp mavenModuleRelease ${buildVersion} PROD --signing-key=thekey --include-repos=payment-maven-prod-local


# Distribute the Release Bundle to another JPD instance
jf rbd mavenModuleRelease ${buildVersion} --signing-key=thekey --dist-rules=dist-rules.json --create-repo=true

# Distribute the Release Bundle to another JPD Edge
jf ds rbs --sign=thekey mavenModuleRelease ${buildVersion}
jf ds rbd mavenModuleRelease ${buildVersion} --dist-rules=dist-rules.json --create-repo=true