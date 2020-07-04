resource "aws_api_gateway_rest_api" "api" {
  name = "${var.service}-${var.environment}"
  description = "${var.service}-${var.environment} gateway"
}
resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id = aws_api_gateway_rest_api.api.root_resource_id
  path_part = "{proxy+}"
}
resource "aws_api_gateway_method" "method" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}
resource "aws_api_gateway_integration" "integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method

  # AWS lambdas can only be invoked with the POST method
  integration_http_method = "POST"
  type = "AWS_PROXY"

  uri = var.lambda_invoke_arn

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}
resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [aws_api_gateway_integration.integration]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name = var.api_gateway_stage
}
resource "aws_lambda_permission" "allow_api_gateway" {
  function_name = var.lambda_function_name
  statement_id = "AllowExecutionFromApiGateway"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"

  depends_on = [
    aws_api_gateway_rest_api.api,
    aws_api_gateway_resource.resource,
  ]
}