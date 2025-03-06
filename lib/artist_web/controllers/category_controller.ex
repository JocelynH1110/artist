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

  def edit(conn, %{"id" => id}) do
    category = Categories.get_category!(id)
    changeset = Categories.change_category(category)
    render(conn, :edit, category: category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Categories.get_category!(id)

    case Categories.update_category(category, category_params) do
      {:ok, _category} ->
        conn
        |> put_flash(:info, "分類更新成功")
        |> redirect(to: ~p"/admin/categories/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, category: category, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Categories.get_category!(id)
    render(conn, :show, category: category)
  end
end
