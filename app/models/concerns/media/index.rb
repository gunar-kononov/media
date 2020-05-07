require 'active_support/concern'

module Media
  module Index
    extend ActiveSupport::Concern

    included do
      validates :index, presence: true, numericality: { greater_than: 0 }
    end
  end
end
