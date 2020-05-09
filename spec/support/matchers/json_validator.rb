RSpec::Matchers.define :match_jsonapi_schema do
  match do |response|
    JSON::Validator.validate!("#{Dir.pwd}/spec/support/schemas/jsonapi.json", response.body)
  end
end
