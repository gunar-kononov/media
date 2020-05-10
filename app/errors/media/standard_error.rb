module Media
  class StandardError < ::StandardError
    include ActiveModel::Serialization

    attr_reader :status, :title, :detail, :source, :links

    def initialize(status: nil, title: nil, detail: nil, source: nil, links: nil)
      @status = status.to_s || '500'
      @title = title || 'Unexpected error'
      @detail = detail || 'We encountered unexpected error, but our developers had been already notified about it'
      @source = source
      @links = links
    end

    def attributes
      {
          status: status,
          title: title,
          detail: detail,
          source: source,
          links: links
      }.compact
    end

    def serializable_hash(options = nil)
      wrap super
    end

    private

    def wrap(errors)
      { errors: Array.wrap(errors).flatten }
    end
  end
end
