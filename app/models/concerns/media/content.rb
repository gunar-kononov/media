module Media
  module Content
    extend ActiveSupport::Concern

    included do
      has_one :content, as: :media, dependent: :destroy

      after_commit { content&.touch }
    end
  end
end
