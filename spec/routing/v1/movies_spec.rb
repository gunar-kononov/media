require 'rails_helper'

module V1
  RSpec.describe MoviesController do
    describe 'routing' do
      it 'routes to #index' do
        expect(get: '/movies').to route_to('v1/movies#index')
      end
    end
  end
end
