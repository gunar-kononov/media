class PurchaseSerializer < ApplicationSerializer
  def id
    object.content_id.to_s
  end

  def type
    object.content.media_type.downcase
  end

  attribute :title do
    object.content.media.title
  end

  attribute :plot do
    object.content.media.plot
  end

  attribute :index, if: :show_index? do
    object.content.media.index
  end

  attributes :quality, :price_cents, :price_currency

  def show_index?
    type == 'season'
  end
end
