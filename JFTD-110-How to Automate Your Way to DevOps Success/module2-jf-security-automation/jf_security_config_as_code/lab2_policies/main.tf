provider "xray" {
	url             = "https://${var.JFROG_PLATFORM_URL}/xray"
	access_token    = "${var.JFROG_PLATFORM_ACCESS_TOKEN}"
}

### Security malicious packages
resource "xray_security_policy" "sec_policy_block_malicious_packages" {
  name        = "${var.JFROG_PROJECT_NAME}-sec-policy-block-malicious-packages"
  description = "Security policy to block malicious 3rd party packages that have been identified by the JFrog Security Research team."
  type        = "security"
  project_key = "${var.JFROG_PROJECT_NAME}"

  rule {
    name      = "default-rule"
    priority  = 1

    criteria {
      malicious_package = true
    }

    actions {
      block_download {
        active    = true
        unscanned = false
      }

      block_release_bundle_distribution = true
      block_release_bundle_promotion    = true
      mails                             = var.EMAIL_LIST_XRAY_VIOLATION
      fail_build                        = true
      notify_watch_recipients           = true
      notify_deployer                   = true
      webhooks                          = []
      create_ticket_enabled             = false
    } 
  }
}

### Security vulnerability IDs
resource "xray_security_policy" "sec_policy_block_packages_with_cve_ids" {
  name        = "${var.JFROG_PROJECT_NAME}-sec-policy-block-packages-with-cve-ids"
  description = "Security policy to block packages that have blacklisted CVE IDs identified."
  type        = "security"
  project_key = "${var.JFROG_PROJECT_NAME}"

  rule {
    name      = "default-rule"
    priority  = 1

    criteria {
      vulnerability_ids = var.CVE_IDS_BLOCK_LIST
    }

    actions {
      block_download {
        active    = true
        unscanned = true
      }

      block_release_bundle_distribution = true
      block_release_bundle_promotion    = true
      mails                             = var.EMAIL_LIST_XRAY_VIOLATION
      fail_build                        = true
      notify_watch_recipients           = true
      notify_deployer                   = true
      webhooks                          = []
      create_ticket_enabled             = false
    } 
  }
}

### Security cvss score critical with fix
resource "xray_security_policy" "sec_policy_block_packages_with_cvss_range_critical_with_fix" {
  name        = "${var.JFROG_PROJECT_NAME}-sec-policy-block-packages-with-cvss-range-critical-with-fix"
  description = "Security policy to block package download when components with CVSS scores 9.5 and above are identified and has a fix available."
  type        = "security"
  project_key = "${var.JFROG_PROJECT_NAME}"

  rule {
    name      = "default-rule"
    priority  = 1

    criteria {
      fix_version_dependant = true
      cvss_range {
        from  = 9.5
        to    = 10
      }
    }

    actions {
      block_download {
        active    = true
        unscanned = true
      }

      block_release_bundle_distribution = true
      block_release_bundle_promotion    = true
      mails                             = var.EMAIL_LIST_XRAY_VIOLATION
      fail_build                        = true
      notify_watch_recipients           = true
      notify_deployer                   = true
      webhooks                          = []
      create_ticket_enabled             = false
    } 
  }
}

### Security cvss score high no fix
resource "xray_security_policy" "sec_policy_no_block_packages_with_cvss_range_high_no_fix" {
  name        = "${var.JFROG_PROJECT_NAME}-sec-policy-no-block-packages-with-cvss-range-high-no-fix"
  description = "Security policy to raise violations and notifications only when package components with CVSS scores between 8.5 and 9.4 are identified with no fix."
  type        = "security"
  project_key = "${var.JFROG_PROJECT_NAME}"

  rule {
    name      = "default-rule"
    priority  = 1

    criteria {
      fix_version_dependant = false
      cvss_range {
        from  = 8.5
        to    = 9.4
      }
    }

    actions {
      block_download {
        active    = false
        unscanned = false
      }

      block_release_bundle_distribution = false
      block_release_bundle_promotion    = false
      mails                             = var.EMAIL_LIST_XRAY_VIOLATION
      fail_build                        = false
      notify_watch_recipients           = true
      notify_deployer                   = true
      webhooks                          = []
      create_ticket_enabled             = false
    } 
  }
}

### License banned list
resource "xray_license_policy" "lic_policy_block_banned_list" {
  name        = "${var.JFROG_PROJECT_NAME}-lic-policy-block-banned-list"
  description = "license policy to block download when components with banned license are identified."
  type        = "license"
  project_key = "${var.JFROG_PROJECT_NAME}"

  rule {
    name      = "default-rule"
    priority  = 1

    criteria {
      allow_unknown             = false
      multi_license_permissive  = false
      banned_licenses = var.BANNED_LICENSE_LIST
    }

    actions {
      block_download {
        active    = true
        unscanned = true
      }

      block_release_bundle_distribution = true
      block_release_bundle_promotion    = true
      mails                             = var.EMAIL_LIST_XRAY_VIOLATION
      fail_build                        = true
      notify_watch_recipients           = true
      notify_deployer                   = true
      webhooks                          = []
      create_ticket_enabled             = false
      custom_severity                   = "High"
    }
  }
}

### Operational risk OSS componentss
resource "xray_operational_risk_policy" "opr_risk_policy_eol_versions_upgrades" {
  name        = "${var.JFROG_PROJECT_NAME}-opr-risk-policy-eol-versions-upgrades"
  description = "Operational risk policy to notify only when OSS components reach end of life (EOL) or have component new version release greater than 5."
  type        = "operational_risk"
  project_key = "${var.JFROG_PROJECT_NAME}"

  rule {
    name      = "default-rule"
    priority  = 1

    criteria {
      op_risk_custom {
        use_and_condition                  = false
        is_eol                             = true
        newer_versions_greater_than        = 5
      }
    }

    actions {
      block_download {
        active    = false
        unscanned = false
      }

      block_release_bundle_distribution = false
      block_release_bundle_promotion    = false
      mails                             = var.EMAIL_LIST_XRAY_VIOLATION
      fail_build                        = false
      notify_watch_recipients           = true
      notify_deployer                   = true
      webhooks                          = []
      create_ticket_enabled             = false
    }
  }
}