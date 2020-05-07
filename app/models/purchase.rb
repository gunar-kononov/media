class Purchase < ApplicationRecord
  belongs_to :user, inverse_of: :purchases, required: true
  belongs_to :content, inverse_of: :purchases, required: true

  monetize :price_cents, disable_validation: true
  enum quality: { hd: 0, sd: 1 }

  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :price_currency, presence: true
  validates :quality, inclusion: { in: Purchase.qualities.keys }
end
