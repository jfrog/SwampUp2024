provider "xray" {
	url             = "https://${var.JFROG_PLATFORM_URL}/xray"
	access_token    = "${var.JFROG_PLATFORM_ACCESS_TOKEN}"
}

resource "xray_binary_manager_builds" "build_index_config_default" {
  id              = "default"
  project_key     = "${var.JFROG_PROJECT_NAME}"
  indexed_builds  = "${var.BUILDS_INDEX_LIST}"
}

# Skipped as repos are already indexed 
resource "xray_binary_manager_repos" "repo_index_config_default" {
	id					  = "default"
  project_key   = "${var.JFROG_PROJECT_NAME}"
	indexed_repos = [
    {
      "name" = "${var.JFROG_PROJECT_NAME}-demonodeapp-docker-dev-local"
      "package_type" = "Docker"
      "type" = "local"
    },
    {
      "name" = "${var.JFROG_PROJECT_NAME}-demonodeapp-docker-qa-local"
      "package_type" = "Docker"
      "type" = "local"
    },
    {
      "name" = "${var.JFROG_PROJECT_NAME}-demonodeapp-docker-prod-local"
      "package_type" = "Docker"
      "type" = "local"
    },
    {
      "name" = "${var.JFROG_PROJECT_NAME}-docker-remote"
      "package_type" = "Docker"
      "type" = "remote"
    },
    {
      "name" = "${var.JFROG_PROJECT_NAME}-demonodeapp-npm-dev-local"
      "package_type" = "Npm"
      "type" = "local"
    },
    {
      "name" = "${var.JFROG_PROJECT_NAME}-demonodeapp-npm-qa-local"
      "package_type" = "Npm"
      "type" = "local"
    },
    {
      "name" = "${var.JFROG_PROJECT_NAME}-demonodeapp-npm-prod-local"
      "package_type" = "Npm"
      "type" = "local"
    },
    {
      "name" = "${var.JFROG_PROJECT_NAME}-npm-remote"
      "package_type" = "Npm"
      "type" = "remote"
    },
    {
      "name" = "${var.JFROG_PROJECT_NAME}-payment-maven-dev-local"
      "package_type" = "Maven"
      "type" = "local"
    },
    {
      "name" = "${var.JFROG_PROJECT_NAME}-payment-maven-qa-local"
      "package_type" = "Maven"
      "type" = "local"
    },
    {
      "name" = "${var.JFROG_PROJECT_NAME}-payment-maven-prod-local"
      "package_type" = "Maven"
      "type" = "local"
    },
    {
      "name" = "${var.JFROG_PROJECT_NAME}-maven-remote"
      "package_type" = "Maven"
      "type" = "remote"
    }
  ]
}
