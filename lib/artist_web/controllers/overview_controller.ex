defmodule ArtistWeb.OverviewController do
  use ArtistWeb, :controller
  # alias Artist.Posts

  def index(conn, _params) do
    render(conn, :index)
  end
end
