defmodule ArtistWeb.PostControllerTest do
  use ArtistWeb.ConnCase

  import Artist.PostsFixtures

  @create_attrs %{
    title: "some title",
    content: "some content",
    published_at: ~N[2025-01-19 14:50:00],
    shooting_date: ~D[2025-01-19]
  }
  @update_attrs %{
    title: "some updated title",
    content: "some updated content",
    published_at: ~N[2025-01-20 14:50:00],
    shooting_date: ~D[2025-01-20]
  }
  @invalid_attrs %{title: nil, content: nil, published_at: nil, shooting_date: nil}

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, ~p"/admin/posts")
      assert html_response(conn, 200) =~ "Listing Posts"
    end
  end

  describe "new post" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/admin/posts/new")
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "create post" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/admin/posts", post: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/admin/posts/#{id}"

      conn = get(conn, ~p"/admin/posts/#{id}")
      assert html_response(conn, 200) =~ "Post #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/admin/posts", post: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Post"
    end

    test "當給分類列表時會建立多對多關聯", %{conn: conn} do
      [first, second] = [category_fixture(), category_fixture()]
      params = @create_attrs |> Map.put(:category_ids, %{first.id => true, second.id => true})
      conn = post(conn, ~p"/admin/posts", post: params)
      # check that the post has two categories
    end
  end

  describe "edit post" do
    setup [:create_post]

    test "renders form for editing chosen post", %{conn: conn, post: post} do
      conn = get(conn, ~p"/admin/posts/#{post}/edit")
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "update post" do
    setup [:create_post]

    test "redirects when data is valid", %{conn: conn, post: post} do
      conn = put(conn, ~p"/admin/posts/#{post}", post: @update_attrs)
      assert redirected_to(conn) == ~p"/admin/posts/#{post}"

      conn = get(conn, ~p"/admin/posts/#{post}")
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, ~p"/admin/posts/#{post}", post: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, ~p"/admin/posts/#{post}")
      assert redirected_to(conn) == ~p"/admin/posts"

      assert_error_sent 404, fn ->
        get(conn, ~p"/admin/posts/#{post}")
      end
    end
  end

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end
end
