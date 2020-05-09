require 'rails_helper'
require 'support/requests/headers'
require 'support/requests/json'
require 'support/requests/api'

RSpec.describe '/purchasables' do
  include_context 'headers'
  include_context 'json'

  describe 'GET /index' do
    before(:example) do
      Array.new(10).map { create :purchasable_content }
    end

    let(:request) { get purchasables_url, headers: headers, as: :json }

    before(:example) { request }

    it_behaves_like 'api endpoint'

    it 'returns correct amount of purchasables' do
      expect(json['data'].length).to be 10
    end

    context 'with pagination params' do
      let(:request) { get purchasables_url(page: { number: 3, size: 2 }), headers: headers, as: :json }

      it_behaves_like 'paginated api endpoint'

      it 'returns correct amount of purchasables' do
        expect(json['data'].length).to be 2
      end

      it 'returns correct total amount of purchasables' do
        expect(json['meta']['total']).to be 10
      end
    end
  end
end
