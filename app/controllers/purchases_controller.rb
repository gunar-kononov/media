class PurchasesController < ApplicationController
  before_action :set_user

  def index
    @purchases = @user.purchases.preload(content: :media).active.order(created_at: :desc, id: :desc)

    paginated = paginate! @purchases

    render json: cache_collection(paginated) if stale_etag?(paginated)
  end

  def create
    @purchase = @user.purchases.create(purchase_params)
    render json: serialize_record(@purchase), status: :created
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def purchase_params
    params.require(:data).require(:attributes).permit(:content_id, :price, :price_currency, :quality)
  end

  def original_collection
    @purchases
  end

  def cache_key_with_version; end
end
