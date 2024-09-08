#Create Release Bundle V2
jf rbc --spec=rbv2-npm.json --signing-key=debian-erika auth-npm 2.0.0 --project $projectKey --spec-vars="key1=tftd110tr2"
jf rbc --spec=rbv2-maven.json --signing-key=debian-erika payment-maven 2.0.0 --project $projectKey  --spec-vars="key1=tftd110tr2"


#Promote to other Environment of auth-npm

jf rbp auth-npm 2.0.0 QA --project $projectKey --signing-key=debian-erika
jf rbp auth-npm 2.0.0 PROD --project $projectKey --signing-key=debian-erika

#Promote to other Environment of payment-maven

jf rbp payment-maven 2.0.0 QA --project $projectKey --signing-key=debian-erika
jf rbp payment-maven 2.0.0 PROD --project $projectKey --signing-key=debian-erika