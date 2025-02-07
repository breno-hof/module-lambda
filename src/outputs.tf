output "aws_lambda_functio_name" {
	description	= "Name of the AWS Lambda"
	value		= aws_lambda_function.this.function_name
}

output "aws_lambda_functio_arn" {
	description	= "ARN of the AWS Lambda"
	value		= aws_lambda_function.this.arn
}

output "aws_lambda_functio_version" {
	description	= "Version of the AWS Lambda"
	value		= aws_lambda_function.this.version
}

output "aws_iam_role_id" {
	description = "ID of the default IAM role"
	value		= var.should_create_role ? aws_iam_role.this[0].id : null
}

output "aws_s3_bucket_name" {
	description = "Name of the default S3 bucket"
	value		= var.should_create_s3 ? aws_s3_bucket.this[0].bucket : null
}
