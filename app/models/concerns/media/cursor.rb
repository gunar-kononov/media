module Media
  module Cursor
    extend ActiveSupport::Concern

    class_methods do
      # Assumes descending order
      def before(cursor:)
        timestamp, id = parse_cursor cursor

        equal_timestamps = arel_table[:created_at].eq(timestamp)
        prev_timestamps = arel_table[:created_at].gt(timestamp)
        prev_ids = arel_table[:id].gt(id)

        where(prev_timestamps).or(where(equal_timestamps.and(prev_ids))).reverse_order.load.reverse
      end

      # Assumes descending order
      def after(cursor:)
        timestamp, id = parse_cursor cursor

        equal_timestamps = arel_table[:created_at].eq(timestamp)
        next_timestamps = arel_table[:created_at].lt(timestamp)
        next_ids = arel_table[:id].lt(id)

        where(next_timestamps).or(where(equal_timestamps.and(next_ids))).load
      end

      # Assumes descending order
      def first_cursor
        encode_cursor Time.now, 1
      end

      # Assumes descending order
      def last_cursor
        encode_cursor Time.at(0), 1
      end

      def encode_cursor(timestamp, id)
        Base64.strict_encode64("#{timestamp.strftime('%Y-%m-%d %H:%M:%S.%6N')};#{id}")
      end

      def parse_cursor(cursor)
        timestamp, id = Base64.strict_decode64(cursor).split(';')
        [timestamp.to_datetime, id.to_i]
      end
    end

    included do
      delegate :encode_cursor, to: :class

      def cursor
        encode_cursor created_at, id
      end
    end
  end
end
