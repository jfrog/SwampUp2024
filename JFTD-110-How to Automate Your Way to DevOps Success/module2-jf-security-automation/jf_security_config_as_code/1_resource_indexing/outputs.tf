# output "jfrog_xray_index_repos" {
#   value = xray_binary_manager_repos.repo_index_config_default.indexed_repos
# }

output "jfrog_xray_index_builds" {
  value = xray_binary_manager_builds.build_index_config_default.indexed_builds
}