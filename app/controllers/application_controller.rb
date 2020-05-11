class ApplicationController < ActionController::API
  rescue_from Media::StandardError, with: :error_response

  def serialize_record(record, options = {})
    raise Media::RecordInvalidError.new(errors: record.errors) if record.errors.any?
    options[:is_collection] = false
    serialize record, options
  end

  def serialize_collection(collection, options = {})
    options[:is_collection] = true
    collection = paginate(collection, options)
    serialize collection, options
  end

  private

  def default_page_size
    10
  end

  def paginate(collection, options)
    size, before, after = validate_params! fetch_params

    paginated = collection.limit(size || default_page_size)
    paginated = paginated.before(cursor: before).reverse_order.load.reverse if before
    paginated = paginated.after(cursor: after).load.to_a if after
    paginated.load unless before || after

    options[:meta] = { page: { total: collection.size } }
    options[:links] = {
        self: build_url(before: before, after: after, size: size ),
        first: build_url(after: collection.first_cursor, size: size ),
        last: build_url(before: collection.last_cursor, size: size )
    }

    first_cursor = paginated.first&.cursor
    if first_cursor && collection.before(cursor: first_cursor).any?
      options[:links][:prev] = build_url(before: first_cursor, size: size )
    end

    last_cursor = paginated.last&.cursor
    if last_cursor && collection.after(cursor: last_cursor).any?
      options[:links][:next] = build_url(after: last_cursor, size: size )
    end

    paginated
  end

  def page_params
    params.permit(page: [:size, :before, :after])
  end

  def fetch_params
    page_params.fetch(:page, {}).values_at(:size, :before, :after)
  end

  def validate_params!(params)
    size, before, after = params

    if !size.nil? && Integer(size, 10) <= 0
      raise Media::PaginationError.new(parameter: 'page[size]', detail: 'must be greater than 0')
    end

    raise Media::RangePaginationError unless before.nil? || after.nil?

    params
  rescue TypeError, ArgumentError
    raise Media::PaginationError.new(parameter: 'page[size]', detail: 'must be an integer')
  end

  def serialize(record_or_collection, options)
    options[:jsonapi] = { version: '1.0' }
    JSONAPI::Serializer.serialize(record_or_collection, options)
  end

  def error_response(error)
    render json: error.serializable_hash, status: error.status
  end

  def build_url(params = {})
    params = params.compact
    url = request.path
    url << "?#{URI::unescape({ page: params }.to_query)}" if params.any?
    url
  end
end
