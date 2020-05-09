class MoviesController < ApplicationController
  def index
    @movies = Content.preload(:media).movies.order(created_at: :desc)

    if stale?(@movies, public: true)
      render json: serialize_collection(@movies, url: :movies_url)
    end
  end
end
