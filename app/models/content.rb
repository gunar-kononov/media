class Content < ApplicationRecord
  include Media::Cursor
  include Media::CacheKey

  has_many :purchases, inverse_of: :content
  has_many :users, through: :purchases
  belongs_to :media, polymorphic: true, required: true, dependent: :destroy
  belongs_to :parent, class_name: 'Content', foreign_key: :content_id, touch: true, optional: true
  has_many :children, class_name: 'Content', foreign_key: :content_id, dependent: :destroy

  validates :purchasable, inclusion: { in: [true, false] }

  scope :purchasables, -> { where(purchasable: true) }
  scope :movies, -> { where(media_type: Movie.name) }
  scope :seasons, -> { where(media_type: Season.name) }
  scope :episodes, -> { where(media_type: Episode.name) }
end
