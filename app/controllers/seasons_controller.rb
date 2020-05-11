class SeasonsController < ApplicationController
  def index
    @seasons = Content.preload(:media, children: :media).seasons.order(created_at: :desc, id: :desc)

    paginated = paginate! @seasons

    if stale_etag?(paginated)
      render json: cache_collection(paginated, include: 'episodes', context: { include_episodes: true })
    end
  end

  private

  def original_collection
    @seasons
  end

  def cache_key_with_version
    :seasons
  end
end
