resource "random_password" "password" {
  length           = 32
  special          = true
  override_special = "!#"
}