class ApplicationController < ActionController::API
  def serialize_record(record, options = {})
    if record.errors.any?
      JSONAPI::Serializer.serialize_errors(record.errors)
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

  def serialize(record_or_collection, options)
    options[:jsonapi] = { version: '1.0' }
    JSONAPI::Serializer.serialize(record_or_collection, options)
  end

  def paginate(collection, options)
    url_helper = method(options.delete(:url))
    count = collection.size
    page = params.fetch(:page, {}).fetch(:number, nil) || 1
    per_page = params.fetch(:page, {}).fetch(:size, nil) || count
    paginated = collection.paginate(page: page, per_page: per_page, total_entries: count)
    options[:meta] = { total: count }
    if count == 0 || count == per_page
      options[:links] = { self: url_helper.call }
    else
      options[:links] = {
          self: url_helper.call(page: { number: paginated.current_page, size: per_page }),
          first: url_helper.call(page: { number: 1, size: per_page }),
          last: url_helper.call(page: { number: paginated.total_pages, size: per_page })
      }
      if paginated.previous_page && !paginated.out_of_bounds?
        options[:links][:prev] = url_helper.call(page: { number: paginated.previous_page, size: per_page })
      end
      if paginated.next_page && !paginated.out_of_bounds?
        options[:links][:next] = url_helper.call(page: { number: paginated.next_page, size: per_page })
      end
    end

    paginated
  end
end
