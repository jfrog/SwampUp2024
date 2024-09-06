output "jfrog_xray_sec_policy_block_malicious_packages" {
  value = xray_security_policy.sec_policy_block_malicious_packages.rule
}

output "jfrog_xray_sec_policy_block_packages_with_cve_ids" {
  value = xray_security_policy.sec_policy_block_packages_with_cve_ids.rule
}

output "sec_policy_block_packages_with_cvss_range_critical_with_fix" {
  value = xray_security_policy.sec_policy_block_packages_with_cvss_range_critical_with_fix.rule
}

output "sec_policy_no_block_packages_with_cvss_range_high_no_fix" {
  value = xray_security_policy.sec_policy_no_block_packages_with_cvss_range_high_no_fix.rule
}

output "lic_policy_block_banned_list" {
  value = xray_license_policy.lic_policy_block_banned_list.rule
}

output "opr_risk_policy_eol_versions_upgrades" {
  value = xray_operational_risk_policy.opr_risk_policy_eol_versions_upgrades.rule
}