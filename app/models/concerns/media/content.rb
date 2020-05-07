require 'active_support/concern'

module Media
  module Content
    extend ActiveSupport::Concern

    included do
      has_one :content, as: :media, dependent: :destroy

      after_commit(on: [:update, :destroy]) { content.touch }
    end
  end
end
