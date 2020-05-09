class EpisodeSerializer < ContentSerializer
  attribute :title do
    object.media.title
  end

  attribute :plot do
    object.media.plot
  end

  attribute :index do
    object.media.index
  end
end
