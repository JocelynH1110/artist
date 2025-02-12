defmodule ArtistWeb.OverviewController do
  alias Artist.Posts
  use ArtistWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def show(conn, %{"slug" => slug}) do
    post = Posts.get_post_by_slug!(slug)
    render(conn, :show, post: post)
  end

  def contact(conn, _params) do
    render(conn, :contact)
  end

  def portfolio(conn, _params) do
    posts = Posts.list_posts()
    render(conn, :portfolio, posts: posts)
  end
end
