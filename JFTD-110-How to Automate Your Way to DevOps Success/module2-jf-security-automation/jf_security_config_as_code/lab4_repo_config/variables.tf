variable "JFROG_PLATFORM_URL" {
	type = string
}

variable "JFROG_PLATFORM_ACCESS_TOKEN" {
	type = string
	sensitive = true
}

variable "REPO_NAME_LIST" {
	type	=	list(string)
}

variable "JAS_ENABLED" {
	type		= bool
	default	= true
}

variable "VULN_CONTEXTUAL_ANALYSIS_STATUS" {
	type 		= bool
	default	= true
}

variable "EXP_SCAN_SECRETS_STATUS" {
	type 		= bool
	default	= true
}

variable "EXP_SCAN_IAC_STATUS" {
	type 		= bool
	default	= true
}

variable "EXP_SCAN_SERVICES_STATUS" {
	type 		= bool
	default	= true
}

variable "EXP_SCAN_APPLICATIONS_STATUS" {
	type 		= bool
	default	= true
}

variable "XRAY_SCAN_DATA_RETENTION_DAYS" {
	type 		= number
	default	= 90
}