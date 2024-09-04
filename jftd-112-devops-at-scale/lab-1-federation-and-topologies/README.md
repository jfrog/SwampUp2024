# LAB 1 - Federation and Topologies

## Prerequisites
- Lab-0 - Configure JFrog CLI

<br />

## CREATE GLOBAL ENVIRONMENT VARIABLE [MUST]
- Open `createEnv.json` where we define environment variable `QA`
- Review `sh create_env.sh`
  - run `sh create_env.sh`

<br />

## CREATE REPOSITORY TEMPLATES [MUST]
- Federated Repository Template
    - run ``jf rt repo-template template-federated.json``
        - Select the template type (press Tab for options): `create`
        - Insert the repository key > `auth-npm-dev-federated`
        - Select the repository class (press Tab for options): `federated`
        - Select the repository's package type (press Tab for options): `npm`
        - You can type ":x" at any time to save and exit.
        - Select the next configuration key (press Tab for options): `repoLayoutRef`
        - Insert the value for repoLayoutRef (press Tab for options): > `npm-default`
        - Select the next configuration key (press Tab for options): `environment`
        - Insert the name of the environment to assign to > `DEV`
        - Select the next configuration key (press Tab for options): `xrayIndex`
        - Insert the value for xrayIndex (press Tab for options): > `true`
        - Select the next configuration key (press Tab for options): `:x`
        - Validate template `template-federated.json` is created successfully. - ``ls -la``
        - View template
          ```json
          {
            "key":"${repo-name}",               # auth-npm-dev-federated
            "packageType":"${package-type}",    # npm
            "rclass":"${repo-type}",            # federated
            "repoLayoutRef":"${repo-layout}",   # npm-default
            "environments":"${env}",            # DEV
            "xrayIndex":"${xray-enable}"        # true
          }
          ```

<br />

## CREATE REPOSITORY [MUST]
- Run ``jf rt repo-create template-{{ federated|local|remote|virtual }}.json``

  or

  ``jf rt rc template-{{ federated|local|remote|virtual }}.json``


- We can run this for remote and virtual repository but please SKIP this step and proceed with next step.

<br />


## RUN SCRIPT - Prerequisites for future labs that CREATES ALL REPOSITORIES [MUST]
- Run `sh lab_1_rescue.sh` and it will create all local, remote, virtual repositories.
  - NOTE: Please make sure, 
    - Main instance JFrog CLI server ID  is `swampup` [case sensitive]
    - Edge instance JFrog CLI server ID  is `swampupedge` [case sensitive]
    - if it's different then please update those IDs in lab_1_rescue.sh and lab_1_rescue_for_edge.sh

<br />

## UPLOAD MAVEN AND NPM ARTIFACTS [MUST]
- Run ``cd sample-data/maven``
    - ``jf rt u "./hello-world-api/*" "payment-maven-dev-virtual/"``
    - For bulk uploads, ``jf rt u "./*" "payment-maven-dev-virtual/" --threads 10``
        - NOTE: we are using 10 threads here
- Run ``cd sample-data/npm``
    - ``jf rt u "./hello-world-ui/*" "auth-npm-dev-virtual/"``
    - For bulk uploads, ``jf rt u "./*" "auth-npm-dev-virtual/" --threads 10``
        - NOTE: we are using 10 threads here

<br />

## CONVERT LOCAL REPOSITORY TO A FEDERATED REPOSITORY [MUST]
- run `jf rt curl -XPOST "/api/federation/migrate/notification-npm-dev-local" -H "Content-Type: application/json"`

<br />

## REFERENCE SAMPLE REPOSITORY CONFIGURATIONS [Optional]
- [Repository Configuration JSON](https://jfrog.com/help/r/jfrog-rest-apis/repository-configuration-json)

<br />

## REGISTER JPDs BEFORE ADD MEMBER NODE TO FEDERATED REPOSITORY [MUST]
- We have two ways to setup
  - Option 1: Using Circle Of Trust between JPDs 
  - Option 2: Using Binding Token
- Register JPD2 to JPD1, `Administration` > `Topology` > `JPD Services`
- Click on `+ New Platform Deployments`
- Enter Name - `jpd2`
- Location -> `Select Location` - Enter `Los Angeles (US)` -> Create
- JFrog Platform URL - `https://{{JPD2}}.jfrog.io` -> Click on Get Server Details
  - Please enter `JPD2 URL` that is assign to `your lab` environment 
  - NOTE: DONOT Close this browser window 
- Open New Browser Tab with `https://{{JPD2}}.jfrog.io`
  - Click on `Administration` > `User Management` > `Access Token` > `+ Generate Token` > Select `Pairing Token`    
    - `* Generate Pairing Token for:` - click on the dropdown and Select `Mission Control`  
    - Click on `Generate`
  - Copy `Token` and save in your notes
- Go back to previous tab with `JPD1 URL` 
  - `Administration` > `Topology` > `JPD Services` 
  - Enter `Pairing Token`
  - Enter Unique Tag `Tags` - jpd2
  - Click on `Add`
- Verify the message

<br />

## ADD MEMBER NODE TO FEDERATED REPOSITORY [MUST]
- We have two JPDs, lets called that JPD1(main) and JPD2(2nd site) moving forward.
- Open `JPD1 URL` in browser 
- `Administration` > `Repositories` > `Federated` > `notification-npm-dev-local` > `Federation`
- Click `Add Repository`
  - `JPD2` deployment will appear under `Deployments`
  - Expand `JPD2`, it will show list of repository for same package as well as `+ Create Repository` with same name
  - We can also use URL based approach

<br />

## UPLOAD MAVEN AND NPM ARTIFACTS [MUST]
- Run ``cd sample-data/maven``
    - ``jf rt u "./hello-world-api/*" "payment-maven-dev-virtual/"``
    - For bulk uploads, ``jf rt u "./*" "payment-maven-dev-virtual/" --threads 10``
        - NOTE: we are using 10 threads here
- Run ``cd sample-data/npm``
    - ``jf rt u "./hello-world-ui/*" "auth-npm-dev-virtual/"``
    - For bulk uploads, ``jf rt u "./*" "auth-npm-dev-virtual/" --threads 10``
        - NOTE: we are using 10 threads here

<br />

## REVIEW FEDERATED REPOSITORY CONFIGURATIONS [Optional]
- Check `Administration` > `Repositories` > `Federated` > `...` when hover on the repository name 
- Select `Federation Status`
- Review other feature from dropdown and ask questions

<br />

## ACCESS FEDERATION [MUST]
- Open `JPD1 URL` in browser
- `Administration` > `Topology` > `Access Federation`
- Let's Create MESH TOPOLOGY across sites
- Click `Apply Topology` > `Mesh`
  - Verify that `Topology:Full Mesh`
  - Select `All 3 JPDs` and Move to right 
  - Click `Finish`
  - Verify the message with `Success`
- Create [MESH TOPOLOGY using REST API](https://jfrog.com/help/r/jfrog-rest-apis/create-mesh)
  - run `jf rt curl -XPOST "/mc/api/v1/federation/create_mesh" -d "@createMeshTopologySample.json"`

<br />
<br />
<br />
    
## CHALLENGE - Create / Update Repository [Optional]
- Make changes into `notification-npm-dev-local` Federated Repository Configuration on JPD1
  - `Push Configuration` to JPD2
