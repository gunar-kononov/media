module Media
  class PaginationError < Media::StandardError
    def initialize(parameter:, detail:)
      super(
          status: 400,
          title: 'Invalid Parameter',
          detail: "#{parameter} #{detail}",
          source: { parameter: parameter }
      )
    end
  end
end
