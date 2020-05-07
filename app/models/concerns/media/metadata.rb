require 'active_support/concern'

module Media
  module Metadata
    extend ActiveSupport::Concern

    included do
      validates :title, presence: true
      validates :plot, presence: true
    end
  end
end
