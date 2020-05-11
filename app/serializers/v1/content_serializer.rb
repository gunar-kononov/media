module V1
  class ContentSerializer < ApplicationSerializer
    def type
      object.media_type.downcase
    end

    attribute :title do
      object.media.title
    end

    attribute :plot do
      object.media.plot
    end

    attribute :index, if: :show_index? do
      object.media.index
    end

    has_many :episodes, include_data: true, include_links: false do
      object.children.sort_by { |object| object.media.index }
    end

    def show_index?
      %w[season episode].include?(type)
    end

    def show_episodes?
      context.fetch(:include_episodes, false) && type == 'season'
    end
  end
end
