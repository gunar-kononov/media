class PurchasesController < ApplicationController
  before_action :set_user

  def index
    @purchases = @user.purchases.preload(content: :media).active.order(created_at: :desc, id: :desc)

    if stale?(@purchases)
      render json: serialize_collection(@purchases)
    end
  end

  def create
    @purchase = @user.purchases.new(purchase_params)
    status = @purchase.save ? :created : :conflict
    render json: serialize_record(@purchase), status: status
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def purchase_params
    params.require(:data).require(:attributes).permit(:content_id, :price, :price_currency, :quality)
  end
end
