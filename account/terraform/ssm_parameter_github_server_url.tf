resource "aws_ssm_parameter" "github_server_url" {
  name        = "${local.prefix}-github-server-url"
  description = "Initial placeholder value should be manually overwritten"
  type        = "SecureString"
  value       = "placeholder-manually-replace-with-real-key"
  overwrite   = true

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}
