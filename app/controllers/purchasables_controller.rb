class PurchasablesController < ApplicationController
  def index
    @purchasables = Content.preload(:media).purchasables.order(created_at: :desc, id: :desc)

    if stale?(@purchasables)
      render json: serialize_collection(@purchasables)
    end
  end
end
