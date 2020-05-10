require 'rails_helper'
require 'support/requests/headers'
require 'support/requests/json'
require 'support/requests/api'

RSpec.describe '/movies' do
  include_context 'headers'
  include_context 'json'

  describe 'GET /index' do
    let(:records) { Array.new(count).map { create :movie_content } }
    let(:url) { movies_url(params) }

    it_behaves_like 'paginated api endpoint'
  end
end
