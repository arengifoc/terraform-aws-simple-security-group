plugin "terraform" {
  enabled = true
  preset  = "all"
}

plugin "aws" {
    enabled = true
    version = "0.26.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
