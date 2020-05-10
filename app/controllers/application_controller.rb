class ApplicationController < ActionController::API
  def serialize_record(record, options = {})
    if record.errors.any?
      error(record.errors)
    else
      options[:is_collection] = false
      serialize record, options
    end
  end

  def serialize_collection(collection, options = {})
    options[:is_collection] = true
    collection = paginate(collection, options)
    serialize collection, options
  end

  private

  def paginate(collection, options)
    size, before, after = params.fetch(:page, {}).values_at(:size, :before, :after)

    raise if size.to_i < 0
    raise if before && after

    paginated = collection.limit(size || 10)
    paginated = paginated.before(cursor: before) if before
    paginated = paginated.after(cursor: after) if after

    options[:meta] = { page: { total: collection.size } }
    options[:links] = {
        self: build_url(before: before, after: after, size: size ),
        first: build_url(after: collection.first_cursor, size: size ),
        last: build_url(before: collection.last_cursor, size: size )
    }

    first_cursor = paginated.first.cursor
    if first_cursor && collection.before(cursor: first_cursor).any?
      options[:links][:prev] = build_url(before: first_cursor, size: size )
    end

    last_cursor = paginated.last.cursor
    if last_cursor && collection.after(cursor: last_cursor).any?
      options[:links][:next] = build_url(after: last_cursor, size: size )
    end

    paginated
  end

  def serialize(record_or_collection, options)
    options[:jsonapi] = { version: '1.0' }
    JSONAPI::Serializer.serialize(record_or_collection, options)
  end

  def error(error)
    JSONAPI::Serializer.serialize_errors(error)
  end

  def build_url(params = {})
    params = params.compact
    url = request.base_url + request.path
    url << "?#{URI::unescape({ page: params }.to_query)}" if params.any?
    url
  end
end
