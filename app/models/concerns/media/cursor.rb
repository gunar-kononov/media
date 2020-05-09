module Media
  module Cursor
    extend ActiveSupport::Concern

    class_methods do
      def cursor(cursor)
        cursor
      end

      def prev(number)
        number
      end

      def next(number)
        number
      end
    end
  end
end
