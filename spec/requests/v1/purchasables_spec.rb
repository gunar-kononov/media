require 'rails_helper'
require 'support/requests/headers'
require 'support/requests/json'
require 'support/requests/api'

module V1
  RSpec.describe '/purchasables' do
    include_context 'headers'
    include_context 'json'

    describe 'GET /index' do
      let(:records) { Array.new(count).map { create :purchasable_content } }
      let(:url) { purchasables_url(params) }

      it_behaves_like 'paginated api endpoint'
    end
  end
end
