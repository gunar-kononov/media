RSpec.shared_context 'headers' do
  let :headers do
    {
        'Accept' => JSONAPI::MIMETYPE,
        'Content-Type' => JSONAPI::MIMETYPE
    }
  end
end
