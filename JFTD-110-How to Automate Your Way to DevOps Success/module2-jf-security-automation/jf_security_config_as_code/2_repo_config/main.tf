provider "xray" {
	url             = "https://${var.JFROG_PLATFORM_URL}/xray"
	access_token    = "${var.JFROG_PLATFORM_ACCESS_TOKEN}"
}

### Sample Xray individual repository default config
# resource "xray_repository_config" "default_repo_config" {
#   repo_name   = "REPO_NAME"
#   jas_enabled = true

#   config {
#     vuln_contextual_analysis = true
#     exposures {
#       scanners_category {
#         secrets       = true
#         iac           = true
#         services      = true
#         applications  = true
#       }
#     }
#     retention_in_days = 90
#   }
# }

### Parameterized Xray repository config
resource "xray_repository_config" "default_repo" {
  for_each = toset(var.REPO_NAME_LIST)
  repo_name   = "${each.key}"
  jas_enabled = "${var.JAS_ENABLED}"

  config {
    vuln_contextual_analysis = "${var.VULN_CONTEXTUAL_ANALYSIS_STATUS}"
    exposures {
      scanners_category {
        secrets       = "${var.EXP_SCAN_SECRETS_STATUS}"
        iac           = "${var.EXP_SCAN_IAC_STATUS}"
        services      = "${var.EXP_SCAN_SERVICES_STATUS}"
        applications  = "${var.EXP_SCAN_APPLICATIONS_STATUS}"
      }
    }
    retention_in_days = "${var.XRAY_SCAN_DATA_RETENTION_DAYS}"
  }
}