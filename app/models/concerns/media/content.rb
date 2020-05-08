module Media
  module Content
    extend ActiveSupport::Concern

    included do
      has_one :content, as: :media, dependent: :destroy

      after_commit { content.try(:touch) }
    end
  end
end
