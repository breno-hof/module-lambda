output "aws_lambda_functio_id" {
	description	= "ID of the AWS Lambda"
	value		= aws_lambda_function.this.id
}

output "aws_lambda_functio_arn" {
	description	= "ARN of the AWS Lambda"
	value		= aws_lambda_function.this.arn
}

output "aws_lambda_functio_version" {
	description	= "Version of the AWS Lambda"
	value		= aws_lambda_function.this.version
}