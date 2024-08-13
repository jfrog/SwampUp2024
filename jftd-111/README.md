## SwampUp 2023
## Course: JFTD 101 - Evolving from DevOps to DevSecOps

### Agenda:
- Lab 0 - Setup JFrog CLI
- Lab 1 - Curation
- Lab 2 - Shift left
- Lab 3 - Xray build scan
- Lab 4 - Advanced security scan

<br/>

### Prerequisites
- [git client](https://git-scm.com/downloads)
- [VS Code](https://code.visualstudio.com/download) IDE
- [npm client](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

- Run `git clone https://github.com/jfrog/SwampUp2023.git`
  - All content related to this training is under [JFTD101 - Evolving from DevOps to DevSecOps](https://github.com/jfrog/SwampUp2023/tree/main/JFTD101-Evolving-from-DevOps-to-DevSecOp)

If you want to use the provided ec2 instance for the lab :
- Download the ec2.pem  in ‘ec2_pem_key’ repository ex:https://sup23sjom102.jfrog.io/artifactory/ec2_pem_key/
- Command  to ssh
  chmod 400 ec2.pem && ssh -i ec2.pem ubuntu@<YOUR EC2 INSTANCE>
  Example:
  chmod 400 ec2.pem && ssh -i ec2.pem ubuntu@ec2-17-132-129-36.eu-west-2.compute.amazonaws.com