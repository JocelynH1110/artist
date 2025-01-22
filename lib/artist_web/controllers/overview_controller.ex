defmodule ArtistWeb.OverviewController do
  alias Artist.Posts
  use ArtistWeb, :controller
  # alias Artist.Posts

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, :index, posts: posts)
  end

  def show(conn, %{"slug" => id}) do
    post = Posts.get_post!(id)
    # post = Repo.get!(Posts, id)
    render(conn, :show, post: post)
  end
end
