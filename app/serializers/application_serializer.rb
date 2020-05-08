class ApplicationSerializer
  include JSONAPI::Serializer

  def self_link; end

  def type
    object.media_type.downcase
  end
end
