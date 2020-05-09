class MovieSerializer < ContentSerializer
  attribute :title do
    object.media.title
  end

  attribute :plot do
    object.media.plot
  end
end
