class ContentSerializer < ApplicationSerializer
  def type
    object.media_type.downcase
  end
end
