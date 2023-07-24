variable "api_key" {
  type        = string
  description = "This is IBM Cloud API Key"
}

variable "namespace" {
  type        = string
  description = "This is IBM Cloud Namespace"
}


provider "ibm" {
  ibmcloud_api_key = var.api_key
  region           = "jp-tok"
}

resource "ibm_function_action" "pyfunc" {
  name      = "template-ibm-faas-python"
  namespace = var.namespace
  publish   = true

  user_defined_annotations = <<EOF
    [
      {
        "key": "web-export",
        "value": true
      }
    ]
  EOF

  limits {
    timeout = 60000
    memory  = 256
  }

  exec {
    kind      = "python:3.11"
    code_path = "../src.zip"
  }
}


