# Terraform AWS APIGateway Proxy
Create a Proxy API Gateway

## Variables
### Input
| Variables            | Description                               | Default |
|:---------------------|:------------------------------------------|:--------|
| environment          | Environment name                          |         |
| service              | Service name                              |         |
| api_gateway_stage    | Name of the API gateway stage             | api     |
| lambda_invoke_arn    | Invoke arn of the lambda                  |         |
| lambda_function_name | Name of the lambda function               |         |

### Output
| Variables                 | Description               |
|:--------------------------|:--------------------------|
| api_gateway_rest_api_id   | API Gateway rest API ID   |
| api_gateway_rest_api_name | API Gateway rest API name |

## How to
Specify the module source and the provider information.

### Sample
```
provider "aws" {
    region = ""
    shared_credentials_file = ""
}

module "api-gateway-proxy" {
    source = "github.com/Haplo-tech/Terraform.Module.AWS.APIGateway.Proxy"
    environment = ""
    service = ""
    api_gateway_stage = ""
    lambda_invoke_arn = ""
    lambda_function_name = ""
}
```
