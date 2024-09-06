provider "xray" {
	url             = "https://${var.JFROG_PLATFORM_URL}/xray"
	access_token    = "${var.JFROG_PLATFORM_ACCESS_TOKEN}"
}

### Xray watches for all repos
resource "xray_watch" "watch_all_repos_block_malicious_banned_license_packages" {
  name        = "watch-all-repos-block-malicious-banned-license-packages"
  description = "watch for all repos with policy - ${var.JFROG_PROJECT_NAME}-sec-policy-block-malicious-packages and ${var.JFROG_PROJECT_NAME}-lic-policy-block-banned-list"
  active      = "${var.ACTIVATE_POLICIES}"
  project_key = "${var.JFROG_PROJECT_NAME}"
  
  watch_recipients = var.EMAIL_LIST_XRAY_VIOLATION
  
  watch_resource {
    type = "all-repos"

    filter {
      type  = "regex"
      value = ".*"
    }
  }

  assigned_policy {
    name = "${var.JFROG_PROJECT_NAME}-sec-policy-block-malicious-packages"
    type = "security"
  }

  assigned_policy {
    name = "${var.JFROG_PROJECT_NAME}-lic-policy-block-banned-list"
    type = "license"
  }

}

### Xray watches for all builds
resource "xray_watch" "watch_all_builds_block_malicious_banned_license_packages" {
  name        = "watch-all-builds-block-malicious-banned-license-packages"
  description = "watch for all builds with policy - ${var.JFROG_PROJECT_NAME}-sec-policy-block-malicious-packages and ${var.JFROG_PROJECT_NAME}-lic-policy-block-banned-list"
  active      = "${var.ACTIVATE_POLICIES}"
  project_key = "${var.JFROG_PROJECT_NAME}"
  
  watch_recipients = var.EMAIL_LIST_XRAY_VIOLATION

  watch_resource {
    type = "all-builds"

    filter {
      type  = "regex"
      value = ".*"
    }
  }

  assigned_policy {
    name = "${var.JFROG_PROJECT_NAME}-sec-policy-block-malicious-packages"
    type = "security"
  }

  assigned_policy {
    name = "${var.JFROG_PROJECT_NAME}-lic-policy-block-banned-list"
    type = "license"
  }

}

### Xray watches for all release bundles
resource "xray_watch" "watch_all_rb_block_malicious_banned_license_packages" {
  name        = "watch-all-rb-block-malicious-banned-license-packages"
  description = "watch for all release bundles with policy - ${var.JFROG_PROJECT_NAME}-sec-policy-block-malicious-packages and ${var.JFROG_PROJECT_NAME}-lic-policy-block-banned-list"
  active      = "${var.ACTIVATE_POLICIES}"
  project_key = "${var.JFROG_PROJECT_NAME}"
  
  watch_recipients = var.EMAIL_LIST_XRAY_VIOLATION

  watch_resource {
    type = "all-releaseBundlesV2"
  }

  assigned_policy {
    name = "${var.JFROG_PROJECT_NAME}-sec-policy-block-malicious-packages"
    type = "security"
  }

  assigned_policy {
    name = "${var.JFROG_PROJECT_NAME}-lic-policy-block-banned-list"
    type = "license"
  }

}