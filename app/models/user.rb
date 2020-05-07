class User < ApplicationRecord
  has_many :purchases, inverse_of: :user
  has_many :contents, through: :purchases

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
