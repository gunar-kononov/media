class ApplicationController < ActionController::API
  rescue_from Media::StandardError, with: :error_response

  def paginate!(collection)
    size, before, after = validate_params!
    paginated = collection.limit(size || default_page_size).before(cursor: before).after(cursor: after)
    paginated = paginated.reverse_order if before
    paginated
  end

  def cache_collection(collection, options = {})
    Rails.cache.fetch(cache_key(collection), expires_in: 24.hours) do
      serialize_collection collection, options
    end
  end

  def stale_etag?(collection)
    stale?(etag: cache_key(collection))
  end

  def serialize_record(record, options = {})
    raise Media::RecordInvalidError.new(errors: record.errors) if record.errors.any?
    options[:is_collection] = false
    serialize record, options
  end

  def serialize_collection(collection, options = {})
    loaded = load_collection collection
    options = build_pagination_data(loaded).merge(options)
    options[:is_collection] = true
    serialize loaded, options
  end

  private

  def default_page_size
    10
  end

  def cache_key(collection)
    @cache_key ||= ActiveSupport::Cache.expand_cache_key([*cache_key_with_version, collection.model_name, collection])
  end

  def serialize(record_or_collection, options)
    options[:jsonapi] = { version: '1.0' }
    JSONAPI::Serializer.serialize(record_or_collection, options)
  end

  def error_response(error)
    render json: error.serializable_hash, status: error.status
  end

  def load_collection(collection)
    loaded = collection.load
    loaded = loaded.reverse if before_param
    loaded
  end

  def build_pagination_data(paginated)
    first_cursor = paginated.first&.cursor
    last_cursor = paginated.last&.cursor
    options = {}
    options[:meta] = { page: { total: original_collection.size } }
    options[:links] = {
        self: path_to_self,
        first: path_to_after(original_collection.first_cursor),
        last: path_to_before(original_collection.last_cursor)
    }
    options[:links][:prev] = path_to_before(first_cursor) if prev_range_exists?(original_collection, first_cursor)
    options[:links][:next] = path_to_after(last_cursor) if next_range_exists?(original_collection, last_cursor)
    options
  end

  def prev_range_exists?(collection, cursor)
    cursor && collection.before(cursor: cursor).any?
  end

  def next_range_exists?(collection, cursor)
    cursor && collection.after(cursor: cursor).any?
  end

  def path_to_self
    build_path before: before_param, after: after_param, size: size_param
  end

  def path_to_before(cursor)
    build_path before: cursor, size: size_param
  end

  def path_to_after(cursor)
    build_path after: cursor, size: size_param
  end

  def build_path(params = {})
    params = params.compact
    url = request.path
    url << "?#{URI::unescape({ page: params }.to_query)}" if params.any?
    url
  end

  def page_params
    params.permit(page: [:size, :before, :after])
  end

  def fetch_params
    page_params.fetch(:page, {}).values_at(:size, :before, :after)
  end

  def validate_params!
    size, before, after = params = fetch_params

    if !size.nil? && Integer(size, 10) <= 0
      raise Media::PaginationError.new(parameter: 'page[size]', detail: 'must be greater than 0')
    end

    raise Media::RangePaginationError unless before.nil? || after.nil?

    params
  rescue TypeError, ArgumentError
    raise Media::PaginationError.new(parameter: 'page[size]', detail: 'must be an integer')
  end

  def size_param
    size, _, _ = fetch_params
    size
  end

  def before_param
    _, before, _ = fetch_params
    before
  end

  def after_param
    _, _, after = fetch_params
    after
  end
end
