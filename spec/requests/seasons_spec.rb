require 'rails_helper'
require 'support/requests/headers'
require 'support/requests/json'
require 'support/requests/api'

RSpec.describe '/seasons' do
  include_context 'headers'
  include_context 'json'

  describe 'GET /index' do
    before(:example) { Array.new(10).map { create :season_content_with_episodes } }

    let(:request) { get seasons_url, headers: headers, as: :json }

    before(:example) { request }

    it_behaves_like 'api endpoint'

    it 'returns correct amount of seasons' do
      expect(json['data'].length).to be 10
    end

    it 'returns correct amount of season episodes' do
      expect(json['included'].length).to be 30
    end

    context 'with pagination params' do
      let(:request) { get seasons_url(page: { number: 3, size: 2 }), headers: headers, as: :json }

      it_behaves_like 'paginated api endpoint'

      it 'returns correct amount of seasons' do
        expect(json['data'].length).to be 2
      end

      it 'returns correct amount of season episodes' do
        expect(json['included'].length).to be 6
      end

      it 'returns correct total amount of seasons' do
        expect(json['meta']['total']).to be 10
      end
    end
  end
end
