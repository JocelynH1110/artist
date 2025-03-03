defmodule ArtistWeb.CategoryController do
  use ArtistWeb, :controller

  plug :put_layout, html: {ArtistWeb.Layouts, :admin}

  alias Artist.Categories
  alias Artist.Categories.Category

  def index(conn, _params) do
    categories = Categories.list_categories()
    render(conn, :index, categories: categories)
  end
end
