defmodule Artist.PostsTest do
  use Artist.DataCase

  alias Artist.Posts

  describe "posts" do
    alias Artist.Posts.Post

    import Artist.PostsFixtures

    @invalid_attrs %{title: nil, content: nil, published_at: nil, shooting_date: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{
        title: "some title",
        content: "some content",
        published_at: ~N[2025-01-19 14:50:00],
        shooting_date: ~D[2025-01-19]
      }

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.title == "some title"
      assert post.content == "some content"
      assert post.published_at == ~N[2025-01-19 14:50:00]
      assert post.shooting_date == ~D[2025-01-19]
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()

      update_attrs = %{
        title: "some updated title",
        content: "some updated content",
        published_at: ~N[2025-01-20 14:50:00],
        shooting_date: ~D[2025-01-20]
      }

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.title == "some updated title"
      assert post.content == "some updated content"
      assert post.published_at == ~N[2025-01-20 14:50:00]
      assert post.shooting_date == ~D[2025-01-20]
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
