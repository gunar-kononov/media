require 'rails_helper'

RSpec.describe MoviesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/movies').to route_to('movies#index')
    end
  end
end
