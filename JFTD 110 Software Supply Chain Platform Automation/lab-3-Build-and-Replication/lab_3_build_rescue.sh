cd ./example/maven-example
# config Maven
jf mvnc --server-id-resolve swampup --server-id-deploy swampup --repo-resolve-releases $projectKey-payment-maven-dev-virtual --repo-resolve-snapshots $projectKey-payment-maven-dev-virtual --repo-deploy-releases $projectKey-payment-maven-dev-virtual --repo-deploy-snapshots $projectKey-payment-maven-dev-virtual

# Build Maven Project
jf mvn clean install -f pom.xml --build-name payment-maven --build-number 2.0.0

jf rt bce payment-maven 2.0.0 --project $projectKey
jf rt bag payment-maven 2.0.0 --project $projectKey
jf rt bp payment-maven 2.0.0 --project $projectKey

cd ../npm-example

# Config NPM
jf npmc --server-id-resolve swampup --server-id-deploy swampup --repo-resolve $projectKey-auth-npm-dev-virtual --repo-deploy $projectKey-auth-npm-dev-virtual

# Build NPM Project
jf npm install --build-name auth-npm --build-number 2.0.0
jf npm publish --build-name auth-npm --build-number 2.0.0

jf rt bce auth-npm 2.0.0 --project $projectKey
jf rt bag auth-npm 2.0.0 --project $projectKey
jf rt bp auth-npm 2.0.0 --project $projectKey

# Build promotion to QA for integration tests.
jf rt bpr payment-maven 2.0.0 $projectKey-payment-maven-qa-local --status='QA candidate' --comment='webservice is now QA candidate and hand over for regression test' --copy=true --props="maintainer=maharship;stage=qa" --project=$projectKey
jf rt bpr auth-npm 2.0.0 $projectKey-auth-npm-qa-local --status='QA candidate' --comment='webservice is now QA candidate and hand over for regression test' --copy=true --props="maintainer=maharship;stage=qa" --project=$projectKey

jf rt sp "payment-maven-qa-local/org/jfrog/test/" "unit.test=pass;integration.test=null;" --project $projectKey
jf rt sp "auth-npm-dev-local/npm-example/-/npm-example-1.1.6.tgz" "unit.test=pass;integration.test=null;" --project $projectKey

# Build promotion to Prod after integration tests.
jf rt bpr payment-maven 2.0.0 $projectKey-payment-maven-prod-local --status='Prod candidate' --comment='webservice is now prod ready' --copy=true --props="maintainer=maharship;stage=prod" --project=$projectKey
jf rt bpr auth-npm 2.0.0 $projectKey-auth-npm-prod-local --status='Prod candidate' --comment='webservice is now prod ready' --copy=true --props="maintainer=maharship;stage=prod" --project=$projectKey

jf rt sp "payment-maven-qa-local/org/jfrog/test/" "unit.test=pass;integration.test=pass;"  --project $projectKey
jf rt sp "auth-npm-dev-local/npm-example/-/npm-example-1.1.6.tgz" "unit.test=pass;integration.test=pass;"  --project $projectKey

cd ../../

jf rbc --builds=rbv2-npm.json --signing-key=debian-erika auth-npm 2.0.2 --project $projectKey
jf rbc --builds=rbv2-maven.json --signing-key=debian-erika payment-maven 2.0.2 --project $projectKey