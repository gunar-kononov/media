module Media
  class RangePaginationError < Media::StandardError
    def initialize
      super(
          status: 400,
          title: 'Range Pagination Not Supported',
          detail: 'page[before] and page[after] can not be used simultaneously',
          links: { type: 'https://jsonapi.org/profiles/ethanresnick/cursor-pagination/range-pagination-not-supported' }
      )
    end
  end
end
