module Media
  module CacheKey
    extend ActiveSupport::Concern

    included do
      def self.cache_key
        Digest::MD5.hexdigest "#{maximum(:updated_at).try(:to_i)}-#{count}"
      end
    end
  end
end
