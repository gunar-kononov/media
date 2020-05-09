class SeasonsController < ApplicationController
  def index
    @seasons = Content.preload(:media, children: :media).seasons.order(created_at: :desc)

    if stale?(last_modified: @seasons.maximum(:updated_at), public: true)
      render json: serialize_collection(
          @seasons,
          url: :seasons_url,
          include: 'episodes',
          context: { include_episodes: true }
      )
    end
  end
end
