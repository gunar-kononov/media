require 'rails_helper'

RSpec.describe MoviesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/movies').to route_to('movies#index')
    end
  end
end
