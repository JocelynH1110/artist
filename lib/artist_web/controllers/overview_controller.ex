defmodule ArtistWeb.OverviewController do
  alias Artist.Posts
  use ArtistWeb, :controller
  # alias Artist.Posts

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, :index, posts: posts)
  end

  def show(conn, %{"slug" => slug}) do
    post = Posts.get_post_by_slug!(slug)

    render(conn, :show, post: post)
  end
end
