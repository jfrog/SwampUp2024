provider "xray" {
	url             = "https://${var.JFROG_PLATFORM_URL}/xray"
	access_token    = "${var.JFROG_PLATFORM_ACCESS_TOKEN}"
}

# resource "xray_binary_manager_repos" "repo_index_config_default" {
# 	id					  = "default"
#   project_key   = "${var.JFROG_PROJECT_NAME}"
# 	indexed_repos = [
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}=landing-docker-dev-local"
#       "type" = "local"
#       "package_type" = "Docker"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}=landing-docker-remote"
#       "type" = "remote"
#       "package_type" = "Docker"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}=landing-npm-dev-local"
#       "type" = "local"
#       "package_type" = "Npm"
#     },
#     {
#       "name" = "${var.JFROG_PROJECT_NAME}=landing-npm-remote"
#       "type" = "remote"
#       "package_type" = "Npm"
#     },
#   ]
# }

resource "xray_binary_manager_builds" "build_index_config_default" {
  id              = "default"
  project_key     = "${var.JFROG_PROJECT_NAME}"
  indexed_builds  = "${var.BUILDS_INDEX_LIST}"
}