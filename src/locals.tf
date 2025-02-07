locals {
	is_filename_set			= !var.should_create_s3 && var.filename != null && var.image_uri == null && var.s3_bucket == null
	is_image_uri_set		= !var.should_create_s3 && var.image_uri != null && !local.is_filename_set
	is_s3_bucket_set		= !var.should_create_s3 && var.s3_bucket != null && !local.is_image_uri_set

	files					= fileset(var.source_path, "**")
	runtime					= contains(local.files, "package.json") ? "nodejs" : contains(local.files, "requirements.txt") ? "python" : contains(local.files, "pom.xml") ? "java" : "unknown"

	deployment_package_dir	= "../deployment-package"
}