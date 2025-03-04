defmodule ArtistWeb.CategoryController do
  use ArtistWeb, :controller

  plug :put_layout, html: {ArtistWeb.Layouts, :admin}

  alias Artist.Categories
  alias Artist.Categories.Category

  def index(conn, _params) do
    categories = Categories.list_categories()
    render(conn, :index, categories: categories)
  end

  def new(conn, _params) do
    changeset = Categories.change_category(%Category{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"category" => category_params}) do
    case Categories.create_category(category_params) do
      {:ok, _category} ->
        conn
        |> put_flash(:info, "分類建立完成")
        |> redirect(to: ~p"/admin/categories/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
