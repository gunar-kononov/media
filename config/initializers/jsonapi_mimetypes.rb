Mime::Type.register('application/vnd.api+json', :api_json)
ActionDispatch::Request.parameter_parsers[:api_json] = -> (body) {
  JSON.parse(body)
}
