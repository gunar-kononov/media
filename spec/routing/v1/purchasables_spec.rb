require 'rails_helper'

module V1
  RSpec.describe PurchasablesController do
    describe 'routing' do
      it 'routes to #index' do
        expect(get: '/purchasables').to route_to('v1/purchasables#index')
      end
    end
  end
end
