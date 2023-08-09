data "archive_file" "source_zip" {
  type        = "zip"
  source_dir  = var.lambda_options.source_directory
  output_path = "${path.module}/dist/${var.lambda_options.function_name}.zip"
}
