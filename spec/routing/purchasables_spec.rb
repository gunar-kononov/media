require 'rails_helper'

RSpec.describe PurchasablesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/purchasables').to route_to('purchasables#index')
    end
  end
end
