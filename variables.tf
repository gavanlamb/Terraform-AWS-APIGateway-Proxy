variable "environment" {
  type = string
  description = "Environment name"
}
variable "service" {
  type = string
  description = "Name of the service"
}
variable "api_gateway_stage" {
  type = string
  description = "Name of the API gateway stage"
  default = "api"
}
variable "lambda_function_name" {
  type = string
  description = "Name of the lambda function"
}
variable "lambda_invoke_arn" {
  type = string
  description = "Invoke arn of the lambda"
}