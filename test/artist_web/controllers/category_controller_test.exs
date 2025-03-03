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
end
