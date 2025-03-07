defmodule ArtistWeb.CategoryControllerTest do
  use ArtistWeb.ConnCase

  import Artist.CategoriesFixtures

  @create_attrs %{
    title: "some title",
    slug: "some-slug"
  }
  @update_attrs %{
    title: "some updated title",
    slug: "some-updated-slug"
  }
  @invalid_attrs %{title: nil}

  describe "index" do
    test "lists all notes", %{conn: conn} do
      conn = get(conn, ~p"/admin/categories")
      assert html_response(conn, 200) =~ "分類總覽"
    end
  end

  describe "new category" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/admin/categories/new")
      assert html_response(conn, 200) =~ "新增"
    end
  end

  describe "create category" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/admin/categories", category: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/admin/categories/#{id}"

      conn = get(conn, ~p"/admin/categories/#{id}")
      assert html_response(conn, 200) =~ "Category #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/admin/categories", category: @invalid_attrs)
      assert html_response(conn, 200) =~ "新增"
    end
  end

  describe "edit" do
    setup [:create_category]

    test "render form for editing chosen category", %{conn: conn, category: category} do
      conn = get(conn, ~p"/admin/categories/#{category}/edit")
      assert html_response(conn, 200) =~ "編輯分類"
    end
  end

  defp create_category(_) do
    category = category_fixture()
    %{category: category}
  end
end
