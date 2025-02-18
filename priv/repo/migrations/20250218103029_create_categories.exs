defmodule Artist.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :title, :text, null: false
      add :slug, :text, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:categories, [:slug])
  end
end
