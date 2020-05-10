class MoviesController < ApplicationController
  def index
    @movies = Content.preload(:media).movies.order(created_at: :desc, id: :desc)

    if stale?(@movies)
      render json: serialize_collection(@movies)
    end
  end
end
