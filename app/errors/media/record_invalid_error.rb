module Media
  class RecordInvalidError < Media::StandardError
    attr_reader :errors

    def initialize(errors:)
      @errors = errors
      super status: 409, title: 'Validation failed'
    end

    def serializable_hash
      result = []
      errors.to_hash.each do |attribute, messages|
        messages.each do |message|
          result << {
              status: status,
              title: title,
              detail: message,
              source: { pointer: "/data/attributes/#{attribute}" }
          }
        end
      end
      wrap result
    end
  end
end
