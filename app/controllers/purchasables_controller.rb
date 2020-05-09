class PurchasablesController < ApplicationController
  def index
    @purchasables = Content.preload(:media).purchasables.order(created_at: :desc)

    if stale?(last_modified: @purchasables.maximum(:updated_at), public: true)
      render json: serialize_collection(@purchasables, url: :purchasables_url)
    end
  end
end
