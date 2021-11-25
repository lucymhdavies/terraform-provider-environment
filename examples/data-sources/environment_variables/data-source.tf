provider "environment" {}

data "environment_variables" "all" {}

data "environment_variables" "regexp" {
  filter = "^LC_"
}

data "environment_variables" "encoded" {
  filter    = "TOKEN"
  sensitive = true
}

resource "null_resource" "all" {
  triggers = data.environment_variables.all.items
}

resource "null_resource" "regexp" {
  triggers = data.environment_variables.regexp.items
}

resource "null_resource" "encoded" {
  triggers = data.environment_variables.encoded.items
}
