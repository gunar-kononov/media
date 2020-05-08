class PurchasesController < ApplicationController
  before_action :set_user

  def index

  end

  def create

  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
