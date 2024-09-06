# Health check JFrog Artifactory instance
export buildName=reactModule
export buildVersion=1
jf --version
jf rt ping

jf npmc --repo-resolve auth-npm-dev-virtual --repo-deploy auth-npm-dev-virtual


jf npm install --build-name ${buildName} --build-number ${buildVersion}
jf npm publish --build-name ${buildName} --build-number ${buildVersion}


jf rt bce ${buildName} ${buildVersion}

jf rt bag ${buildName} ${buildVersion}

jf rt bp ${buildName} ${buildVersion}

jf rt bs ${buildName} ${buildVersion}

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


jf ds rbs --sign=thekey reactModuleRelease ${buildVersion}
jf ds rbd reactModuleRelease ${buildVersion} --dist-rules=dist-rules.json --create-repo=true