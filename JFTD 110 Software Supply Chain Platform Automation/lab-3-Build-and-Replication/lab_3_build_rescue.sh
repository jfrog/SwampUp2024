cd ./example/maven-example
# config Maven
jf mvnc --server-id-resolve swampup --server-id-deploy swampup --repo-resolve-releases payment-maven-dev-virtual --repo-resolve-snapshots payment-maven-dev-virtual --repo-deploy-releases payment-maven-dev-virtual --repo-deploy-snapshots payment-maven-dev-virtual

# Build Maven Project
jf mvn clean install -f pom.xml --build-name payment-maven --build-number 2.0.0

jf rt bce payment-maven 2.0.0
jf rt bag payment-maven 2.0.0
jf rt bp payment-maven 2.0.0

cd ../npm-example

# Config NPM
jf npmc --server-id-resolve swampup --server-id-deploy swampup --repo-resolve auth-npm-dev-virtual --repo-deploy auth-npm-dev-virtual

# Build NPM Project
jf npm install --build-name auth-npm --build-number 2.0.0
jf npm publish --build-name auth-npm --build-number 2.0.0

jf rt bce auth-npm 2.0.0
jf rt bag auth-npm 2.0.0
jf rt bp auth-npm 2.0.0

# Build promotion to QA for integration tests.
jf rt bpr payment-maven 2.0.0 payment-maven-qa-local --status='QA candidate' --comment='webservice is now QA candidate and hand over for regression test' --copy=true --props="maintainer=maharship;stage=qa"
jf rt bpr auth-npm 2.0.0 auth-npm-qa-local --status='QA candidate' --comment='webservice is now QA candidate and hand over for regression test' --copy=true --props="maintainer=maharship;stage=qa"

jf rt sp "payment-maven-qa-local/org/jfrog/test/" "unit.test=pass;integration.test=null;"
jf rt sp "auth-npm-dev-local/npm-example/-/npm-example-1.1.6.tgz" "unit.test=pass;integration.test=null;"

# Build promotion to Prod after integration tests.
jf rt bpr payment-maven 2.0.0 payment-maven-prod-local --status='Prod candidate' --comment='webservice is now prod ready' --copy=true --props="maintainer=maharship;stage=prod"
jf rt bpr auth-npm 2.0.0 auth-npm-prod-local --status='Prod candidate' --comment='webservice is now prod ready' --copy=true --props="maintainer=maharship;stage=prod"

jf rt sp "payment-maven-qa-local/org/jfrog/test/" "unit.test=pass;integration.test=pass;"
jf rt sp "auth-npm-dev-local/npm-example/-/npm-example-1.1.6.tgz" "unit.test=pass;integration.test=pass;"

cd ../../

jf rbc --builds=rbv2-npm.json --signing-key=mykey auth-npm 2.0.0
jf rbc --builds=rbv2-maven.json --signing-key=mykey payment-maven 2.0.0