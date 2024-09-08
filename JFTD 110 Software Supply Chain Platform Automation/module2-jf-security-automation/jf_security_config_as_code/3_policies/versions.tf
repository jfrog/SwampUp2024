terraform {
  required_version = "~> v1.8.5"

	required_providers {
    	xray = {
      		source	= "registry.terraform.io/jfrog/xray"
    	}
  	}
}