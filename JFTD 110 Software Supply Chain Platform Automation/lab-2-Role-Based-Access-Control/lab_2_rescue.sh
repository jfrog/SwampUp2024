#!/bin/bash
source ./config.sh
# GET JFROG PROJECT
curl -XGET "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}" \
 -H "Authorization: Bearer ${ACCESS_TOKEN}"

# GET PROJECT GROUPS
curl -XGET "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/groups" \
 -H "Authorization: Bearer ${ACCESS_TOKEN}"

 # GET PROJECT USERS
curl -XGET "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/users" \
 -H "Authorization: Bearer ${ACCESS_TOKEN}"

# Add User in Project
curl -XPUT "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/users/mike" \
 -H "Authorization: Bearer ${ACCESS_TOKEN}" \
 -H "Content-Type: application/json" \
 -d "@add-user.json"

 # Update User in Project
 curl -XPUT "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/users/mike" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "@update-user.json"

  # Delete User in Project
  curl -XDELETE "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/users/mike" \
   -H "Authorization: Bearer ${ACCESS_TOKEN}" \
   -H "Content-Type: application/json"

  # GET PROJECT ROLES
  curl -XGET "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/roles" \
   -H "Authorization: Bearer ${ACCESS_TOKEN}"

  # Delete role in Project
   curl -XDELETE "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/roles/SeniorDeveloper" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}"

 # Add role in Project
 curl -XPOST "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/roles" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "@add-role.json"

  # Update role in Project
   curl -XPUT "${JFROG_PLATFORM}/access/api/v1/projects/${projectKey}/roles/SeniorDeveloper" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -H "Content-Type: application/json" \
    -d "@update-role.json"

