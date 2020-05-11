class PurchasablesController < ApplicationController
  def index
    @purchasables = Content.preload(:media).purchasables.order(created_at: :desc, id: :desc)

    paginated = paginate! @purchasables

    render json: cache_collection(paginated) if stale_etag?(paginated)
  end

  private

  def original_collection
    @purchasables
  end

  def cache_key_with_version
    :purchasables
  end
end
