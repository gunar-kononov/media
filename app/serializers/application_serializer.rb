class ApplicationSerializer
  include JSONAPI::Serializer

  # Links to #show are unavailable
  def self_link; end

  # Keep default attribute name format
  def format_name(attribute_name)
    attribute_name
  end

  # Include relationships in a document only when needed
  def relationships
    with_included_associations { super }
  end

  private

  def with_included_associations
    to_one_associations = self.class.to_one_associations.dup
    to_many_associations = self.class.to_many_associations.dup
    self.class.to_one_associations.keep_if(&method(:included?)) unless to_one_associations.nil?
    self.class.to_many_associations.keep_if(&method(:included?)) unless to_many_associations.nil?
    yield
  ensure
    self.class.to_one_associations = to_one_associations
    self.class.to_many_associations = to_many_associations
  end

  def included?(association, _)
    public_send "show_#{association}?"
  end
end
