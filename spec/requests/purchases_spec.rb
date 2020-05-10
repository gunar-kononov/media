require 'rails_helper'
require 'support/requests/headers'
require 'support/requests/json'
require 'support/requests/api'

RSpec.describe '/purchases' do
  include_context 'headers'
  include_context 'json'

  let(:user) { create :user }

  describe 'GET /index' do
    let(:purchases) { Array.new(10).map { create :purchase, user: user } }
    let(:expired_purchases) { Array.new(2).map { create :expired_purchase, user: user } }

    before(:example) do
      purchases
      expired_purchases
    end

    let(:request) { get user_purchases_url(user_id: user.id), headers: headers, as: :json }

    before(:example) { request }

    it_behaves_like 'api endpoint'

    it 'returns correct amount of purchases' do
      expect(json['data'].length).to be 10
    end

    context 'with pagination params' do
      let(:request) do
        get user_purchases_url(user_id: user.id, page: { after: purchases.last&.cursor, size: 2 }), headers: headers, as: :json
      end

      it_behaves_like 'paginated api endpoint'

      it 'returns correct amount of purchases' do
        expect(json['data'].length).to be 2
      end

      it 'returns correct total amount of purchases' do
        expect(json['meta']['page']['total']).to be 10
      end
    end
  end

  describe 'POST /create' do
    let(:params) do
      { data: { attributes: { content_id: content.id }.merge(attributes_for(:purchase)) } }
    end

    let(:post_request) do
      post user_purchases_url(user_id: user.id), params: params, headers: headers, as: :json
    end

    shared_examples 'creates successfully' do
      context do
        before(:example) { post_request }

        it_behaves_like 'api endpoint', status: :created

        it 'returns a purchase' do
          expect(json['data']).to be_present
        end
      end

      context do
        it 'creates a new Purchase' do
          expect { post_request }.to change(Purchase, :count).by(1)
        end
      end
    end

    shared_examples 'fails to create' do
      context do
        before(:example) { post_request }

        it_behaves_like 'api endpoint', status: :conflict

        it 'returns an error' do
          expect(json['errors']).to be_present
        end
      end

      context do
        it 'does not create a new Purchase' do
          expect { post_request }.to change(Purchase, :count).by(0)
        end
      end
    end

    context 'with valid parameters' do
      let(:content) { create :purchasable_content }

      include_examples 'creates successfully'
    end

    context 'with non-purchasable content' do
      let(:content) { create :non_purchasable_content }

      include_examples 'fails to create'
    end

    context 'with already purchased not expired content' do
      let(:content) { create :purchasable_content }

      before(:example) do
        create :purchase, user: user, content: content
      end

      include_examples 'fails to create'
    end

    context 'with already purchased expired content' do
      let(:content) { create :purchasable_content }

      before(:example) do
        create :expired_purchase, user: user, content: content
      end

      include_examples 'creates successfully'
    end
  end
end
