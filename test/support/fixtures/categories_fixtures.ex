defmodule Artist.CategoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Artist.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        title: "TV",
        slug: "tv"
      })
      |> Artist.Categories.create_category()

    category
  end
end
