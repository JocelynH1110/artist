defmodule Artist.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :content, :string
    field :published_at, :naive_datetime
    field :shooting_date, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :published_at, :shooting_date])
    |> validate_required([:title, :published_at, :shooting_date])
  end
end
