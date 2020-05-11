require 'support/matchers/json_validator'

RSpec.shared_examples 'api endpoint' do |status: :success, error: false|
  it "returns http #{status}" do
    expect(response).to have_http_status(status)
  end

  it 'returns correct Content-Type' do
    expect(response.content_type).to eq(JSONAPI::MIMETYPE)
  end

  it 'returns valid json' do
    expect(response).to match_jsonapi_schema
  end

  it 'returns errors', if: error do
    expect(json['errors'].length).to be >= 1
  end
end

RSpec.shared_examples 'paginated api endpoint' do |nested: false|
  let(:count) { 3 }

  before(:example) { records }

  let(:before) { nil }
  let(:after) { nil }
  let(:size) { nil }
  let(:params) { { page: { before: before, after: after, size: size }.compact }.compact }

  let(:request) { get url, headers: headers, as: :json }

  before(:example) { request }

  include_examples 'api endpoint'

  it 'returns correct amount of records' do
    expect(json['data'].length).to be 3
  end

  it 'returns correct total amount of records' do
    expect(json['meta']['page']['total']).to be 3
  end

  it 'returns correct amount of nested records', if: nested do
    expect(json['included'].length).to be 3
  end

  context 'with pagination parameters' do
    let(:after) { records.last.cursor }
    let(:size) { 1 }

    include_examples 'api endpoint'

    it 'returns correct amount of records' do
      expect(json['data'].length).to be 1
    end

    it 'returns correct total amount of records' do
      expect(json['meta']['page']['total']).to be 3
    end

    it 'returns correct amount of nested records', if: nested do
      expect(json['included'].length).to be 1
    end

    it 'returns pagination links' do
      expect(json['links'].keys).to include('self', 'first', 'last', 'prev', 'next')
    end
  end

  context 'with invalid parameters' do
    context 'size is not an integer' do
      let(:size) { 'test' }

      include_examples 'api endpoint', status: :bad_request, error: true
    end

    context 'size is less than 1' do
      let(:size) { 0 }

      include_examples 'api endpoint', status: :bad_request, error: true
    end

    context 'after and before used simultaneously' do
      let(:before) { 'test' }
      let(:after) { 'test' }

      include_examples 'api endpoint', status: :bad_request, error: true
    end

    context 'before is an invalid cursor' do
      let(:before) { 'test' }

      include_examples 'api endpoint', status: :bad_request, error: true
    end

    context 'after is an invalid cursor' do
      let(:after) { 'test' }

      include_examples 'api endpoint', status: :bad_request, error: true
    end
  end
end
