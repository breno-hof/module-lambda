# Lambda Function Module

This module provides a scalable and secure AWS Lambda function that integrates seamlessly with other AWS services, such as DynamoDB, API Gateway, and S3. It is designed to handle event-driven tasks, process data, and trigger other AWS resources based on specific events.

## Features

- **Scalability**: Automatically scales with the number of incoming events, ensuring high availability and performance.
- **Customizable IAM Roles**: Provides fine-grained control over permissions, ensuring secure access to AWS resources.
- **Environment Variables**: Supports the use of environment variables for configuration, making it easy to manage different environments (e.g., development, staging, production).

## Usage

To use this module, you need to define the necessary variables and integrate it with your existing AWS infrastructure. Below is an example of how to use the module in your Terraform configuration:

```hcl

locals {
	lambda_name			= "pool-registry"
	handler_entrypoint	= "lambda.lambda_handler"
	timeout				= 300
	runtime				= "python3.8"
	source_path			= "../src"
	output_path			= "../${local.lambda_name}"
}

module "lambda" {
    source					= "../../module-lambda/src"

    is_architecture_x86_64 	= true

    lambda_name				= local.lambda_name

    handler_entrypoint		= local.handler_entrypoint
    runtime					= local.runtime

    source_path				= local.source_path
}
```
## Input Variables
| **Variable**                  | **Description**                                                                                                                                                        | **Type**            | **Default** |
|-------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------|-------------|
| `lambda_name`                  | (Required) Unique name for your Lambda Function.                                                                                                                        | string              | -           |
| `role_arn`                     | (Required) Amazon Resource Name (ARN) of the function's execution role. The role provides the function's identity and access to AWS services and resources.            | string              | null        |
| `description`                  | (Optional) Description of what your Lambda Function does.                                                                                                               | string              | null        |
| `source_code_hash`             | (Optional)                                                                                                      | string              | null        |
| `source_path`                  | Source path of your Lambda Function file.                                                                                                                               | string              | `.`         |
| `should_create_role`           | (Optional) Whether to create role or not. Default true.                                                                                                               | bool                | true        |
| `should_create_s3`             | (Optional) Whether to create s3 bucket or not. Default true.                                                                                                          | bool                | true        |
| `code_signing_config_arn`      | (Optional) To enable code signing for this function, specify the ARN of a code-signing configuration.                                                                 | string              | null        |
| `filename`                     | (Optional) Path to the function's deployment package within the local filesystem.                                                                                      | string              | null        |
| `image_uri`                    | (Optional) ECR image URI containing the function's deployment package.                                                                                                 | string              | null        |
| `s3_bucket`                    | (Optional) S3 bucket location containing the function's deployment package.                                                                                             | string              | null        |
| `is_architecture_x86_64`       | (Optional) Instruction set architecture for your Lambda function.                                                                                                      | bool                | false       |
| `environment_variables`        | (Optional) Map of environment variables that are accessible from the function code during execution.                                                                  | map(string)         | null        |
| `dead_letter_config`           | (Optional) Dead letter queue configuration.                                                                                                                             | object              | null        |
| `ephemeral_storage_size`       | (Optional) The amount of Ephemeral storage(/tmp) to allocate for the Lambda Function in MB.                                                                           | number              | 512         |
| `file_system_config`           | (Optional) Connection settings for an EFS file system.                                                                                                                  | object              | null        |
| `kms_key_arn`                  | (Optional) Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key used to encrypt environment variables.                                              | string              | null        |
| `memory_size`                  | (Optional) Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128.                                                                            | number              | 128         |
| `package_type`                 | (Optional) Lambda deployment package type. Valid values are Zip and Image. Defaults to Zip.                                                                          | string              | Zip         |
| `image_config`                 | (Optional) Container image configuration values that override the values in the container image Dockerfile.                                                            | object              | null        |
| `logging_config`               | (Optional) Advanced logging settings.                                                                                                                                     | object              | null        |
| `publish`                      | (Optional) Whether to publish creation/change as new Lambda Function Version. Defaults to false.                                                                     | bool                | false       |
| `runtime`                      | (Optional) Identifier of the function's runtime.                                                                                                                        | string              | null        |
| `s3_key`                       | (Optional) S3 key of an object containing the function's deployment package.                                                                                           | string              | null        |
| `timeout`                      | (Optional) Amount of time your Lambda Function has to run in seconds. Defaults to 3.                                                                                  | number              | 3           |
| `tags`                         | (Optional) Map of tags to assign to the object.                                                                                                                          | map(string)         | `{}`        |
| `is_snap_start_enabled`        | (Optional) Snap start settings for low-latency startups. This feature is currently only supported for specific runtimes.                                               | bool                | false       |
| `tracing_config`               | (Optional) Whether to sample and trace a subset of incoming requests with AWS X-Ray.                                                                                   | object              | null        |
| `vpc_config`                   | (Optional) For network connectivity to AWS resources in a VPC, specify a list of security groups and subnets in the VPC.                                               | object              | null        |
| `handler_entrypoint`           | (Optional) Function entrypoint in your code.                                                                                                                             | string              | null        |

## Outputs

| **Output**                     | **Description**                                    | **Value**                                                    |
|---------------------------------|----------------------------------------------------|--------------------------------------------------------------|
| `aws_lambda_functio_name`       | Name of the AWS Lambda                             | `aws_lambda_function.this.function_name`                     |
| `aws_lambda_functio_arn`        | ARN of the AWS Lambda                              | `aws_lambda_function.this.arn`                               |
| `aws_lambda_functio_version`    | Version of the AWS Lambda                          | `aws_lambda_function.this.version`                           |
| `aws_iam_role_id`               | ID of the default IAM role                         | `var.should_create_role ? aws_iam_role.this[0].id : null`     |
| `aws_s3_bucket_name`            | Name of the default S3 bucket                      | `var.should_create_s3 ? aws_s3_bucket.this[0].bucket : null` |

## Example Use Cases
Data Processing: Process data from an S3 bucket and store the results in DynamoDB.

Real-Time Notifications: Trigger notifications via SNS or SQS when specific events occur in DynamoDB.

API Backend: Serve as a backend for an API Gateway, handling HTTP requests and returning responses.

## Requirements
Terraform v0.12 or higher.

AWS provider v3.0 or higher.

## License
This module is licensed under the GNU General Public License. See the LICENSE file for more details.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.