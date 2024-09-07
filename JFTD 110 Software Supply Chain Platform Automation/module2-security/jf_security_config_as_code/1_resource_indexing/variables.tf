variable "JFROG_PLATFORM_URL" {
	type = string
}

variable "JFROG_PLATFORM_ACCESS_TOKEN" {
	type = string
	sensitive = true
}

variable "JFROG_PROJECT_NAME" {
	type = string
}

variable "BUILDS_INDEX_LIST" {
	type = list(string)
}