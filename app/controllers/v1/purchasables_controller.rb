module V1
  class PurchasablesController < ApplicationController
    def index
      @purchasables = Content
                          .preload(:media)
                          .purchasables
                          .order(created_at: :desc, id: :desc)

      paginated = paginate! @purchasables

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
      @purchasables
    end

    def cache_key_with_version
      [:v1, :purchasables]
    end
  end
end
