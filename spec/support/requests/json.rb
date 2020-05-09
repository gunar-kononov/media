RSpec.shared_context 'json' do
  let(:json) { ActiveSupport::JSON.decode response.body }
end
