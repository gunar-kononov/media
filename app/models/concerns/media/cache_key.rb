module Media
  module CacheKey
    extend ActiveSupport::Concern

    class_methods do
      def cache_key_with_version
        # Check if data of any record in the range was updated
        updated_at = unscoped
                         .select('MAX(subquery_for_range.updated_at) AS max')
                         .from(all.select(:updated_at).arel.as('subquery_for_range')).to_a.first

        # Check if any records were added to/removed from the range
        created_at = unscoped
                         .select('MIN(subquery_for_range.created_at) AS min')
                         .select('MAX(subquery_for_range.created_at) AS max')
                         .from(all.select(:created_at).arel.as('subquery_for_range')).to_a.first
        max_id = where(created_at: created_at.max).maximum(:id)
        min_id = where(created_at: created_at.min).minimum(:id)

        "range-#{min_id}-#{max_id}-#{count}-#{updated_at.max.strftime('%Y%m%d%H%M%S%6N')}"
      end
    end
  end
end
