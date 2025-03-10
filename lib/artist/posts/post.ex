defmodule Artist.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :slug}

  schema "posts" do
    field :title, :string
    field :content, :string
    field :published_at, :naive_datetime
    field :shooting_date, :date
    field :slug, :string
    field :photo, :string, default: ""

    # 直接關聯到中間表
    has_many :post_categories, Artist.PostCategories.PostCategory
    # 通過中間表關聯到分類
    has_many :categories, through: [:post_categories, :category]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :published_at, :shooting_date, :slug])
    |> validate_required([:title, :shooting_date])
    |> validate_format(:slug, ~r/^[a-z0-9]+(?:-[a-z0-9]+)*$/)
    |> maybe_generate_slug()
    |> unique_constraint(:slug)
  end

  # 產生一個 slug, 若 changeset 值通過檢驗，會進入這個函式，若 slug 是空的，轉換 title 為 slug。反之，直接傳回去。
  defp maybe_generate_slug(%Ecto.Changeset{valid?: true} = changeset) do
    case get_field(changeset, :slug) do
      nil ->
        title = get_field(changeset, :title)
        put_change(changeset, :slug, Slug.slugify(title))

      _ ->
        changeset
    end
  end

  # 當 changeset 未吻合檢驗，則直接傳送回去。
  defp maybe_generate_slug(changeset), do: changeset
end
