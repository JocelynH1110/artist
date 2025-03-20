defmodule Artist.Repo.Migrations.CreatePostCategories do
  use Ecto.Migration

  def change do
    create table(:post_categories) do
      add :post_id, references(:posts, on_delete: :delete_all), nill: false
      add :category_id, references(:categories, on_delete: :delete_all), nil: false

      timestamps(type: :utc_datetime)
    end

    # 在 post_id 欄位上建立索引，加速 post_id 篩選或排列查詢。例、尋找特定文章的所有分類
    create index(:post_categories, [:post_id])
    create index(:post_categories, [:category_id])
    create unique_index(:post_categories, [:post_id, :categoriy_id])
  end
end
