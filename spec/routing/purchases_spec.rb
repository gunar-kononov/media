require 'rails_helper'

RSpec.describe PurchasesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users/1/purchases').to route_to('purchases#index', user_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/users/1/purchases').to route_to('purchases#create', user_id: '1')
    end
  end
end
