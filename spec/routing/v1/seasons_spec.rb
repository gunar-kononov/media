require 'rails_helper'

module V1
  RSpec.describe SeasonsController do
    describe 'routing' do
      it 'routes to #index' do
        expect(get: '/seasons').to route_to('v1/seasons#index')
      end
    end
  end
end
