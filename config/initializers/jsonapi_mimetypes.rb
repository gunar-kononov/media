module JSONAPI
  MIMETYPE = "application/vnd.api+json"
end

Mime::Type.register JSONAPI::MIMETYPE, :json, %W(
  application/json
  application/jsonrequest
  text/x-json
)
