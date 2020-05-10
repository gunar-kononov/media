require 'rails_helper'
require 'support/requests/headers'
require 'support/requests/json'
require 'support/requests/api'

RSpec.describe '/purchases' do
  include_context 'headers'
  include_context 'json'

  let(:user) { create :user }

  describe 'GET /index' do
    let(:records) { Array.new(count).map { create :purchase, user: user } }
    let(:url) { user_purchases_url(params.merge(user_id: user.id)) }

    let(:expired_purchases) { Array.new(count).map { create :expired_purchase, user: user } }
    before(:example) { expired_purchases }

    it_behaves_like 'paginated api endpoint'
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

        it_behaves_like 'api endpoint', status: :conflict, error: true

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
