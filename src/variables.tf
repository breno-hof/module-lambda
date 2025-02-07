variable "lambda_name" {
	description 					= "(Required) Unique name for your Lambda Function."
	type 							= string
}

variable "role_arn" {
	description 					= "(Required) Amazon Resource Name (ARN) of the function's execution role. The role provides the function's identity and access to AWS services and resources."
	type 							= string
}

variable "description" {
	description 					= "(Optional) Description of what your Lambda Function does."
	type							= string
	default 						= null
}

variable "code_signing_config_arn" {
	description 					= "(Optional) To enable code signing for this function, specify the ARN of a code-signing configuration. A code-signing configuration includes a set of signing profiles, which define the trusted publishers for this function."
	type 							= string
	default 						= null
}

variable "filename" {
	description						= " (Optional) Path to the function's deployment package within the local filesystem. Exactly one of filename, image_uri, or s3_bucket must be specified."
	type							= string
	default							= null
}

variable "image_uri" {
	description						= "(Optional) ECR image URI containing the function's deployment package. Exactly one of filename, image_uri, or s3_bucket must be specified."
	type							= string
	default							= null
}

variable "s3_bucket" {
	description						= "(Optional) S3 bucket location containing the function's deployment package. This bucket must reside in the same AWS region where you are creating the Lambda function. Exactly one of filename, image_uri, or s3_bucket must be specified. When s3_bucket is set, s3_key is required."
	type							= string
	default							= null
}

variable "is_architecture_x86_64" {
	description						= "(Optional) Instruction set architecture for your Lambda function."
	type							= bool
	default							= false
}

variable "environment_variables" {
	description						= "(Optional) Map of environment variables that are accessible from the function code during execution. If provided at least one key must be present."
	type							= optional(map())
	default							= null
}

variable "dead_letter_config" {
	description						= "(Optional) Dead letter queue configuration that specifies the queue or topic where Lambda sends asynchronous events when they fail processing."
	type							= object({
		target_arn					= string
	})
	default							= null
}

variable "ephemeral_storage_size" {
	description						= " (Optional) The amount of Ephemeral storage(/tmp) to allocate for the Lambda Function in MB. This parameter is used to expand the total amount of Ephemeral storage available, beyond the default amount of 512MB."
	type							= number
	default							= 512
}

variable "file_system_config" {
	description						= "(Optional) Connection settings for an EFS file system. Before creating or updating Lambda functions with file_system_config, EFS mount targets must be in available lifecycle state. Use depends_on to explicitly declare this dependency."
	type							= object({
		arn							= string
		local_mount_path			= string
	})
	default							= null
}

variable "kms_key_arn" {
	description						= "(Optional) Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key. If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference, remove this configuration."
	type							= string
	default							= null
}

variable "memory_size" {
	description						= "(Optional) Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128."
	type							= number
	default							= 128
}

variable "package_type" {
	description						= "(Optional) Lambda deployment package type. Valid values are Zip and Image. Defaults to Zip."
	type 							= string
	default 						= "Zip"
}

variable "image_config" {
	description 					= "(Optional) Container image configuration values that override the values in the container image Dockerfile."
	type 							= object({
		command 					= optional(list(string))
		entry_point 				= optional(list(string))
		working_directory 			= optional(list(string))
	})
	default 						= null
}

variable "logging_config" {
	description 					= "(Optional) Advanced logging settings."
	type 							= object({
		application_log_level		= optional(string)
		log_format 					= string
		log_group 					= optional(string)
		system_log_level 			= optional(string)
	})
	default 						= null
}

variable "publish" {
	description 					= "(Optional) Whether to publish creation/change as new Lambda Function Version. Defaults to false."
	type							= bool
	default 						= false
}

variable "runtime" {
	description 					= "(Optional) Identifier of the function's runtime."
	type							= string
	default							= null
}

variable "s3_key" {
	description 					= "(Optional) S3 key of an object containing the function's deployment package. When s3_bucket is set, s3_key is required."
	type							= string
	default							= null
}

variable "timeout" {
	description 					= "(Optional) Amount of time your Lambda Function has to run in seconds. Defaults to 3."
	type							= number
	default							= 3
}

variable "tags" {
	description 					= "(Optional) Map of tags to assign to the object."
	type							= map()
	default							= {}
}


variable "is_snap_start_enabled" {
	description 					= "(Optional) Snap start settings for low-latency startups. This feature is currently only supported for specific runtimes."
	type							= bool
	default							= false
}

variable "tracing_config" {
	description 					= "(Optional) Whether to sample and trace a subset of incoming requests with AWS X-Ray. Valid values are PassThrough and Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with `sampled=1`. If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision."
	type 							= object({
		mode 						= string
	})
	default 						= null
}

variable "vpc_config" {
	description 					= "(Optional) For network connectivity to AWS resources in a VPC, specify a list of security groups and subnets in the VPC. When you connect a function to a VPC, it can only access resources and the internet through that VPC."
	type							= object({
		ipv6_allowed_for_dual_stack = optional(bool)
		security_group_ids			= list(string)
		subnet_ids					= list(string)
	})
	default							= null
}

variable "handler_entrypoint" {
	description 					= "(Optional) Function entrypoint in your code."
	type 							= string
	default 						= null
}