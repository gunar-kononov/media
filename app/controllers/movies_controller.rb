class MoviesController < ApplicationController
  def index
    @movies = Content.preload(:media).movies.order(created_at: :desc, id: :desc)

    paginated = paginate! @movies

    render json: cache_collection(paginated) if stale_etag?(paginated)
  end
  
  private

  def original_collection
    @movies
  end

  def cache_key_with_version
    :movies
  end
end
