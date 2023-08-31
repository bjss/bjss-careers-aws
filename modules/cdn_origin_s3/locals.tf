locals {
  prefix        = "${var.identifiers.app_prefix}-${var.module}"
  bucket_prefix = "${var.identifiers.app_bucket_prefix}-${var.module}"

  default_tags = {
    Module = var.module,
  }

  file_types = {
    "txt"    = "text/plain; charset=utf-8"
    "html"   = "text/html; charset=utf-8"
    "htm"    = "text/html; charset=utf-8"
    "xhtml"  = "application/xhtml+xml"
    "css"    = "text/css; charset=utf-8"
    "js"     = "application/javascript"
    "xml"    = "application/xml"
    "json"   = "application/json"
    "jsonld" = "application/ld+json"
    "gif"    = "image/gif"
    "jpeg"   = "image/jpeg"
    "jpg"    = "image/jpeg"
    "png"    = "image/png"
    "svg"    = "image/svg+xml"
    "webp"   = "image/webp"
    "weba"   = "audio/webm"
    "webm"   = "video/webm"
    "pdf"    = "application/pdf"
    "ico"    = "image/vnd.microsoft.icon"
    "ttf"    = "font/ttf"
    "woff"   = "font/woff"
    "woff2"  = "font/woff2"
    "otf"    = "font/otf"
  }

  # The Content-Type value to use for any files that don't match one of the suffixes given in file_types
  default_file_type = "application/octet-stream"
}
