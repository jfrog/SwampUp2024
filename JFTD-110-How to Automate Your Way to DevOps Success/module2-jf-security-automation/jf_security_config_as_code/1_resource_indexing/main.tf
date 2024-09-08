provider "xray" {
	url             = "https://${var.JFROG_PLATFORM_URL}/xray"
	access_token    = "${var.JFROG_PLATFORM_ACCESS_TOKEN}"
}

resource "xray_binary_manager_builds" "build_index_config_default" {
  id              = "default"
  project_key     = "${var.JFROG_PROJECT_NAME}"
  indexed_builds  = "${var.BUILDS_INDEX_LIST}"
}

# # Skipped as repos are already indexed 
# resource "xray_binary_manager_repos" "repo_index_config_default" {
# 	id					  = "default"
#   project_key   = "${var.JFROG_PROJECT_NAME}"
# 	indexed_repos = [
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}-demonodeapp-docker-dev-local"
#       "type" = "local"
#       "package_type" = "Docker"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}-demonodeapp-docker-qa-local"
#       "type" = "local"
#       "package_type" = "Docker"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}-demonodeapp-docker-prod-local"
#       "type" = "local"
#       "package_type" = "Docker"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}-docker-remote"
#       "type" = "remote"
#       "package_type" = "Docker"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}-demonodeapp-npm-dev-local"
#       "type" = "local"
#       "package_type" = "Npm"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}-demonodeapp-npm-qa-local"
#       "type" = "local"
#       "package_type" = "Npm"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}-demonodeapp-npm-prod-local"
#       "type" = "local"
#       "package_type" = "Npm"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}-npm-remote"
#       "type" = "remote"
#       "package_type" = "Npm"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}-payment-maven-dev-local"
#       "type" = "local"
#       "package_type" = "Maven"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}-payment-maven-qa-local"
#       "type" = "local"
#       "package_type" = "Maven"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}-payment-maven-prod-local"
#       "type" = "local"
#       "package_type" = "Maven"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}-maven-remote"
#       "type" = "remote"
#       "package_type" = "Maven"
#     }
#   ]

#   lifecycle {
#     # ignore_changes = all
#     ignore_changes = [ 
#       indexed_repos
#     ]
#   }
# }