class SeasonsController < ApplicationController
  def index
    @seasons = Content.preload(:media, children: :media).seasons.order(created_at: :desc, id: :desc)

    if stale?(@seasons)
      render json: serialize_collection(
          @seasons,
          include: 'episodes',
          context: { include_episodes: true }
      )
    end
  end
end
