defmodule Artist.Repo.Migrations.CreatePostCategories do
  use Ecto.Migration

  def change do
    create table(:post_categories) do
      add :post_id, references(:posts, on_delete: :delete_all), nill: false
      add :category_id, references(:categories, on_delete: :delete_all), nil: false

      timestamps(type: :utc_datetime)
    end
  end
end
