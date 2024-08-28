# CREATE JFROG PROJECT
curl -XPOST "${JFROG_PLATFORM}/access/api/v1/projects" \
 -H "Authorization: Bearer ${ACCESS_TOKEN}" \
 -H "Content-Type: application/json" \
 -d "@create-project.json"

# GET PROJECT USERS
curl -XGET "${JFROG_PLATFORM}/access/api/v1/projects/swampup/users" \
 -H "Authorization: Bearer ${ACCESS_TOKEN}" \
 -H "Content-Type: application/json"

# GET PROJECT ROLES
curl -XGET "${JFROG_PLATFORM}/access/api/v1/projects/swampup/roles" \
 -H "Authorization: Bearer ${ACCESS_TOKEN}" \
 -H "Content-Type: application/json"

# UPDATE PROJECT USERS AND ASSIGN ROLE
curl -XPUT "${JFROG_PLATFORM}/access/api/v1/projects/swampup/users/support" \
 -H "Authorization: Bearer ${ACCESS_TOKEN}" \
 -H "Content-Type: application/json" \
 -d "@project-user.json"

# MOVE REPOSITORY TO PROJECT
curl -XPUT "${JFROG_PLATFORM}/access/api/v1/projects/_/attach/repositories/notification-npm-dev-local/swampup?force=true'" \
 -H "Authorization: Bearer ${ACCESS_TOKEN}" \
 -H "Content-Type: application/json"