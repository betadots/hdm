# require "rspec-openapi"

RSpec::OpenAPI.info = {
  title: "HDM API v1",
  summary: "API to query hiera data from HDM"
}

RSpec::OpenAPI.security_schemes = {
  "BasicAuth" => {
    type: "http",
    scheme: "basic"
  }
}
