defmodule Artist.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Artist.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        published_at: ~N[2025-01-19 14:50:00],
        shooting_date: ~D[2025-01-19],
        title: "some title"
      })
      |> Artist.Posts.create_post()

    post
  end
end
