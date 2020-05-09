class PurchasablesController < ApplicationController
  def index
    @purchasables = Content.preload(:media).purchasables.order(created_at: :desc)

    if stale?(@purchasables, public: true)
      render json: serialize_collection(@purchasables, url: :purchasables_url)
    end
  end
end
