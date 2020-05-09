require 'support/matchers/json_validator'

RSpec.shared_examples 'api endpoint' do |status: :success|
  it "returns http #{status}" do
    expect(response).to have_http_status(status)
  end

  it 'returns correct Content-Type' do
    expect(response.content_type).to eq(JSONAPI::MIMETYPE)
  end

  it 'returns valid json' do
    expect(response).to match_jsonapi_schema
  end
end

RSpec.shared_examples 'paginated api endpoint' do
  include_examples 'api endpoint'

  it 'returns pagination links' do
    expect(json['links'].keys).to include('self', 'first', 'last', 'prev', 'next')
  end
end
