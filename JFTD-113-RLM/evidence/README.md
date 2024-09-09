# Intro to evidence used here:

- The evidence is used in the Labs for this class

- jf evd create --predicate file.json --predicate-type predicate-type-uri --subject-repo-pat <target-path[@digest]> --key <local-private-key-path> --key-name <RSA-1024>

Example:

jf evd create --predicate results.json --predicate-type predicate-type-uri --subject-repo-path puser0-dev-helm-local/nginx.tar --key private.pem --key-alias evd-key


- jf evd create --key "${{ secrets.PRIVATE_KEY }}" --key-alias CI-RSA-KEY  --release-bundle ${{ vars.BUNDLE_NAME }} --release-bundle-version ${{ vars.VERSION }} --project ${{vars.PROJECT}} --predicate ./policy.json --predicate-type https://jfrog.com/evidence/approval/v1


Example:

jf evd create --key private.pem --key-alias evd-key --release-bundle Test-Build-Beta --release-bundle-version 1.0.1 --project puser0 --predicate results.json --predicate-type https://jfrog.com/evidence/approval/v1 
