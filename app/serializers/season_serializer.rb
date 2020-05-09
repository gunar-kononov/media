class SeasonSerializer < ContentSerializer
  attribute :title do
    object.media.title
  end

  attribute :plot do
    object.media.plot
  end

  attribute :index do
    object.media.index
  end

  has_many :episodes, include_data: true, include_links: false do
    object.children.sort_by { |object| object.media.index }
  end
end
