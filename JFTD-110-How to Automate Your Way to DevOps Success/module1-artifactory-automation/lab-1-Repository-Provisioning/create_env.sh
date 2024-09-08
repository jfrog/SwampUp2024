curl -XPOST "${JFROG_PLATFORM}/access/api/v1/environments" \
 -H "Authorization: Bearer ${ACCESS_TOKEN}" \
 -H "Content-Type: application/json" \
 -d "@createEnv.json"
