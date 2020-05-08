class Content < ApplicationRecord
  has_many :purchases, inverse_of: :content
  has_many :users, through: :purchases
  belongs_to :media, polymorphic: true, required: true, dependent: :destroy
  belongs_to :parent, class_name: 'Content', foreign_key: :content_id, optional: true
  has_many :children, class_name: 'Content', foreign_key: :content_id, dependent: :destroy

  validates :purchasable, inclusion: { in: [true, false] }

  scope :purchasables, -> { where(purchasable: true) }
  scope :movies, -> { where(media_type: Movie.name) }
  scope :seasons, -> { where(media_type: Season.name) }
  scope :episodes, -> { where(media_type: Episode.name) }

  def jsonapi_serializer_class_name
    "#{media_type}Serializer"
  end
end
