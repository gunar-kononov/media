require 'rails_helper'
require 'support/requests/headers'
require 'support/requests/json'
require 'support/requests/api'

module V1
  RSpec.describe '/seasons' do
    include_context 'headers'
    include_context 'json'

    describe 'GET /index' do
      let(:records) { Array.new(count).map { create :season_content_with_episodes } }
      let(:url) { seasons_url(params) }

      it_behaves_like 'paginated api endpoint', nested: true
    end
  end
end
