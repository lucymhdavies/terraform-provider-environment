# Terraform Provider Environment

Terraform provider able to detect environment settings.
Useful for debugging terraform running in CI.

## Test

```shell
make test
make testacc
```

## Build

Run the following command to build the provider

```shell
make build
```

## Install

```shell
make install
```

## Example

```hcl
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
```

The example code is available inside example directory.

```shell
terraform init && terraform plan
```

```shell
Terraform will perform the following actions:

  # null_resource.all will be created
  + resource "null_resource" "all" {
      + id       = (known after apply)
      + triggers = {
          + "PWD"                                 = "/terraform/terraform-provider-environment/examples"
          + "TERM"                                = "xterm-256color"
          + "SHELL"                               = "/bin/zsh"
          + "SHLVL"                               = "1"
          [...]
    }

  # null_resource.encoded will be created
  + resource "null_resource" "encoded" {
      + id       = (known after apply)
      + triggers = {
          + "TFE_TOKEN" = "ZXhhbXBsZS5hdGxhc3YxLnNlY3JldHRva2Vu"
        }
    }

  # null_resource.regexp will be created
  + resource "null_resource" "regexp" {
      + id       = (known after apply)
      + triggers = {
          + "LC_CTYPE"            = "UTF-8"
          + "LC_TERMINAL"         = "iTerm2"
          + "LC_TERMINAL_VERSION" = "3.3.11"
        }
    }

Plan: 3 to add, 0 to change, 0 to destroy.

```
