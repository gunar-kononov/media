require 'rails_helper'

module V1
  RSpec.describe PurchasesController do
    describe 'routing' do
      it 'routes to #index' do
        expect(get: '/users/1/purchases').to route_to('v1/purchases#index', user_id: '1')
      end

      it 'routes to #create' do
        expect(post: '/users/1/purchases').to route_to('v1/purchases#create', user_id: '1')
      end
    end
  end
end
