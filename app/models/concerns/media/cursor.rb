module Media
  module Cursor
    extend ActiveSupport::Concern

    included do
      # Assumes descending order
      scope :before, -> (cursor:) do
        timestamp, id = parse_cursor cursor, :before

        equal_timestamps = arel_table[:created_at].eq(timestamp)
        prev_timestamps = arel_table[:created_at].gt(timestamp)
        prev_ids = arel_table[:id].gt(id)

        result = where equal_timestamps.and(prev_ids)
        result = where(prev_timestamps).or result
        result
      end

      # Assumes descending order
      scope :after, -> (cursor:) do
        timestamp, id = parse_cursor cursor, :after

        equal_timestamps = arel_table[:created_at].eq(timestamp)
        next_timestamps = arel_table[:created_at].lt(timestamp)
        next_ids = arel_table[:id].lt(id)

        result = where equal_timestamps.and(next_ids)
        result = where(next_timestamps).or result
        result
      end

      delegate :encode_cursor, to: :class

      def cursor
        encode_cursor created_at, id
      end
    end

    class_methods do
      # Assumes descending order
      def first_cursor
        encode_cursor Time.now, 1
      end

      # Assumes descending order
      def last_cursor
        encode_cursor Time.at(0), 1
      end

      def encode_cursor(timestamp, id)
        timestamp.strftime('%Y-%m-%d %H:%M:%S.%6N').unpack('H*').first + id.to_s(16)
      end

      def parse_cursor(cursor, param)
        # Raises Date::Error
        timestamp = [cursor[0..51]].pack('H*').to_datetime

        # Raises TypeError, ArgumentError
        id = Integer(cursor[52..], 16)
      rescue TypeError, ArgumentError, Date::Error
        raise Media::PaginationError.new(parameter: "page[#{param}]", detail: 'is invalid')
      else
        [timestamp, id]
      end
    end
  end
end
