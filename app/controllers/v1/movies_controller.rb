module V1
  class MoviesController < ApplicationController
    def index
      @movies = Content
                    .preload(:media)
                    .movies
                    .order(created_at: :desc, id: :desc)

      paginated = paginate! @movies

      if stale_etag?(paginated)
        render json: cache_collection(
            paginated,
            serializer: ContentSerializer,
            namespace: V1
        )
      end
    end

    private

    def original_collection
      @movies
    end

    def cache_key_with_version
      [:v1, :movies]
    end
  end
end
