# Intro to evidence used here:

- The evidence is used in the Labs for this class

- jf evd create --predicate results.json --predicate-type https://nasa/test-results --repo-path commons-dev-generic-local/common/catchphrase.txt --key private-key.pem
- jf evd create --key "${{ secrets.PRIVATE_KEY }}" --key-alias CI-RSA-KEY  --release-bundle ${{ vars.BUNDLE_NAME }} --release-bundle-version ${{ vars.VERSION }} --project ${{vars.PROJECT}} --predicate ./policy.json --predicate-type https://jfrog.com/evidence/approval/v1
