defmodule Artist.PostCategories.PostCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post_categories" do
    belongs_to :post, Artist.Posts.Post
    belongs_to :category, Artist.Categories.Category

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post_categories, attrs) do
    post_categories
    |> cast(attrs, [:post_id, :category_id])
    |> validate_required([:post_id, :category_id])
    |> unique_constraint([:post_id, :category_id])
    |> foreign_key_constraint(:post_id)
    |> foreign_key_constraint(:categort_id)
  end
end
