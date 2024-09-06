provider "xray" {
	url             = "https://${var.JFROG_PLATFORM_URL}/xray"
	access_token    = "${var.JFROG_PLATFORM_ACCESS_TOKEN}"
}

resource "xray_binary_manager_repos" "repo_index_config_default" {
	id					  = "default"
  project_key   = "${var.JFROG_PROJECT_NAME}"
	indexed_repos = [
    {
      "name" = "frogs-docker-dev-local"
      "type" = "local"
      "package_type" = "Docker"
    },
    {
      "name" = "frogs-docker-dev-remote"
      "type" = "remote"
      "package_type" = "Docker"
    }
  ]

  lifecycle {
    ignore_changes = [
      project_key
    ]
  }
}