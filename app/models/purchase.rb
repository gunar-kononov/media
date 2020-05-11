class Purchase < ApplicationRecord
  include Media::Cursor
  include Media::CacheKey

  EXPIRATION_DAYS = 2.freeze

  belongs_to :user, inverse_of: :purchases, required: true
  belongs_to :content, inverse_of: :purchases, required: true

  monetize :price_cents, with_currency: :eur, disable_validation: true
  enum quality: { hd: 0, sd: 1 }

  validates :content_id, uniqueness: { scope: :user_id, conditions: -> { active } }, purchasable: true, on: :create
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :price_currency, presence: true
  validates :quality, inclusion: { in: Purchase.qualities.keys }

  scope :active, -> { where(created_at: EXPIRATION_DAYS.days.ago..DateTime::Infinity.new) }
end
