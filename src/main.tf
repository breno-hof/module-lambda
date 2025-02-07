resource "aws_lambda_function" "this" {
	function_name						= var.lambda_name
	description							= var.description
	role								= var.role_arn
	handler								= var.handler_entrypoint

	architectures						= var.is_architecture_x86_64 ? ["x86_64"] : ["arm64"]

	code_signing_config_arn				= var.code_signing_config_arn

	filename							= local.is_filename_set ? var.filename : null
	image_uri							= local.is_image_uri_set ? var.image_uri : null
	s3_bucket							= local.is_s3_bucket_set ? var.s3_bucket : null
	s3_key								= local.is_s3_bucket_set ? var.s3_key : null

	source_code_hash					= local.is_filename_set ? filebase64sha256(var.filename) : (local.is_image_uri_set ? filebase64sha256(file(var.s3_key)) : null) 

	kms_key_arn							= var.kms_key_arn

	memory_size							= var.memory_size
	package_type						= var.package_type == "Zip" ? "Zip" : "Image"

	publish								= var.publish

	runtime								= var.runtime

	timeout								= var.timeout 
	tags								= var.tags

	dynamic "dead_letter_config" {
		for_each						= var.dead_letter_config != null ? [1] : []

		content {
			target_arn					= var.dead_letter_config.target_arn
		}
	}

	dynamic "environment" {
		for_each						= var.environment_variables != null ? [1] : []

		content {
			variables					= var.environment_variables
		}
	}

	dynamic "ephemeral_storage" {
		for_each						= var.ephemeral_storage_size != null ? [1] : []

		content {
			size						= var.ephemeral_storage_size >= 512 && var.ephemeral_storage_size <= 10240 ? var.ephemeral_storage_size : 512 
		}
	}

	dynamic "file_system_config" {
		for_each						= var.file_system_config != null ? [1] : []

		content {
			arn							= var.file_system_config.arn
			local_mount_path			= var.file_system_config.local_mount_path
		}
	}

	dynamic "image_config" {
		for_each						= var.image_config != null ? [1] : []

		content {
			command						= var.image_config.command
			entry_point					= var.image_config.entry_point
			working_directory			= var.image_config.working_directory
		}
	}

	dynamic "logging_config" {
		for_each						= var.logging_config != null ? [1] : []

		content {
			application_log_level		= var.logging_config.application_log_level
			log_format					= var.logging_config.log_format
			log_group					= var.logging_config.log_group
			system_log_level			= var.logging_config.system_log_level
		}
	}

	dynamic "snap_start" {
		for_each						= var.is_snap_start_enabled ? [1] : []

		content {
			apply_on					= "PublishedVersions"
		}
	}

	dynamic "tracing_config" {
		for_each						= var.tracing_config != null ? [1] : []

		content {
			mode						= var.tracing_config.mode == "PassThrough" ? "PassThrough" : "Active"
		}
	}

	dynamic "vpc_config" {
		for_each						= var.vpc_config != null ? [1] : []

		content {
			ipv6_allowed_for_dual_stack = var.vpc_config.ipv6_allowed_for_dual_stack
			security_group_ids			= var.vpc_config.security_group_ids
			subnet_ids					= var.vpc_config.subnet_ids
		}
	}
}