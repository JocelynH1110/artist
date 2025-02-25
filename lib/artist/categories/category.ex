defmodule Artist.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :title, :string
    field :slug, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title, :slug])
    |> validate_required([:title])
    |> maybe_generate_slug()
    |> validate_format(:slug, ~r/^[a-z0-9]+(?:-[a-z0-9]+)*$/)
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
